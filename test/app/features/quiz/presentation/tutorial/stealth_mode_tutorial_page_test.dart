import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_page.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_page_controller.dart';

import '../../../../../utils/golden_tests.dart';

class MockLocationServices extends Mock implements ILocationServices {
  @override
  Future<bool> isPermissionGranted() async {
    return Future.value(true);
  }
}

void main() {
  late MockLocationServices mockLocationServices;
  late StealthModeTutorialPageController controller;

  setUp(() {
    mockLocationServices = MockLocationServices();
    controller = StealthModeTutorialPageController(
      locationService: mockLocationServices,
    );
  });

  group(StealthModeTutorialPage, () {
    screenshotTest(
      'load stealth mode tutorial page',
      fileName: 'stealth_mode_tutorial_page',
      pageBuilder: () => StealthModeTutorialPage(
        controller: controller,
      ),
    );
  });
}
