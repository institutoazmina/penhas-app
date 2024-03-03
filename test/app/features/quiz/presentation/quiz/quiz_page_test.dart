import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:dartz/dartz.dart' show left, right;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/remoteconfig/i_remote_config.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/help_center/presentation/pages/tutorial/guardian/guardian_tutorial_page.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';
import 'package:penhas/app/features/quiz/domain/repositories/i_quiz_repository.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_controller.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_page.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_page.dart';
import 'package:penhas/app/features/quiz/quiz_module.dart';
import 'package:penhas/app/shared/navigation/app_navigator.dart';
import 'package:penhas/app/shared/navigation/app_route.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/module_testing.dart';
import '../../../../../utils/widget_tester_ext.dart';

late IModularNavigator _mockNavigator;

void main() {
  group(QuizPage, () {
    late AppNavigator _mockAppNavigator;
    late IRemoteConfigService mockRemoteConfig;

    setUpAll(() {
      registerFallbackValue(_FakeQuizRequestEntity());
      registerFallbackValue(_FakeAppRoute());
    });

    setUp(() {
      _mockAppNavigator = _MockAppNavigator();
      Modular.navigatorDelegate = _mockNavigator = _MockModularNavigate();
      mockRemoteConfig = _MockRemoteConfig();

      when(() => mockRemoteConfig.getBool(any())).thenReturn(false);
    });

    testWidgets(
      'should start with QuizStartPage widget',
      (tester) async {
        // arrange
        when(() => _mockNavigator.args).thenReturn(
          ModularArguments(
            data: QuizSessionEntity(
              sessionId: 'SID',
            ),
          ),
        );

        await tester.pumpWidget(
          buildTestableApp(
            initialRoute: '/quiz',
            overrides: [
              Bind.factory<IQuizRepository>(
                (i) => _MockQuizRepository(),
              ),
              Bind.factory<AppStateUseCase>(
                (i) => _MockAppStateUseCase(),
              ),
              Bind<IRemoteConfigService>((i) => mockRemoteConfig),
            ],
          ),
        );

        // act
        await tester.pump();

        // assert
        expect(find.byType(QuizPage), findsOneWidget);
      },
    );

    group('conversation', () {
      late IQuizRepository mockRepository;
      late AppStateUseCase mockAppState;
      late ILocationServices mockLocationServices;

      setUp(() {
        mockRepository = _MockQuizRepository();
        mockAppState = _MockAppStateUseCase();
        mockLocationServices = _MockLocationServices();

        when(
          () => mockRepository.update(quiz: any(named: 'quiz')),
        ).thenAnswer(
          (_) async => right(
            AppStateEntity(
              appMode: AppStateModeEntity(),
              modules: [],
              quizSession: QuizSessionEntity(sessionId: 'SID', currentMessage: [
                QuizMessageEntity(
                  type: QuizMessageType.displayText,
                  ref: 'REF',
                  content: 'thanks for your answer',
                ),
              ]),
              userProfile: _FakeUserProfileEntity(),
            ),
          ),
        );

        initModules(
          [
            AppModule(),
            QuizModule(),
          ],
          replaceBinds: [
            Bind.factory<IQuizRepository>(
              (i) => mockRepository,
            ),
            Bind.factory<AppStateUseCase>(
              (i) => mockAppState,
            ),
            Bind.factory<ILocationServices>(
              (i) => mockLocationServices,
            ),
            Bind.factory<AppNavigator>(
              (i) => _mockAppNavigator,
            ),
            Bind<IRemoteConfigService>(
              (i) => mockRemoteConfig,
            ),
          ],
        );
      });

      tearDown(() {
        Modular.removeModule(AppModule());
        Modular.removeModule(QuizModule());
      });

      screenshotTest(
        'empty state should looks as expected',
        fileName: 'quiz_empty_state',
        setUp: () {
          when(() => _mockNavigator.args).thenReturn(
            ModularArguments(
              data: QuizSessionEntity(
                sessionId: 'SID',
              ),
            ),
          );
        },
        pageBuilder: () => QuizPage(),
      );

      screenshotTest(
        'error state should looks as expected',
        fileName: 'quiz_error_state',
        setUp: () {
          when(() => _mockNavigator.args).thenReturn(
            ModularArguments(
              data: QuizSessionEntity(
                sessionId: 'SID',
                currentMessage: [
                  QuizMessageEntity(
                    type: QuizMessageType.button,
                    ref: 'REF',
                    content: 'please click the button',
                    buttonLabel: 'OK',
                  ),
                ],
              ),
            ),
          );
        },
        pageBuilder: () => QuizPage(),
        pumpBeforeTest: (tester) async {
          when(
            () => mockRepository.update(quiz: any(named: 'quiz')),
          ).thenAnswer((_) async => left(ServerFailure()));

          await tester.tapAll(find.text('OK'));
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        'should navigate to end screen when quiz is finished',
        (tester) async {
          // arrange
          final appStateEntity = AppStateEntity(
            quizSession: QuizSessionEntity(
              sessionId: 'session',
              endScreen: '/end',
              isFinished: true,
            ),
            userProfile: _FakeUserProfileEntity(),
            appMode: AppStateModeEntity(),
            modules: [],
          );
          when(() => _mockNavigator.args).thenReturn(
            ModularArguments(
              data: QuizSessionEntity(
                sessionId: 'session-id',
                currentMessage: [
                  QuizMessageEntity(
                    type: QuizMessageType.button,
                    ref: 'reference',
                    content: 'please click the button',
                    buttonLabel: 'OK',
                  ),
                ],
              ),
            ),
          );
          when(() => mockRepository.update(quiz: any(named: 'quiz')))
              .thenAnswer((_) async => right(appStateEntity));
          when(() => mockAppState.check())
              .thenAnswer((_) async => right(appStateEntity));
          when(
            () => _mockAppNavigator.pushAndRemoveUntil(
              any(),
              removeUntil: any(named: 'removeUntil'),
            ),
          ).thenAnswer((_) => Future.value());
          await tester.pumpWidget(buildTestableWidget(QuizPage()));

          // act
          await tester.tapAll(find.text('OK'));
          await tester.pumpAndSettle();

          // assert
          verifyInOrder([
            () => mockRepository.update(
                  quiz: QuizRequestEntity(
                    sessionId: 'session-id',
                    options: {'reference': '1'},
                  ),
                ),
            () => mockAppState.check(),
            () => _mockAppNavigator.pushAndRemoveUntil(
                  AppRoute('/end'),
                  removeUntil: '/',
                ),
          ]);
          verifyNoMoreInteractions(mockRepository);
          verifyNoMoreInteractions(mockAppState);
          verifyNoMoreInteractions(_mockAppNavigator);
        },
      );

      quizMessageTestGroup(
        'given message of type yesno',
        QuizMessageEntity(
          ref: 'REF',
          type: QuizMessageType.yesno,
          content: 'yes or no?',
        ),
        (scope) {
          scope.screenshotReceived('should display received yesno message');

          scope.screenshotReplyed(
            'should display replyed yesno message',
            (tester) async {
              await tester.tapAll(find.text('SIM'));
            },
          );
        },
      );

      quizMessageTestGroup(
        'given message of type displayText',
        QuizMessageEntity(
          type: QuizMessageType.displayText,
          content: 'Just a text',
        ),
        (scope) {
          setUp(() {
            when(
              () => mockRepository.update(quiz: any(named: 'quiz')),
            ).thenAnswer(
              (_) async => right(
                AppStateEntity(
                  appMode: AppStateModeEntity(),
                  modules: [],
                  quizSession: QuizSessionEntity(sessionId: 'SID'),
                  userProfile: _FakeUserProfileEntity(),
                ),
              ),
            );
          });

          scope.screenshotReceived(
            'should display received displayText message',
          );

          scope.screenshotReplyed(
            'when unknown replay should display fallback message',
            (tester) async {
              tester
                  .withViewController<QuizPage, QuizPageState, QuizController>(
                (controller) async {
                  controller.onActionReply({});
                },
              );
              await tester.pumpAndSettle();
            },
          );
        },
      );

      quizMessageTestGroup(
        'given message of type displayTextResponse',
        QuizMessageEntity(
          type: QuizMessageType.displayTextResponse,
          content: 'Just a text response',
        ),
        (scope) {
          setUp(() {
            when(
              () => mockRepository.update(quiz: any(named: 'quiz')),
            ).thenAnswer(
              (_) async => right(
                AppStateEntity(
                  appMode: AppStateModeEntity(),
                  modules: [],
                  quizSession: QuizSessionEntity(sessionId: 'SID'),
                  userProfile: _FakeUserProfileEntity(),
                ),
              ),
            );
          });

          scope.screenshotReceived(
            'should display received displayTextResponse message',
          );

          scope.screenshotReplyed(
            'when unknown replay should display fallback message',
            (tester) async {
              tester
                  .withViewController<QuizPage, QuizPageState, QuizController>(
                (controller) async {
                  controller.onActionReply({});
                },
              );
              await tester.pumpAndSettle();
            },
          );
        },
      );

      quizMessageTestGroup(
        'given message of type showHelpTutorial',
        QuizMessageEntity(
          type: QuizMessageType.showHelpTutorial,
          ref: 'REF',
          content: 'show help tutorial',
          buttonLabel: 'Show Tutorial',
        ),
        (scope) {
          scope.screenshotReceived(
            'should display received showHelpTutorial message',
          );

          testWidgets(
            'should open GuardianTutorialPage when Show Tutorial button is pressed',
            (tester) async {
              // arrange
              when(() => mockLocationServices.isPermissionGranted())
                  .thenAnswer((_) async => true);

              await tester.pumpWidget(buildTestableWidget(QuizPage()));

              // act
              await tester.tap(find.text('Show Tutorial'));
              await tester.pumpAndSettle();

              // assert
              expect(find.byType(GuardianTutorialPage), findsOneWidget);
            },
          );

          scope.screenshotReplyed(
            'should display replyed showHelpTutorial message',
            (tester) async {
              await tester.tapAll(find.text('Show Tutorial'));
              await tester.pumpAndSettle();
              await tester.tapAll(find.byIcon(Icons.cancel));
            },
          );
        },
      );

      quizMessageTestGroup(
        'given message of type showStealthTutorial',
        QuizMessageEntity(
          type: QuizMessageType.showStealthTutorial,
          ref: 'REF',
          content: 'show stealth tutorial',
          buttonLabel: 'Show Tutorial',
        ),
        (scope) {
          scope.screenshotReceived(
            'should display received showStealthTutorial message',
          );

          testWidgets(
            'should open StealthModeTutorialPage when Show Tutorial button is pressed',
            (tester) async {
              // arrange
              when(() => mockLocationServices.isPermissionGranted())
                  .thenAnswer((_) async => true);

              await tester.pumpWidget(buildTestableWidget(QuizPage()));

              // act
              await tester.tap(find.text('Show Tutorial'));
              await tester.pumpAndSettle();

              // assert
              expect(find.byType(StealthModeTutorialPage), findsOneWidget);
            },
          );

          scope.screenshotReplyed(
            'should display replyed showStealthTutorial message',
            (tester) async {
              when(() => mockLocationServices.isPermissionGranted())
                  .thenAnswer((_) async => true);

              await tester.tapAll(find.text('Show Tutorial'));
              await tester.pumpAndSettle();
              await tester.tapAll(find.byIcon(Icons.cancel));
            },
          );
        },
      );

      quizMessageTestGroup(
        'given message of type button',
        QuizMessageEntity(
          type: QuizMessageType.button,
          ref: 'REF',
          content: 'please click the button',
          buttonLabel: 'Click Me',
        ),
        (scope) {
          scope.screenshotReceived('should display received button message');

          scope.screenshotReplyed(
            'should display replyed button message',
            (tester) async {
              await tester.tapAll(find.text('Click Me'));
            },
          );
        },
      );

      quizMessageTestGroup(
        'given message of type horizontalButtons',
        QuizMessageEntity(
          type: QuizMessageType.horizontalButtons,
          ref: 'REF',
          content: 'click one of the options',
          options: [
            QuizMessageChoiceOption(
              display: 'Option 1',
              index: '1',
            ),
            QuizMessageChoiceOption(
              display: 'Option 3',
              index: '3',
            ),
            QuizMessageChoiceOption(
              display: 'Option 2',
              index: '2',
            ),
          ],
        ),
        (scope) {
          scope.screenshotReceived(
            'should display received horizontalButtons message',
          );

          scope.screenshotReplyed(
            'should display replyed horizontalButtons message',
            (tester) async {
              await tester.tapAll(find.text('OPTION 3'));
            },
          );
        },
      );

      quizMessageTestGroup(
        'given message of type singleChoice',
        QuizMessageEntity(
          type: QuizMessageType.singleChoice,
          ref: 'REF',
          content: 'witch one?',
          options: [
            QuizMessageChoiceOption(
              display: 'Option 1',
              index: '1',
            ),
            QuizMessageChoiceOption(
              display: 'Option 3',
              index: '3',
            ),
            QuizMessageChoiceOption(
              display: 'Option 2',
              index: '2',
            ),
          ],
        ),
        (scope) {
          scope.screenshotReceived(
            'should display received singleChoice message',
          );

          scope.screenshotReplyed(
            'should display replyed singleChoice message',
            (tester) async {
              final texts = ['Option 1', 'Option 2', 'Option 1'];
              for (final text in texts) {
                await tester.tapAll(find.text(text));
                await tester.pumpAndSettle();
              }
              await tester.tapAll(find.text('Enviar'));
            },
          );
        },
      );

      quizMessageTestGroup(
        'given message of type multipleChoices',
        QuizMessageEntity(
          type: QuizMessageType.multipleChoices,
          ref: 'REF',
          content: 'you can select multiple options',
          options: [
            QuizMessageChoiceOption(
              display: 'Option 1',
              index: '1',
            ),
            QuizMessageChoiceOption(
              display: 'Option 3',
              index: '3',
            ),
            QuizMessageChoiceOption(
              display: 'Option 2',
              index: '2',
            ),
          ],
        ),
        (scope) {
          scope.screenshotReceived(
            'should display received multipleChoices message',
          );

          scope.screenshotReplyed(
            'should display replyed multipleChoices message',
            (tester) async {
              final texts = ['Option 1', 'Option 2', 'Option 1', 'Option 3'];
              for (final text in texts) {
                await tester.tapAll(find.text(text));
                await tester.pumpAndSettle();
              }
              await tester.tapAll(find.text('Enviar'));
            },
          );
        },
      );
    });
  });
}

@isTestGroup
void quizMessageTestGroup(
  Object description,
  QuizMessageEntity message,
  void Function(QuizMessageTestScope scope) body,
) {
  group(description, () {
    setUp(() {
      when(() => _mockNavigator.args).thenReturn(
        ModularArguments(
          data: QuizSessionEntity(
            sessionId: 'session_id',
            currentMessage: [message],
          ),
        ),
      );
    });

    body(QuizMessageTestScope(message));
  });
}

class QuizMessageTestScope {
  QuizMessageTestScope(this.message);

  final QuizMessageEntity message;

  @isTest
  FutureOr<void> screenshotReceived(String description) {
    screenshotTest(
      description,
      fileName: 'quiz_${message.type.name}_received',
      pageBuilder: () => QuizPage(),
    );
  }

  @isTest
  FutureOr<void> screenshotReplyed(String description, PumpAction action) {
    screenshotTest(
      description,
      fileName: 'quiz_${message.type.name}_replyed',
      pageBuilder: () => QuizPage(),
      pumpBeforeTest: action,
    );
  }
}

class _MockModularNavigate extends Mock implements IModularNavigator {}

class _MockAppStateUseCase extends Mock implements AppStateUseCase {}

class _MockQuizRepository extends Mock implements IQuizRepository {}

class _MockLocationServices extends Mock implements ILocationServices {}

class _MockAppNavigator extends Mock implements AppNavigator {}

class _MockRemoteConfig extends Mock implements IRemoteConfigService {}

class _FakeQuizRequestEntity extends Fake implements QuizRequestEntity {}

class _FakeUserProfileEntity extends Fake implements UserProfileEntity {}

class _FakeAppRoute extends Fake implements AppRoute {}
