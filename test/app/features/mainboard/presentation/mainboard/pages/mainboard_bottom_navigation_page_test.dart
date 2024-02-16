import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/pages/mainboard_bottom_navigation_page.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/pages/mainboard_button_page.dart';

import '../../../../../../utils/golden_tests.dart';
import '../../../../../../utils/test_utils.dart';

void main() {
  group(MainboardBottomNavigationPage, () {
    parameterizedGroup<List<MainboardState>>(
      'golden test',
      () => {
        'with help center and escape manual': [
          MainboardState.feed(),
          MainboardState.escapeManual(),
          MainboardState.helpCenter(),
          MainboardState.chat(),
          MainboardState.supportPoint(),
        ],
        'without help center and escape manual': [
          MainboardState.feed(),
          MainboardState.compose(),
          MainboardState.chat(),
          MainboardState.supportPoint(),
        ],
      },
      (name, pages) {
        widgetScreenshotTest(
          '$name should looks as expected',
          fileName: 'bottom_navigation_${name.replaceAll(' ', '_')}}',
          widgetBuilder: (_) => SizedBox(
            width: 400,
            height: kBottomNavigationBarHeight * 2 * pages.length,
            child: Scaffold(
              body: GoldenTestGroup(
                columns: 1,
                columnWidthBuilder: (__) => const FixedColumnWidth(400),
                children: pages
                    .map(
                      (page) => GoldenTestScenario(
                        name: '${page.label} selected',
                        child: MainboardBottomNavigationPage(
                          onSelect: (_) {},
                          pages: pages,
                          currentPage: page,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  });
}
