import 'package:flutter/material.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/widgets/quiz_single_choice_widget.dart';

void main() {
  group(QuizSingleChoiceWidget, () {
    testWidgets(
      'should show radio buttons',
      (tester) async {
        // arrange
        await tester.pumpWidget(
          buildTestableWidget(
            Scaffold(
              body: QuizSingleChoiceWidget(
                reference: 'reference',
                options: const [
                  QuizMessageChoiceOption(index: '0', display: 'First'),
                  QuizMessageChoiceOption(index: '1', display: 'Second'),
                ],
                onPressed: (_) {},
              ),
            ),
          ),
        );

        // assert
        expect(
          find.widgetWithText(RadioListTile<String>, 'First'),
          findsOneWidget,
        );
        expect(
          find.widgetWithText(RadioListTile<String>, 'Second'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'should show disabled button when no option is selected',
      (tester) async {
        // arrange
        await tester.pumpWidget(
          buildTestableWidget(
            Scaffold(
              body: QuizSingleChoiceWidget(
                reference: 'reference',
                options: const [
                  QuizMessageChoiceOption(index: '0', display: 'First'),
                  QuizMessageChoiceOption(index: '1', display: 'Second'),
                ],
                onPressed: (_) {},
              ),
            ),
          ),
        );

        // assert
        expect(
          tester
              .widget<RaisedButton>(
                find.widgetWithText(RaisedButton, 'Enviar'),
              )
              .onPressed,
          isNull,
        );
      },
    );

    testWidgets(
      'should show enabled button when option is selected',
      (tester) async {
        // arrange
        await tester.pumpWidget(
          buildTestableWidget(
            Scaffold(
              body: QuizSingleChoiceWidget(
                reference: 'reference',
                options: const [
                  QuizMessageChoiceOption(index: '0', display: 'First'),
                  QuizMessageChoiceOption(index: '1', display: 'Second'),
                ],
                onPressed: (_) {},
              ),
            ),
          ),
        );

        // act
        await tester.tap(find.widgetWithText(RadioListTile<String>, 'First'));
        await tester.pumpAndSettle();

        // assert
        expect(
          tester
              .widget<RaisedButton>(
                find.widgetWithText(RaisedButton, 'Enviar'),
              )
              .onPressed,
          isNotNull,
        );
      },
    );

    testWidgets(
      'should show just one selected option',
      (tester) async {
        // arrange
        await tester.pumpWidget(
          buildTestableWidget(
            Scaffold(
              body: QuizSingleChoiceWidget(
                reference: 'reference',
                options: const [
                  QuizMessageChoiceOption(index: '0', display: 'First'),
                  QuizMessageChoiceOption(index: '1', display: 'Second'),
                ],
                onPressed: (_) {},
              ),
            ),
          ),
        );

        // act
        await tester.tap(find.widgetWithText(RadioListTile<String>, 'First'));
        await tester.tap(find.widgetWithText(RadioListTile<String>, 'Second'));
        await tester.pumpAndSettle();

        // assert
        expect(
          tester
              .widget<RadioListTile<String>>(
                find.widgetWithText(RadioListTile<String>, 'First'),
              )
              .groupValue,
          '1',
        );
      },
    );

    testWidgets(
      'should call onPressed when button is pressed',
      (tester) async {
        // arrange
        final onPressed = MockOnPressed();

        await tester.pumpWidget(
          buildTestableWidget(
            Scaffold(
              body: QuizSingleChoiceWidget(
                reference: 'reference',
                options: const [
                  QuizMessageChoiceOption(index: '0', display: 'First'),
                  QuizMessageChoiceOption(index: '1', display: 'Second'),
                ],
                onPressed: onPressed,
              ),
            ),
          ),
        );

        // act
        await tester.tap(find.widgetWithText(RadioListTile<String>, 'Second'));
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(RaisedButton, 'Enviar'));
        await tester.pumpAndSettle();

        // assert
        verify(() => onPressed.call({'reference': '1'})).called(1);
      },
    );
  });
}

abstract class IUserReaction {
  void call(Map<String, String> reaction);
}

class MockOnPressed extends Mock implements IUserReaction {}
