import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/usecases/get_chat_channel_token_usecase.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_entity.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';
import 'package:penhas/app/features/users/domain/usecases/report_user_usecase.dart';
import 'package:penhas/app/features/users/presentation/user_profile_controller.dart';
import 'package:penhas/app/features/users/presentation/user_profile_state.dart';

class MockGetChatChannelTokenUseCase extends Mock
    implements GetChatChannelTokenUseCase {}

class MockReportUserUseCase extends Mock implements ReportUserUseCase {}

class MockModularNavigator extends Mock implements IModularNavigator {}

void main() {
  group(UserProfileController, () {
    late UserProfileController controller;

    late GetChatChannelTokenUseCase mockGetChatChannelTokenUseCase;
    late ReportUserUseCase mockReportUserUseCase;

    late IModularNavigator mockNavigator;
    const clientId = 123;

    const profile = UserDetailProfileEntity(
      nickname: 'nickname',
      activity: null,
      avatar: 'profile.svg',
      clientId: clientId,
      miniBio: 'a mini bio',
      skills: 'many skills',
    );
    const user = UserDetailEntity(
      isMyself: false,
      profile: profile,
    );

    setUp(() {
      mockGetChatChannelTokenUseCase = MockGetChatChannelTokenUseCase();
      mockReportUserUseCase = MockReportUserUseCase();

      controller = UserProfileController(
        person: user,
        getChatChannelToken: mockGetChatChannelTokenUseCase,
        reportUser: mockReportUserUseCase,
      );

      mockNavigator = Modular.navigatorDelegate = MockModularNavigator();
      when(
        () => mockNavigator.pushReplacementNamed(
          any(),
          arguments: any(named: 'arguments'),
        ),
      ).thenAnswer((_) async => null);
    });

    group('init', () {
      test(
        'should load initial state',
        () async {
          expect(controller.state, const UserProfileState.loaded(user));
        },
      );

      test(
        'should load hidden menu state',
        () async {
          // arrange
          const user = UserDetailEntity(
            isMyself: true,
            profile: profile,
          );

          // act
          controller = UserProfileController(
            person: user,
            getChatChannelToken: mockGetChatChannelTokenUseCase,
            reportUser: mockReportUserUseCase,
          );

          // assert
          expect(controller.menuState, const UserMenuState.hidden());
        },
      );

      test(
        'should load visible menu state',
        () async {
          // arrange
          const user = UserDetailEntity(
            isMyself: false,
            profile: profile,
          );

          // act
          controller = UserProfileController(
            person: user,
            getChatChannelToken: mockGetChatChannelTokenUseCase,
            reportUser: mockReportUserUseCase,
          );

          // assert
          expect(controller.menuState, const UserMenuState.visible());
        },
      );
    });

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

    test(
      'onTapMenuOptions should set reaction to showProfileOptions',
      () async {
        // arrange
        final expected = UserProfileReaction.showProfileOptions();

        // act
        controller.onTapMenuOptions();

        // assert
        expect(controller.reaction, expected);
      },
    );

    group('onOptionSelected', () {
      test(
        'should set reaction to null when option is null',
        () async {
          // act
          controller.onOptionSelected(null);

          // assert
          expect(controller.reaction, isNull);
        },
      );

      test(
        'should set reaction to askReportReasonDialog when option is report',
        () async {
          // act
          controller.onOptionSelected(UserProfileSelectedOption.report());

          // assert
          expect(
            controller.reaction,
            UserProfileReaction.askReportReasonDialog(),
          );
        },
      );
    });

    group('onSendReportPressed', () {
      test(
        'should call ReportUserUseCase',
        () async {
          // arrange
          const reason = 'Hate speech';
          when(
            () => mockReportUserUseCase(
              clientId: '$clientId',
              reason: reason,
            ),
          ).thenAnswer(
            (_) async => right(const ValidField(message: 'message')),
          );

          // act
          controller.onSendReportPressed(reason);

          // assert
          verify(
            () => mockReportUserUseCase(
              clientId: '$clientId',
              reason: reason,
            ),
          ).called(1);
        },
      );

      test(
        'should set reaction to showProgressDialog',
        () async {
          // arrange
          const reason = 'Hate speech';
          when(
            () => mockReportUserUseCase(
              clientId: '$clientId',
              reason: reason,
            ),
          ).thenAnswer(
            (_) => Future.delayed(const Duration(seconds: 1)).then(
              (_) => right(
                const ValidField(message: 'message'),
              ),
            ),
          );

          // act
          controller.onSendReportPressed(reason);

          // assert
          expect(
            controller.reaction,
            UserProfileReaction.showProgressDialog(),
          );
        },
      );

      test(
        'should set reaction to showSnackBar when success',
        () async {
          // arrange
          const reason = 'Hate speech';
          const message = 'Reportado com sucesso';
          when(
            () => mockReportUserUseCase(
              clientId: '$clientId',
              reason: reason,
            ),
          ).thenAnswer(
            (_) async => right(const ValidField(message: message)),
          );

          // act
          await controller.onSendReportPressed(reason);

          // assert
          expect(
            controller.reaction,
            UserProfileReaction.showSnackBar(message),
          );
        },
      );

      test(
        'should set reaction to showSnackBar when error',
        () async {
          // arrange
          const reason = 'Porque sim!';
          const message = 'Porque sim não é resposta!';
          when(
            () => mockReportUserUseCase(
              clientId: '$clientId',
              reason: reason,
            ),
          ).thenAnswer(
            (_) async => left(
              ServerSideFormFieldValidationFailure(message: message),
            ),
          );

          // act
          await controller.onSendReportPressed(reason);

          // assert
          expect(
            controller.reaction,
            UserProfileReaction.showSnackBar(message),
          );
        },
      );
    });
  });
}
