import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
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

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    userFormField = UserRegisterFormFieldModel();
    genreDropdownList = const Key('genreDropdownList');
    raceDropdownList = const Key('raceDropdownList');

    initModule(SignInModule(), replaceBinds: [
      Bind<SignUpTwoController>(
        (i) => SignUpTwoController(
            AuthenticationModulesMock.userRegisterRepository, userFormField),
      ),
    ]);
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
  });

  group(SignUpTwoPage, () {
    testWidgets(
      'shows screen widgets',
      (tester) async {
        await theAppIsRunning(tester, const SignUpTwoPage());

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
        await theAppIsRunning(tester, const SignUpTwoPage());
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
        await theAppIsRunning(tester, const SignUpTwoPage());

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
        await theAppIsRunning(tester, const SignUpTwoPage());
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

        await theAppIsRunning(tester, const SignUpTwoPage());
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

    screenshotTest(
      'looks as expected',
      fileName: 'sign_up_step_2_page',
      pageBuilder: () => const SignUpTwoPage(),
    );
  });
}
