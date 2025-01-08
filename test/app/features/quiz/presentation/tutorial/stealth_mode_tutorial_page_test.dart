import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_page.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_page_controller.dart';
import 'package:penhas/app/features/quiz/quiz_module.dart';

import '../../../../../utils/golden_tests.dart';

class MockLocationServices extends Mock implements ILocationServices {}

void main() {
  late MockLocationServices mockLocationServices;

  setUp(() {
    mockLocationServices = MockLocationServices();

    initModule(QuizModule(), replaceBinds: [
      Bind.factory<StealthModeTutorialPageController>(
        (i) => StealthModeTutorialPageController(
          locationService: mockLocationServices,
        ),
      ),
    ]);
  });

  group(StealthModeTutorialPage, () {
    screenshotTest(
      'load stealth mode tutorial page',
      fileName: 'stealth_mode_tutorial_page',
      pageBuilder: () => StealthModeTutorialPage(),
      setUp: () async {
        when(() => mockLocationServices.isPermissionGranted()).thenAnswer(
          (invocation) async => true,
        );
      },
    );
  });
}
