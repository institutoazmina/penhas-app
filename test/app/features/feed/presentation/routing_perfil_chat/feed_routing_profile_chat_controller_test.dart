import 'dart:async' as async;

import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/feed/domain/states/feed_router_type.dart';
import 'package:penhas/app/features/feed/domain/states/feed_routing_state.dart';
import 'package:penhas/app/features/feed/presentation/routing_perfil_chat/feed_routing_profile_chat_controller.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_entity.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';

typedef Completer<T> = async.Completer<Either<Failure, T>>;

class MockUsersRepository extends Mock implements IUsersRepository {}

class MockChatChannelRepository extends Mock implements IChatChannelRepository {
}

class MockModularNavigate extends Mock implements IModularNavigator {}

void main() {
  group(FeedRoutingProfileChatController, () {
    late FeedRoutingProfileChatController controller;

    late IUsersRepository mockUsersRepository;
    late IChatChannelRepository mockChatChannelRepository;
    late IModularNavigator mockNavigator;

    FeedRoutingProfileChatController initController(
            FeedRouterType routerType) =>
        FeedRoutingProfileChatController(
          usersRepository: mockUsersRepository,
          channelRepository: mockChatChannelRepository,
          routerType: routerType,
        );

    setUp(() {
      Modular.navigatorDelegate = mockNavigator = MockModularNavigate();

      mockUsersRepository = MockUsersRepository();
      mockChatChannelRepository = MockChatChannelRepository();

      when(
        () => mockNavigator.pushReplacementNamed(
          any(),
          arguments: any(named: 'arguments'),
        ),
      ).thenAnswer((_) async => null);
    });

    group('init', () {
      group('with FeedRouterType.profile', () {
        late Completer<UserDetailEntity> completer;
        const feedRouterType = FeedRouterType.profile(2);

        setUp(() {
          completer = Completer();

          when(() => mockUsersRepository.profileDetail('2'))
              .thenAnswer((_) async => completer.future);

          controller = initController(feedRouterType);
        });

        test(
          'should emit initial state',
          () async {
            // assert
            expect(
              controller.routingState,
              const FeedRoutingState.initial('Perfil'),
            );
          },
        );

        test(
          'should call profileDetail',
          () async {
            // assert
            verify(() => mockUsersRepository.profileDetail('2')).called(1);
            verifyNoMoreInteractions(mockUsersRepository);
          },
        );

        test(
          'should navigate to profile page',
          () async {
            // arrange
            const profile = UserDetailEntity(
              isMyself: true,
              profile: UserDetailProfileEntity(
                nickname: 'Lily',
                activity: null,
                avatar: 'https://example.com/avatar.png',
                clientId: 123,
                miniBio: 'my bio',
                skills: 'all skills',
              ),
            );

            // act
            completer.complete(right(profile));
            await completer.future;

            // assert
            verify(
              () => mockNavigator.pushReplacementNamed(
                '/mainboard/users/profile_from_feed',
                arguments: profile,
              ),
            ).called(1);
            verifyNoMoreInteractions(mockNavigator);
          },
        );

        test(
          'should emit error state when failure',
          () async {
            // act
            completer.complete(left(ServerFailure()));
            await completer.future;

            // assert
            expect(
              controller.routingState,
              const FeedRoutingState.error(
                'Perfil',
                'O servidor está com problema neste momento, tente novamente.',
              ),
            );
          },
        );
      });

      group('with FeedRouterType.chat', () {
        late Completer<ChatChannelOpenEntity> completer;
        const feedRouterType = FeedRouterType.chat(1);

        setUp(() {
          completer = Completer();

          when(() => mockChatChannelRepository.openChannel('1'))
              .thenAnswer((_) async => completer.future);

          controller = initController(feedRouterType);
        });

        test(
          'should emit initial state',
          () async {
            // assert
            expect(
              controller.routingState,
              const FeedRoutingState.initial('Chat'),
            );
          },
        );

        test(
          'should call openChannel',
          () async {
            // assert
            verify(() => mockChatChannelRepository.openChannel('1')).called(1);
            verifyNoMoreInteractions(mockChatChannelRepository);
          },
        );

        test(
          'should navigate to chat page',
          () async {
            // arrange
            const chat = ChatChannelOpenEntity(
              token: 'chat token',
              session: null,
            );

            // act
            completer.complete(right(chat));
            await completer.future;

            // assert
            verify(
              () => mockNavigator.pushReplacementNamed(
                '/mainboard/chat_from_feed',
                arguments: chat,
              ),
            ).called(1);
            verifyNoMoreInteractions(mockNavigator);
          },
        );

        test(
          'should emit error state when failure',
          () async {
            // act
            completer.complete(left(ServerFailure()));
            await completer.future;

            // assert
            expect(
              controller.routingState,
              const FeedRoutingState.error(
                'Chat',
                'O servidor está com problema neste momento, tente novamente.',
              ),
            );
          },
        );
      });
    });

    group('retry', () {
      test(
        'with FeedRouterType.profile should call profileDetail',
        () async {
          // arrange
          final completer = Completer<UserDetailEntity>();

          when(() => mockUsersRepository.profileDetail('2'))
              .thenAnswer((_) async => completer.future);

          controller = initController(const FeedRouterType.profile(2));
          clearInteractions(mockUsersRepository);

          // act
          controller.retry();

          // assert
          verify(() => mockUsersRepository.profileDetail('2')).called(1);
          verifyNoMoreInteractions(mockUsersRepository);
        },
      );

      test(
        'with FeedRouterType.chat should call openChannel',
        () async {
          // arrange
          final completer = Completer<ChatChannelOpenEntity>();

          when(() => mockChatChannelRepository.openChannel('1'))
              .thenAnswer((_) async => completer.future);

          controller = initController(const FeedRouterType.chat(1));
          clearInteractions(mockChatChannelRepository);

          // act
          controller.retry();

          // assert
          verify(() => mockChatChannelRepository.openChannel('1')).called(1);
          verifyNoMoreInteractions(mockChatChannelRepository);
        },
      );
    });
  });
}
