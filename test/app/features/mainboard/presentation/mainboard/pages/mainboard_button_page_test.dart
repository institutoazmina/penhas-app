import 'package:flutter/material.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/pages/mainboard_button_page.dart';

import '../../../../../../utils/mock_callbacks.dart';

void main() {
  group(MainboarButtonPage, () {
    testWidgets(
      'should render button with correct label',
      (tester) async {
        // arrange
        final page = MainboardState.helpCenter();
        final selectedPage = MainboardState.helpCenter();

        // act
        await tester.pumpWidget(
          buildTestableWidget(
            Material(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MainboarButtonPage(
                    onSelect: () {},
                    page: page,
                    selectedPage: selectedPage,
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // assert
        expect(find.text(page.label), findsOneWidget);
      },
    );

    testWidgets(
      'should call onSelect when button is pressed',
      (tester) async {
        // arrange
        final onSelect = MockVoidCallback();
        final page = MainboardState.helpCenter();
        final selectedPage = MainboardState.feed();

        await tester.pumpWidget(
          buildTestableWidget(
            Material(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MainboarButtonPage(
                    onSelect: onSelect,
                    page: page,
                    selectedPage: selectedPage,
                  ),
                ],
              ),
            ),
          ),
        );

        // act
        await tester.tap(find.byType(InkResponse));
        await tester.pump();

        // assert
        verify(() => onSelect()).called(1);
      },
    );
  });
}
