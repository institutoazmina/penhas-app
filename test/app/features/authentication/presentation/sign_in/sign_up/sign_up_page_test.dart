import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_page.dart';

import '../../../../../../utils/golden_tests.dart';
import '../../../../../../utils/mocktail_extension.dart';
import '../../../../../../utils/widget_test_steps.dart';
import '../../mocks/app_modules_mock.dart';
import '../../mocks/authentication_modules_mock.dart';

void main() {
  late Key cepKey;
  late Key cpfKey;
  late SignUpController controller;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    cepKey = const Key('sign_up_cep');
    cpfKey = const Key('sign_up_cpf');
    controller =
        SignUpController(AuthenticationModulesMock.userRegisterRepository);
  });

  group(
    SignUpPage,
    () {
      testWidgets(
        'shows screen widgets',
        (tester) async {
          await theAppIsRunning(
              tester,
              SignUpPage(
                controller: controller,
              ));
          await iSeeText('Crie sua conta');
          await iSeeText(
              'Para sua segurança pedimos aos nossos usuários o CPF.');
          await iSeeSingleTextInput(text: 'Nome completo');
          await iSeeSingleTextInput(text: 'Data de nascimento');
          await iSeeSingleTextInput(key: cpfKey);
          await iSeeSingleTextInput(key: cepKey);
          await iSeeButton(text: 'Não sei o meu CEP');
          await iSeeButton(text: 'Próximo');
        },
      );

      testWidgets(
          'displays a warning message if an invalid value is entered in a widget',
          (tester) async {
        await theAppIsRunning(tester, SignUpPage(controller: controller));
        await iTapText(tester, text: 'Próximo');
        await iSeeSingleTextInputErrorMessage(tester,
            text: 'Nome completo', message: 'Nome inválido para o sistema');
        await iSeeSingleTextInputErrorMessage(tester,
            text: 'Data de nascimento', message: 'Data de nascimento inválida');
        await iSeeSingleTextInputErrorMessage(tester,
            key: cpfKey, message: 'CPF inválido');
        await iSeeSingleTextInputErrorMessage(tester,
            key: cepKey, message: 'CEP inválido');
      });

      testWidgets(
        'displays a server-side error message',
        (tester) async {
          when(
            () => AuthenticationModulesMock.userRegisterRepository.checkField(
              birthday: any(named: 'birthday'),
              cpf: any(named: 'cpf'),
              fullname: any(named: 'fullname'),
              cep: any(named: 'cep'),
            ),
          ).thenFailure((_) => ServerFailure());

          await theAppIsRunning(tester, SignUpPage(controller: controller));
          await iEnterIntoSingleTextInput(
            tester,
            text: 'Nome completo',
            value: 'Full Name',
          );
          await iEnterIntoSingleTextInput(
            tester,
            text: 'Data de nascimento',
            value: '01/01/2000',
          );
          await iEnterIntoSingleTextInput(
            tester,
            key: cpfKey,
            value: '248.744.831-86',
          );
          await iEnterIntoSingleTextInput(
            tester,
            key: cepKey,
            value: '01302-000',
          );
          await iTapText(tester, text: 'Próximo');
          await iSeeText(
              'O servidor está com problema neste momento, tente novamente.');
        },
      );

      testWidgets(
        'forward to the next step for valid form widgets',
        (tester) async {
          when(
            () => AuthenticationModulesMock.userRegisterRepository.checkField(
              birthday: any(named: 'birthday'),
              cpf: any(named: 'cpf'),
              fullname: any(named: 'fullname'),
              cep: any(named: 'cep'),
            ),
          ).thenSuccess((_) => const ValidField());

          when(() => AppModulesMock.modularNavigator
                  .pushNamed(any(), arguments: any(named: 'arguments')))
              .thenAnswer((i) => Future.value());

          await theAppIsRunning(tester, SignUpPage(controller: controller));
          await iEnterIntoSingleTextInput(
            tester,
            text: 'Nome completo',
            value: 'Full Name',
          );
          await iEnterIntoSingleTextInput(
            tester,
            text: 'Data de nascimento',
            value: '01/01/2000',
          );
          await iEnterIntoSingleTextInput(
            tester,
            key: cpfKey,
            value: '248.744.831-86',
          );
          await iEnterIntoSingleTextInput(
            tester,
            key: cepKey,
            value: '01302-000',
          );
          await iTapText(tester, text: 'Próximo');

          verify(() => AppModulesMock.modularNavigator.pushNamed(
              '/authentication/signup/step2',
              arguments: any(named: 'arguments'))).called(1);
        },
      );
      screenshotTest(
        'looks as expected',
        fileName: 'sign_up_step_1_page',
        pageBuilder: () => SignUpPage(controller: controller),
      );
    },
  );
}
