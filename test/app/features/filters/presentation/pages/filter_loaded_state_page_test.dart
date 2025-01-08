import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/filters/presentation/filter_module.dart';
import 'package:penhas/app/features/filters/presentation/pages/filter_loaded_state_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/widget_test_steps.dart';

class MockFilterCallback extends Mock {
  void call(List<FilterTagEntity> tags);
}

class MockResetAction extends Mock {
  void call();
}

void main() {
  setUp(() {
    registerFallbackValue(MockFilterCallback);

    initModules([
      FilterModule(),
    ]);
  });

  tearDown(() {
    Modular.removeModule(FilterModule());
  });

  group(FilterLoadedStatePage, () {
    final mockCallback = MockFilterCallback();
    final mockOnResetAction = MockResetAction();
    final testTags = [FilterTagEntity(isSelected: true, id: '', label: '')];

    testWidgets('should show Page successfully', (tester) async {
      await theAppIsRunning(
          tester,
          FilterLoadedStatePage(
            onResetAction: mockOnResetAction,
            tags: testTags,
            onApplyFilterAction: (tags) => mockCallback(tags),
          ));

      iSeeText('Filtros');
      iSeeText('Selecione os temas de seu interesse:');
      iSeeText('Limpar');
      iSeeText('Aplicar filtro');
    });

    testWidgets('should call onResetAction when click limpar', (tester) async {
      when(() => mockOnResetAction.call()).thenReturn(null);

      await theAppIsRunning(
          tester,
          FilterLoadedStatePage(
            onResetAction: mockOnResetAction,
            tags: testTags,
            onApplyFilterAction: (tags) => mockCallback(tags),
          ));
      await iTapText(tester, text: 'Limpar');

      verify(() => mockOnResetAction.call()).called(1);
    });

    testWidgets('should call onApplyFilterAction when click limpar',
        (tester) async {
      when(() => mockCallback.call(any())).thenReturn(null);

      await theAppIsRunning(
          tester,
          FilterLoadedStatePage(
            onResetAction: mockOnResetAction,
            tags: testTags,
            onApplyFilterAction: (tags) => mockCallback(tags),
          ));
      await iTapText(tester, text: 'Aplicar filtro');

      verify(() => mockCallback.call(any())).called(1);
    });

    screenshotTest(
      'should render the page',
      fileName: 'filter_loaded_state_page',
      pageBuilder: () => FilterLoadedStatePage(
        onResetAction: mockOnResetAction,
        tags: testTags,
        onApplyFilterAction: (tags) => mockCallback(tags),
      ),
    );
  });
}
