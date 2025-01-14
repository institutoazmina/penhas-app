import 'package:dartz/dartz.dart' show right, left;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_assistant_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_available_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_main_tile_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/chat/domain/states/chat_main_talks_state.dart';
import 'package:penhas/app/features/chat/presentation/chat_main_module.dart';
import 'package:penhas/app/features/chat/presentation/talk/chat_main_talks_controller.dart';
import 'package:penhas/app/features/chat/presentation/talk/chat_main_talks_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/module_testing.dart';

class MockIChatMainTalksController extends Mock
    implements IChatMainTalksController {}

void main() {
  group(ChatMainTalksPage, () {
    late IChatChannelRepository mockRepository;
    late IModularNavigator mockNavigator;
    late IChatMainTalksController controller;

    setUp(() {
      mockRepository = _MockChatChannelRepository();
      controller = MockIChatMainTalksController();
      Modular.navigatorDelegate = mockNavigator = _MockModularNavigate();

      loadModules(
        [ChatMainModule()],
        overrides: [
          Bind<IChatChannelRepository>((i) => mockRepository),
        ],
      );

      when(() => mockRepository.listChannel()).thenAnswer(
        (_) async => right(_chatChannelAvailableFixture),
      );
    });

    screenshotTest('loaded state should be rendered',
        fileName: 'chat_main_talks_page_initial_state', pageBuilder: () {
      when(() => controller.currentState)
          .thenAnswer((_) => ChatMainTalksState.initial());

      return ChatMainTalksPage(
        controller: controller,
      );
    });

    screenshotTest(
      'error state should be rendered',
      fileName: 'chat_main_talks_page_error_state',
      pageBuilder: () => ChatMainTalksPage(
        controller: controller,
      ),
      setUp: () {
        when(() => controller.currentState)
            .thenAnswer((_) => ChatMainTalksState.error('error'));

        when(() => mockRepository.listChannel()).thenAnswer(
          (_) async => left(ServerFailure()),
        );
      },
    );

    testWidgets(
      'should navigate to assistant quiz when open assistant card',
      (tester) => mockNetworkImages(() async {
        final chatMainAssistantCardTile = ChatMainAssistantCardTile(cards: [
          ChatMainSupportTile(
            quizSession: QuizSessionEntity(
              sessionId: 'assistant-quiz-session',
            ),
            channel: ChatChannelEntity(
              token: 'assistant-channel',
              lastMessageIsMime: false,
              lastMessageTime: DateTime.parse('2024-03-02'),
              user: ChatUserEntity(
                userId: null,
                activity: null,
                blockedMe: false,
                avatar: null,
                nickname: 'Assistente PenhaS',
              ),
            ),
            content: 'content',
            title: 'Assistente PenhaS',
          )
        ]);
        when(() => controller.currentState).thenAnswer((_) =>
            ChatMainTalksState.loaded(
                <ChatMainAssistantCardTile>[chatMainAssistantCardTile]));

        when(() => controller.openAssistantCard(ChatMainSupportTile(
              quizSession: QuizSessionEntity(
                sessionId: 'assistant-quiz-session',
              ),
              channel: ChatChannelEntity(
                token: 'assistant-channel',
                lastMessageIsMime: false,
                lastMessageTime: DateTime.parse('2024-03-02'),
                user: ChatUserEntity(
                  userId: null,
                  activity: null,
                  blockedMe: false,
                  avatar: null,
                  nickname: 'Assistente PenhaS',
                ),
              ),
              content: 'content',
              title: 'Assistente PenhaS',
            ))).thenAnswer((_) async => Future.value());
        // arrange
        final widget = buildTestableWidget(ChatMainTalksPage(
          controller: controller,
        ));

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        when(
          () => mockNavigator.popAndPushNamed(
            any(),
            arguments: any(named: 'arguments'),
          ),
        ).thenAnswer((_) => Future.value());

        // act
        await tester.tap(find.text('Assistente PenhaS'));

        // assert
        verify(
          () => mockNavigator.popAndPushNamed(
            '/quiz?origin=chat',
            arguments: QuizSessionEntity(
              sessionId: 'assistant-quiz-session',
            ),
          ),
        ).called(1);
      }),
    );

    testWidgets(
      'should navigate to support chat when open support card',
      (tester) => mockNetworkImages(() async {
        final chatMainSupportTile = ChatMainSupportTile(
          quizSession: QuizSessionEntity(
            sessionId: 'assistant-quiz-session',
          ),
          channel: ChatChannelEntity(
            token: 'support-channel',
            lastMessageIsMime: false,
            lastMessageTime: DateTime.parse('2024-03-02'),
            user: ChatUserEntity(
              userId: null,
              activity: null,
              blockedMe: false,
              avatar: null,
              nickname: 'Suporte PenhaS',
            ),
          ),
          content: 'content',
          title: 'Suporte PenhaS',
        );
        when(() => controller.currentState).thenAnswer(
            (_) => ChatMainTalksState.loaded(<ChatMainAssistantCardTile>[
                  ChatMainAssistantCardTile(cards: [chatMainSupportTile])
                ]));

        when(() => controller.openAssistantCard(chatMainSupportTile))
            .thenAnswer((_) async => Future.value());

        // arrange
        final widget = buildTestableWidget(ChatMainTalksPage(
          controller: controller,
        ));
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        when(
          () => mockNavigator.pushNamed(
            any(),
            arguments: any(named: 'arguments'),
          ),
        ).thenAnswer((_) => Future.value(true));

        // act
        await tester.tap(find.text('Suporte PenhaS'));

        // assert
        // verifyZeroInteractions(mockNavigator);
        verify(
          () => mockNavigator.pushNamed(
            '/mainboard/chat/support-channel',
            arguments: ChatChannelOpenEntity(token: 'support-channel'),
          ),
        ).called(1);
      }),
    );

    testWidgets(
      'should navigate to chat page when open conversation card',
      (tester) => mockNetworkImages(() async {
        final chatChannelEntity = ChatChannelEntity(
          token: 'talk-with-mary',
          lastMessageIsMime: false,
          lastMessageTime: DateTime.parse('2024-03-02'),
          user: ChatUserEntity(
            userId: null,
            activity: 'Ativo',
            blockedMe: false,
            avatar: 'http://example.com/avatar.svg',
            nickname: 'Mary',
          ),
        );
        when(() => controller.currentState).thenAnswer((_) =>
            ChatMainTalksState.loaded(<ChatMainChannelCardTile>[
              ChatMainChannelCardTile(channel: chatChannelEntity)
            ]));

        when(() => controller.openChannel(chatChannelEntity))
            .thenAnswer((_) async => Future.value());

        // arrange
        final widget = buildTestableWidget(ChatMainTalksPage(
          controller: controller,
        ));
        await tester.pumpWidget(widget);
        chatChannelEntity;
        await tester.pumpAndSettle();
        when(
          () => mockNavigator.pushNamed(
            any(),
            arguments: any(named: 'arguments'),
          ),
        ).thenAnswer((_) => Future.value(true));

        // act
        await tester.tap(find.text('Mary'));

        // assert
        verify(() => controller.openChannel(chatChannelEntity)).called(1);
        verify(
          () => mockNavigator.pushNamed(
            '/mainboard/chat/talk-with-mary',
            arguments: ChatChannelOpenEntity(token: 'talk-with-mary'),
          ),
        ).called(1);
      }),
    );
  });
}

