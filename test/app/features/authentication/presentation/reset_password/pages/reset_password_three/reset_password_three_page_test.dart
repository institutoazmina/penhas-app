import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/extension/either.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_page.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';

import '../../../../../../../utils/golden_tests.dart';
import '../../../../../../../utils/mocktail_extension.dart';
import '../../../../../../../utils/widget_test_steps.dart';
import '../../../mocks/app_modules_mock.dart';
import '../../../mocks/authentication_modules_mock.dart';

class MockIChangePasswordRepository extends Mock implements IChangePasswordRepository{
  @override
  Future<Either<Failure, ValidField>> reset({EmailAddress? emailAddress,
    SignUpPassword? password,
    String? resetToken}) async {
    return Future.value(Right(ValidField())); 
  }
}


class MockIChangePasswordRepositoryWithError extends Mock implements IChangePasswordRepository{
  @override
  Future<Either<Failure, ValidField>> reset({EmailAddress? emailAddress,
    SignUpPassword? password,
    String? resetToken}) async {
    return Future.value(Left(ServerFailure())); 
  }
}

void main() {
  late UserRegisterFormFieldModel userRegisterFormField;
  late IChangePasswordRepository iChangePasswordRepository;
  late ResetPasswordThreeController controller;
  late UserRegisterFormFieldModel userRegisterFormFieldModel;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    userRegisterFormField = UserRegisterFormFieldModel();
    userRegisterFormField.token = 'token';
    iChangePasswordRepository = MockIChangePasswordRepository();
    userRegisterFormFieldModel = UserRegisterFormFieldModel();
    controller = ResetPasswordThreeController(iChangePasswordRepository, userRegisterFormFieldModel, AuthenticationModulesMock.passwordValidator);
  });

  group(ResetPasswordThreePage, () {
    testWidgets(
      'shows screen widgets',
      (tester) async {
        await theAppIsRunning(tester,  ResetPasswordThreePage(controller: controller,));

        // check that required widgets are present
        await iSeeText('Configure uma nova senha');
        await iSeeText('Crie uma senha diferente das anteriores');
        await iSeePasswordField(text: 'Senha');
        await iSeePasswordField(text: 'Confirmação de senha');
        await iSeeButton(text: 'Salvar');
      },
    );

    testWidgets(
      'invalid password shows hint message',
      (tester) async {
        when(() => AuthenticationModulesMock.passwordValidator.validate(
            any(), any())).thenAnswer((i) => failure(MinLengthRule()));

        // Input a invalid password
        await theAppIsRunning(tester,  ResetPasswordThreePage(controller: controller,));
        await iEnterIntoPasswordField(tester, text: 'Senha', password: '1');
        await iSeePasswordFieldErrorMessage(tester,
            text: 'Senha', message: 'Senha precisa ter no mínimo 8 caracteres');
      },
    );

    testWidgets(
      'shows an error message if the password field and password confirmation field are different',
      (tester) async {
        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((i) => success('password'));

        // Input a invalid password
        await theAppIsRunning(tester,  ResetPasswordThreePage(controller: controller,));
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: 'password');
        await iEnterIntoPasswordField(tester,
            text: 'Confirmação de senha', password: 'p4ssw0rd');
        await iSeePasswordFieldErrorMessage(tester,
            text: 'Confirmação de senha', message: 'As senhas não são iguais');
      },
    );

    testWidgets(
      'shows an error message from server side error when resetting the password',
      (tester) async {
        late IChangePasswordRepository iChangePasswordRepositoryError;

         iChangePasswordRepositoryError = MockIChangePasswordRepositoryWithError();

         final controllerError =  ResetPasswordThreeController(iChangePasswordRepositoryError, userRegisterFormFieldModel, AuthenticationModulesMock.passwordValidator);

        when(() => AppModulesMock.modularNavigator.pushNamedAndRemoveUntil(
  any(), any(), forRoot: any(named: 'forRoot')
)).thenAnswer((_) async => Future.value()); 
    
        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((i) => success('password'));

        when(() => AuthenticationModulesMock.changePasswordRepository.reset(
              emailAddress: any(named: 'emailAddress'),
              password: any(named: 'password'),
              resetToken: any(named: 'resetToken'),
            )).thenFailure((_) => ServerFailure());

        // Capture server side error message
        await theAppIsRunning(tester,  ResetPasswordThreePage(controller: controllerError,));
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: 'password');
        await iEnterIntoPasswordField(tester,
            text: 'Confirmação de senha', password: 'password');
        await iTapText(tester, text: 'Salvar');
        await tester.pumpAndSettle();
        await iSeeText(
            'O servidor está com problema neste momento, tente novamente.');
      },
    );

    testWidgets(
      'forward for a successful password reset',
      (tester) async {
        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((i) => success('password'));

        when(() => AuthenticationModulesMock.changePasswordRepository.reset(
              emailAddress: any(named: 'emailAddress'),
              password: any(named: 'password'),
              resetToken: any(named: 'resetToken'),
            )).thenSuccess((_) => const ValidField());

        when(() => AppModulesMock.modularNavigator.pushNamedAndRemoveUntil(
            any(), any())).thenAnswer((i) => Future.value());

        // Capture server side error message
        await theAppIsRunning(tester,  ResetPasswordThreePage(controller: controller,));
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: 'password');
        await iEnterIntoPasswordField(tester,
            text: 'Confirmação de senha', password: 'password');
        await iTapText(tester, text: 'Salvar');

        verify(() => AppModulesMock.modularNavigator
            .pushNamedAndRemoveUntil('/authentication', any())).called(1);
      },
    );

    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'reset_password_page_step_3',
        pageBuilder: () =>  ResetPasswordThreePage(controller: controller,),
      );
    });
  });
}
