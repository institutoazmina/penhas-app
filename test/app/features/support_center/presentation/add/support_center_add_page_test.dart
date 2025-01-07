import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_module.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';
import 'package:penhas/app/features/support_center/presentation/add/support_center_add_page.dart';
import 'package:penhas/app/features/support_center/presentation/support_center_module.dart';

import '../../../../../utils/golden_tests.dart';

void main() {
  late MockSupportCenterUseCase mockSupportCenterUseCase;

  setUp(() {
    mockSupportCenterUseCase = MockSupportCenterUseCase();

    initModules(
      [
        MainboardModule(),
        SupportCenterModule(),
      ],
      replaceBinds: [
        Bind<SupportCenterUseCase>((i) => mockSupportCenterUseCase),
      ],
    );
  });

  tearDown(() {
    Modular.removeModule(MainboardModule());
    Modular.removeModule(SupportCenterModule());
  });

  screenshotTest(
    'support center add page - error state',
    fileName: 'support_center_add_page_error',
    pageBuilder: () => const SupportCenterAddPage(),
    setUp: () {
      when(() => mockSupportCenterUseCase.metadata()).thenAnswer(
        (_) async => dartz.Left(ServerFailure()),
      );
    },
  );
}

class MockSupportCenterUseCase extends Mock implements SupportCenterUseCase {}
