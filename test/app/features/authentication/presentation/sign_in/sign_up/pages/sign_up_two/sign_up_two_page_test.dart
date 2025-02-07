import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_page.dart';

import '../../../../../../../../utils/golden_tests.dart';
import '../../../../../../../../utils/mocktail_extension.dart';
import '../../../../../../../../utils/widget_test_steps.dart';
import '../../../../mocks/app_modules_mock.dart';
import '../../../../mocks/authentication_modules_mock.dart';

void main() {
  late UserRegisterFormFieldModel userFormField;
  late Key genreDropdownList;
  late Key raceDropdownList;
  late SignUpTwoController controller;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    userFormField = UserRegisterFormFieldModel();
    genreDropdownList = const Key('genreDropdownList');
    raceDropdownList = const Key('raceDropdownList');
    controller = SignUpTwoController(
        AuthenticationModulesMock.userRegisterRepository, userFormField);
  });

  group(SignUpTwoPage, () {
    testWidgets(
      'shows screen widgets',
      (tester) async {
        await theAppIsRunning(tester, SignUpTwoPage(controller: controller));

        // check if necessary widgets are present
        await iSeeText('Crie sua conta');
        await iSeeText('Nos conte um pouco mais sobre você.');
        await iSeeSingleTextInput(text: 'Apelido');
        await iSeeWidget(DropdownButtonFormField<String>,
            key: genreDropdownList);
        await iSeeWidget(DropdownButtonFormField<String>,
            key: raceDropdownList);
        await iSeeButton(text: 'Próximo');
      },
    );

    testWidgets(
      'checks the genre list',
      (tester) async {
        await theAppIsRunning(tester, SignUpTwoPage(controller: controller));
        final genreList = [
          'Feminino',
          'Masculino',
          'Homem Trans',
          'Mulher Trans',
          'Outro'
        ];

        for (final genre in genreList) {
          await iSeeWidget(DropdownButtonFormField<String>, text: genre);
          await iTapDropdownFormItem<String>(
            tester,
            key: genreDropdownList,
            item: genre,
          );
        }
      },
    );

    testWidgets(
      'checks the race list',
      (tester) async {
        await theAppIsRunning(tester, SignUpTwoPage(controller: controller));

        final raceList = [
          'Branca',
          'Parda',
          'Preta',
          'Indígena',
          'Amarela',
          'Não declarado'
        ];

        for (final race in raceList) {
          await iSeeWidget(DropdownButtonFormField<String>, text: race);
          await iTapDropdownFormItem<String>(
            tester,
            key: raceDropdownList,
            item: race,
          );
        }
      },
    );

    testWidgets(
      'does not forward for any invalid field',
      (tester) async {
        await theAppIsRunning(tester, SignUpTwoPage(controller: controller));
        await iTapText(tester, text: 'Próximo');
        await iSeeSingleTextInputErrorMessage(
          tester,
          text: 'Apelido',
          message: 'Apelido inválido para o sistema',
        );

        verifyNever(
          () => AppModulesMock.modularNavigator.pushNamed(
              '/authentication/signup/step3',
              arguments: any(named: 'arguments')),
        );
      },
    );

    testWidgets(
      'shows error for server-side error',
      (tester) async {
        when(() => AuthenticationModulesMock.userRegisterRepository.checkField(
              birthday: any(named: 'birthday'),
              cpf: any(named: 'cpf'),
              fullname: any(named: 'fullname'),
              cep: any(named: 'cep'),
              nickName: any(named: 'nickName'),
              genre: any(named: 'genre'),
              race: any(named: 'race'),
            )).thenFailure((_) => ServerFailure());

        await theAppIsRunning(tester, SignUpTwoPage(controller: controller));
        await iEnterIntoSingleTextInput(
          tester,
          text: 'Apelido',
          value: 'nickname',
        );

        await iTapDropdownFormItem<String>(
          tester,
          key: genreDropdownList,
          item: 'Mulher Trans',
        );

        await iEnterIntoSingleTextInput(
          tester,
          text: 'Nome social',
          value: 'Social Name',
        );

        await iTapDropdownFormItem<String>(
          tester,
          key: raceDropdownList,
          item: 'Não declarado',
        );

        await iTapText(tester, text: 'Próximo');
        await iSeeText(
            'O servidor está com problema neste momento, tente novamente.');
      },
    );

    testWidgets(
      'success validation forward to the next page',
      (tester) async {
        when(() => AuthenticationModulesMock.userRegisterRepository.checkField(
              birthday: any(named: 'birthday'),
              cpf: any(named: 'cpf'),
              fullname: any(named: 'fullname'),
              cep: any(named: 'cep'),
              nickName: any(named: 'nickName'),
              genre: any(named: 'genre'),
              race: any(named: 'race'),
            )).thenSuccess((_) => const ValidField());
        when(
          () => AppModulesMock.modularNavigator.pushNamed(
              '/authentication/signup/step3',
              arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await theAppIsRunning(tester, SignUpTwoPage(controller: controller));
        await iEnterIntoSingleTextInput(
          tester,
          text: 'Apelido',
          value: 'nickname',
        );

        await iTapDropdownFormItem<String>(
          tester,
          key: genreDropdownList,
          item: 'Mulher Trans',
        );

        await iEnterIntoSingleTextInput(
          tester,
          text: 'Nome social',
          value: 'Social Name',
        );

        await iTapDropdownFormItem<String>(
          tester,
          key: raceDropdownList,
          item: 'Não declarado',
        );

        await iTapText(tester, text: 'Próximo');

        verify(
          () => AppModulesMock.modularNavigator.pushNamed(
              '/authentication/signup/step3',
              arguments: any(named: 'arguments')),
        ).called(1);
      },
    );

    screenshotTest(
      'looks as expected',
      fileName: 'sign_up_step_2_page',
      pageBuilder: () => SignUpTwoPage(controller: controller),
    );
  });
}
