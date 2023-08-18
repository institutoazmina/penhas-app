import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:penhas/app/features/authentication/presentation/shared/login_button.dart';
import 'package:penhas/app/features/authentication/presentation/shared/password_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/shared/single_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_page.dart';

import '../../../../../utils/golden_tests.dart';

class MockAuthenticationRepository extends Mock
    implements IAuthenticationRepository {}

class MockPasswordValidator extends Mock implements PasswordValidator {}

class MockAppStateUseCase extends Mock implements AppStateUseCase {}

class MockHttpClient extends Mock implements http.Client {}

class MockILocalStorage extends Mock implements ILocalStorage {}

class FakeEmailAddress extends Fake implements EmailAddress {}

class FakeSignInPassword extends Fake implements SignInPassword {}

class MockModularNavigate extends Mock implements IModularNavigator {}

class FakeAppStateEntity extends Fake implements AppStateEntity {}

void main() {
  late IAuthenticationRepository authenticationRepository;
  late PasswordValidator passwordValidator;
  late AppStateUseCase appStateUseCase;
  late String validPassword;
  late String validEmail;
  late IModularNavigator modularNavigator;

  setUpAll(() {
    registerFallbackValue(FakeEmailAddress());
    registerFallbackValue(FakeSignInPassword());
  });

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
    passwordValidator = MockPasswordValidator();
    appStateUseCase = MockAppStateUseCase();
    validPassword = 'myStr0ngP4ssw0rd';
    validEmail = 'my@email.com';
    modularNavigator = MockModularNavigate();

    Modular.navigatorDelegate = modularNavigator;

    initModules([
      AppModule(),
      SignInModule()
    ], replaceBinds: [
      Bind<IAuthenticationRepository>((i) => authenticationRepository),
      Bind<PasswordValidator>((i) => passwordValidator),
      Bind<AppStateUseCase>((i) => appStateUseCase),
    ]);
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
    Modular.removeModule(AppModule());
  });

  group(SignInPage, () {
    testWidgets(
      'show screen widgets',
      (WidgetTester tester) async {
        await tester.pumpWidget(_loadSignInPage());

        // check if necessary widgets are present
        expect(find.text('E-mail'), findsOneWidget);
        expect(find.text('Senha'), findsOneWidget);
        expect(find.text('Esqueci minha senha'), findsOneWidget);
        expect(find.text('Termos de uso'), findsOneWidget);
        expect(find.text('Política de privacidade'), findsOneWidget);
      },
    );

    testWidgets(
      'empty email and empty password show a message error',
      (WidgetTester tester) async {
        const errorMessage =
            'E-mail e senha precisam estarem corretos para continuar.';
        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        expect(find.text(errorMessage), findsNothing);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'invalid email and valid password show a message error when tap LoginButton',
      (WidgetTester tester) async {
        const errorMessage =
            'E-mail e senha precisam estarem corretos para continuar.';

        when(() => passwordValidator.validate(any(), any()))
            .thenAnswer((i) => dartz.right(validPassword));

        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        expect(find.text(errorMessage), findsNothing);
        await tester.enterText(find.byType(SingleTextInput), 'my_mail');
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'valid email and invalid password show a message error when tap LoginButton',
      (WidgetTester tester) async {
        const errorMessage =
            'E-mail e senha precisam estarem corretos para continuar.';

        when(() => passwordValidator.validate(any(), any()))
            .thenAnswer((i) => dartz.left(EmptyRule()));

        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        expect(find.text(errorMessage), findsNothing);
        await tester.enterText(find.byType(SingleTextInput), validEmail);
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'displays error text for invalid email input',
      (WidgetTester tester) async {
        await tester.pumpWidget(_loadSignInPage());

        // Update email with a invalid email
        await tester.enterText(find.byType(SingleTextInput), 'invalidEmail');
        await tester.pump();

        // Fetching the TextField's
        TextField textField = tester
            .widget(find.byKey(const Key('singleTextInput'))) as TextField;
        InputDecoration? decoration = textField.decoration;
        expect(decoration?.errorText, 'Endereço de email inválido');
      },
    );

    testWidgets(
      'show error for invalid login',
      (WidgetTester tester) async {
        const errorMessage =
            'O servidor está com problema neste momento, tente novamente.';

        when(() => passwordValidator.validate(any(), any()))
            .thenAnswer((i) => dartz.right(validPassword));
        when(
          () => authenticationRepository.signInWithEmailAndPassword(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((i) async => dartz.left(ServerFailure()));

        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        expect(find.text(errorMessage), findsNothing);
        await tester.enterText(find.byType(SingleTextInput), validEmail);
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'deleted account redirect page',
      (WidgetTester tester) async {
        const sessionToken = 'sessionToken';
        when(() => passwordValidator.validate(any(), any()))
            .thenAnswer((i) => dartz.right(validPassword));
        when(
          () => authenticationRepository.signInWithEmailAndPassword(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (i) async => dartz.right(const SessionEntity(
              sessionToken: sessionToken, deletedScheduled: true)),
        );
        when(
          () => modularNavigator.pushNamed(any(),
              arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        await tester.enterText(find.byType(SingleTextInput), validEmail);
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();

        verify(() => modularNavigator.pushNamed(
              '/accountDeleted',
              arguments: sessionToken,
            )).called(1);
      },
    );

    testWidgets(
      'success login redirect page',
      (WidgetTester tester) async {
        const sessionToken = 'sessionToken';
        when(() => passwordValidator.validate(any(), any()))
            .thenAnswer((i) => dartz.right(validPassword));
        when(
          () => authenticationRepository.signInWithEmailAndPassword(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (i) async =>
              dartz.right(const SessionEntity(sessionToken: sessionToken)),
        );
        when(() => appStateUseCase.check())
            .thenAnswer((i) async => dartz.right(FakeAppStateEntity()));

        when(
          () => modularNavigator.popAndPushNamed(any(),
              arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        await tester.enterText(find.byType(SingleTextInput), validEmail);
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();

        verify(() => modularNavigator.popAndPushNamed('/mainboard',
            arguments: {'page': 'feed'})).called(1);
      },
    );
    group('golden tests', () {
      screenshotTest(
        'looks as expected',
        fileName: 'sign_in_page',
        pageBuilder: _loadSignInPage,
      );
    });
  });
}

Widget _loadSignInPage() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: SignInPage(),
    ),
  );
}