class _MockModularNavigate extends Mock implements IModularNavigator {}

class _MockChatChannelRepository extends Mock
    implements IChatChannelRepository {}

final _chatChannelAvailableFixture = ChatChannelAvailableEntity(
  assistant: ChatAssistantEntity(
    avatar: null,
    quizSession: QuizSessionEntity(
      sessionId: 'assistant-quiz-session',
    ),
    title: 'Assistente PenhaS',
    subtitle: 'Entenda como posso te ajudar',
  ),
  support: ChatChannelEntity(
    token: 'support-channel',
    lastMessageIsMime: false,
    lastMessageTime: DateTime.parse('2024-03-02'),
    user: ChatUserEntity(
      userId: null,
      activity: null,
      blockedMe: false,
      avatar: null,
      nickname: 'Suporte PenhaS',
    ),
  ),
  channels: [
    ChatChannelEntity(
      token: 'talk-with-mary',
      lastMessageIsMime: false,
      lastMessageTime: DateTime.parse('2024-03-02'),
      user: ChatUserEntity(
        userId: null,
        activity: 'Ativo',
        blockedMe: false,
        avatar: 'http://example.com/avatar.svg',
        nickname: 'Mary',
      ),
    ),
    ChatChannelEntity(
      token: 'talk-with-annie',
      lastMessageIsMime: false,
      lastMessageTime: DateTime.parse('2024-03-02'),
      user: ChatUserEntity(
        userId: null,
        activity: 'Há 1 minuto',
        blockedMe: true,
        avatar: 'http://example.com/avatar.svg',
        nickname: 'Annie',
      ),
    ),
  ],
  hasMore: false,
  nextPage: null,
);
