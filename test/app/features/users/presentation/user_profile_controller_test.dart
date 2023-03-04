import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/usecases/get_chat_channel_token_usecase.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_entity.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';
import 'package:penhas/app/features/users/presentation/user_profile_controller.dart';
import 'package:penhas/app/features/users/presentation/user_profile_state.dart';

class MockGetChatChannelTokenUseCase extends Mock
    implements GetChatChannelTokenUseCase {}

class MockModularNavigator extends Mock implements IModularNavigator {}

void main() {
  group(UserProfileController, () {
    late UserProfileController controller;

    late GetChatChannelTokenUseCase mockGetChatChannelTokenUseCase;
    late IModularNavigator mockNavigator;
    const clientId = 123;

    const user = UserDetailEntity(
      isMyself: false,
      profile: UserDetailProfileEntity(
        nickname: 'nickname',
        activity: null,
        avatar: 'profile.svg',
        clientId: clientId,
        miniBio: 'a mini bio',
        skills: 'many skills',
      ),
    );

    setUp(() {
      mockGetChatChannelTokenUseCase = MockGetChatChannelTokenUseCase();

      controller = UserProfileController(
        person: user,
        getChatChannelToken: mockGetChatChannelTokenUseCase,
      );

      mockNavigator = Modular.navigatorDelegate = MockModularNavigator();
      when(
        () => mockNavigator.pushReplacementNamed(
          any(),
          arguments: any(named: 'arguments'),
        ),
      ).thenAnswer((_) async => null);
    });

    test(
      'shoult load initial state',
      () async {
        expect(controller.state, const UserProfileState.loaded(user));
      },
    );
    group('openChannel', () {
      test(
        'should call GetChatChannelTokenUseCase',
        () async {
          // arrange
          const chat = ChatChannelOpenEntity(token: 'token');
          when(() => mockGetChatChannelTokenUseCase(clientId))
              .thenAnswer((_) async => right(chat));

          // act
          await controller.openChannel();

          // assert
          verify(() => mockGetChatChannelTokenUseCase(clientId)).called(1);
        },
      );

      test(
        'should navigate to chat when success',
        () async {
          // arrange
          const chatToken = 'chat-token';
          const chat = ChatChannelOpenEntity(token: chatToken);
          when(() => mockGetChatChannelTokenUseCase(clientId))
              .thenAnswer((_) async => right(chat));

          // act
          await controller.openChannel();

          // assert
          verify(
            () => mockNavigator.pushReplacementNamed(
              '/mainboard/chat/$chatToken',
              arguments: chat,
            ),
          ).called(1);
        },
      );

      test(
        'should set reaction to null when success',
        () async {
          // arrange
          const chat = ChatChannelOpenEntity(token: '');
          when(() => mockGetChatChannelTokenUseCase(clientId))
              .thenAnswer((_) async => right(chat));

          // act
          await controller.openChannel();

          // assert
          expect(controller.reaction, isNull);
        },
      );

      test(
        'should set reaction to showSnackBar when failure',
        () async {
          // arrange
          when(() => mockGetChatChannelTokenUseCase(clientId))
              .thenAnswer((_) async => left(ServerFailure()));

          // act
          await controller.openChannel();

          // assert
          expect(
            controller.reaction,
            UserProfileReaction.showSnackBar(
              'O servidor está com problema neste momento, tente novamente.',
            ),
          );
        },
      );
    });
  });
}
