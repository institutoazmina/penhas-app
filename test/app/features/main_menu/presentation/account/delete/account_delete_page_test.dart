import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';
import 'package:penhas/app/features/main_menu/presentation/account/delete/account_delete_controller.dart';
import 'package:penhas/app/features/main_menu/presentation/account/delete/account_delete_page.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_module.dart';

import '../../../../../../utils/golden_tests.dart';

class MockProfileRepository extends Mock implements IUserProfileRepository {}

class MockAppConfiguration extends Mock implements IAppConfiguration {}

void main() {
  late IUserProfileRepository profileRepository;
  late IAppConfiguration appConfiguration;

  setUp(() {
    profileRepository = MockProfileRepository();
    appConfiguration = MockAppConfiguration();
    initModule(MainboardModule(), replaceBinds: [
      Bind.factory(
        (i) => AccountDeleteController(
          appConfiguration: appConfiguration,
          profileRepository: profileRepository,
        ),
      ),
    ]);
  });

  group(AccountDeletePage, () {
    screenshotTest(
      'should show error when loading page',
      fileName: 'account_delete_page_error',
      pageBuilder: () => Scaffold(body: AccountDeletePage()),
      setUp: () {
        when(() => profileRepository.deleteNotice())
            .thenAnswer((_) async => dartz.left(ServerFailure()));
      },
    );

    screenshotTest(
      'should show success when loading page',
      fileName: 'account_delete_page_success',
      pageBuilder: () => Scaffold(body: AccountDeletePage()),
      setUp: () {
        when(() => profileRepository.deleteNotice()).thenAnswer((_) async =>
            dartz.right(const ValidField(
                message: 'Mensagem de aviso sobre exclusão da conta')));
      },
    );
  });
}
