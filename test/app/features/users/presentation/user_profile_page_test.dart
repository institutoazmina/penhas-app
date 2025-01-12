import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/chat/domain/usecases/get_chat_channel_token_usecase.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_entity.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';
import 'package:penhas/app/features/users/domain/usecases/block_user_usecase.dart';
import 'package:penhas/app/features/users/domain/usecases/report_user_usecase.dart';
import 'package:penhas/app/features/users/presentation/user_profile_controller.dart';
import 'package:penhas/app/features/users/presentation/user_profile_page.dart';

import '../../../../utils/golden_tests.dart';
import '../../../../utils/widget_test_steps.dart';

class GetChatChannelTokenUseCaseMock extends Mock
    implements GetChatChannelTokenUseCase {}

class ReportUserUseCaseMock extends Mock implements ReportUserUseCase {}

class BlockUserUseCaseMock extends Mock implements BlockUserUseCase {}

void main() {
  late UserProfileController controller;
  late GetChatChannelTokenUseCaseMock getChatChannelToken;
  late ReportUserUseCaseMock reportUser;
  late BlockUserUseCaseMock blockUser;

  setUp(() {
    getChatChannelToken = GetChatChannelTokenUseCaseMock();
    reportUser = ReportUserUseCaseMock();
    blockUser = BlockUserUseCaseMock();

    final person = UserDetailEntity(
      isMyself: false,
      profile: UserDetailProfileEntity(
        activity: 'all activities',
        skills: 'all skills',
        miniBio: 'Test Bio',
        clientId: 123,
        nickname: 'test',
        avatar: null,
      ),
    );

    controller = UserProfileController(
      person: person,
      getChatChannelToken: getChatChannelToken,
      reportUser: reportUser,
      blockUser: blockUser,
    );
  });

  group(UserProfilePage, () {
    testWidgets(
      'should display user profile page',
      (tester) async {
        await theAppIsRunning(tester, UserProfilePage(controller: controller));
      },
    );

    screenshotTest(
      'should display user profile page',
      fileName: 'user_profile_page',
      pageBuilder: () => Scaffold(
        body: UserProfilePage(controller: controller),
      ),
    );
  });
}
