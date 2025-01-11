import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/main_menu/domain/entities/account_preference_entity.dart';
import 'package:penhas/app/features/main_menu/domain/states/account_preference_state.dart';
import 'package:penhas/app/features/main_menu/presentation/account/preference/account_preference_controller.dart';
import 'package:penhas/app/features/main_menu/presentation/account/preference/account_preference_page.dart';

import '../../../../../../utils/golden_tests.dart';
import '../../../../../../utils/widget_test_steps.dart';

class MockAccountPreferenceController extends Mock
    implements AccountPreferenceController {}

void main() {
  late AccountPreferenceController controller;

  setUp(() {
    controller = MockAccountPreferenceController();
  });

  group(AccountPreferencePage, () {
    testWidgets('should load page initial state', (tester) async {
      when(() => controller.state).thenReturn(AccountPreferenceState.initial());

      await theAppIsRunning(
          tester,
          AccountPreferencePage(
            controller: controller,
          ));

      await iSeeText('Configurações');
    });

    testWidgets('should load page loaded', (tester) async {
      final preferences = <AccountPreferenceEntity>[
        AccountPreferenceEntity(key: 'fake', label: 'label', value: true)
      ];

      when(() => controller.state)
          .thenReturn(AccountPreferenceState.loaded(preferences));
      when(() => controller.progress).thenReturn(PageProgressState.loaded);

      await theAppIsRunning(
          tester,
          AccountPreferencePage(
            controller: controller,
          ));

      await iSeeText('Marque abaixo quais notificações deseja receber');
    });

    screenshotTest('should render page loaded',
        fileName: 'account_preference_page', pageBuilder: () {
      final preferences = <AccountPreferenceEntity>[
        AccountPreferenceEntity(key: 'fake', label: 'label', value: true)
      ];

      when(() => controller.state)
          .thenReturn(AccountPreferenceState.loaded(preferences));
      when(() => controller.progress).thenReturn(PageProgressState.loaded);
      return AccountPreferencePage(
        controller: controller,
      );
    });
  });
}
