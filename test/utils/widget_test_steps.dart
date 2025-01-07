import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/shared/password_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/shared/single_text_input.dart';

Future<void> theAppIsRunning(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: Asuka.builder,
      home: widget,
    ),
  );
}

Future<void> iSeeButton({
  String? text,
  Key? key,
}) async {
  if (text != null) {
    final targetText = find.text(text);
    expect(targetText, findsOneWidget);

    final targetButton = find.ancestor(
      of: targetText,
      matching: find.byWidgetPredicate(
        (widget) => widget is ButtonStyleButton || widget is MaterialButton,
      ),
    );

    expect(targetButton, findsOneWidget);

    return;
  }

  fail('did not find the widget');
}

Future<void> iSeeText(
  String text,
) async {
  expect(find.text(text), findsOneWidget);
}

Future<void> iDontSeeText(
  String text,
) async {
  expect(find.text(text), findsNothing);
}

Future<void> iTapText(WidgetTester tester, {required String text}) async {
  await tester.tap(find.text(text));
  await tester.pump();
}

Future<void> iTapButton(WidgetTester tester, String text) async {
  final targetButton = find.ancestor(
    of: find.text(text),
    matching: find.byWidgetPredicate(
      (widget) => widget is ButtonStyleButton || widget is MaterialButton,
    ),
  );

  await tester.tap(targetButton);
}

Future<void> iSeePasswordField({
  String? text,
  Key? key,
}) async {
  final finder = _getType(PasswordInputField, text: text, key: key);

  if (finder != null && finder.evaluate().isNotEmpty) {
    expect(finder, findsOneWidget);
    return;
  }

  expect(find.byType(PasswordInputField), findsOneWidget);
}

Future<void> iEnterIntoPasswordField(
  WidgetTester tester, {
  String? text,
  Key? key,
  required String password,
}) async {
  final finder = _getType(PasswordInputField, text: text, key: key);

  if (finder == null) {
    fail('did not find the PasswordInputField to enter the value $password');
  }

  await tester.enterText(finder, password);
  await tester.pump();
}

Future<void> iSeeSingleTextInputErrorMessage(
  WidgetTester tester, {
  String? text,
  Key? key,
  required String message,
}) async {
  final finder = _getType(SingleTextInput, text: text, key: key);

  if (finder == null) {
    fail('did not find the SingleTextInput widget');
  }

  final textField = _getDescendantTextFieldFrom(finder, tester);
  expect(textField.decoration?.errorText, message);
}

Future<void> iEnterIntoSingleTextInput(
  WidgetTester tester, {
  String? text,
  Key? key,
  required String value,
}) async {
  final finder = _getType(SingleTextInput, text: text, key: key);

  if (finder == null) {
    fail('did not find the SingleTextInput to enter the value $value');
  }

  await tester.enterText(finder, value);
  await tester.pump();
}

Future<void> iSeePasswordFieldErrorMessage(
  WidgetTester tester, {
  String? text,
  Key? key,
  required String message,
}) async {
  final finder = _getType(PasswordInputField, text: text, key: key);

  if (finder == null) {
    fail('did not find the PasswordInputField widget');
  }

  final textField = _getDescendantTextFieldFrom(finder, tester);
  expect(textField.decoration?.errorText, message);
}

TextField _getDescendantTextFieldFrom(Finder finder, WidgetTester tester) {
  final textFieldFinder = find.descendant(
    of: finder,
    matching: find.byType(TextField),
  );

  final textField = tester.widget(textFieldFinder) as TextField;

  return textField;
}

Future<void> iSeeSingleTextInput({
  String? text,
  Key? key,
}) async {
  final finder = _getType(SingleTextInput, text: text, key: key);

  if (finder != null && finder.evaluate().isNotEmpty) {
    expect(finder, findsOneWidget);
    return;
  }

  expect(find.byType(SingleTextInput), findsOneWidget);
}

Finder? _getType(Type type, {String? text, Key? key}) {
  if (text != null) {
    return find.ancestor(
      of: find.text(text),
      matching: find.byType(type),
    );
  }

  if (key != null) {
    final element = find.byKey(key);

    for (var item in element.evaluate()) {
      if (item.widget.runtimeType == type) {
        return element;
      }
    }
  }

  return null;
}

Future<void> iSeeWidget(Type type, {String? text, Key? key}) async {
  final finder = _getType(type, text: text, key: key);

  if (finder != null && finder.evaluate().isNotEmpty) {
    expect(finder, findsOneWidget);
    return;
  }

  expect(find.byType(type), findsOneWidget);
}

void iDontSeeWidget(Type type, {String? text, Key? key}) async {
  final finder = _getType(type, text: text, key: key);

  if (finder != null && finder.evaluate().isNotEmpty) {
    expect(finder, findsNothing);
    return;
  }

  expect(find.byType(type), findsNothing);
}

Future<void> iEnterIntoWidgetInput(
  WidgetTester tester, {
  required type,
  String? text,
  Key? key,
  required String value,
}) async {
  final finder = _getType(type, text: text, key: key);

  if (finder == null) {
    fail('did not find the $type to enter the value $value');
  }

  await tester.enterText(finder, value);
  await tester.pump();
}

Future<void> iTapDropdownFormItem<T>(
  WidgetTester tester, {
  required String item,
  String? text,
  Key? key,
}) async {
  final foundDropdownFormField =
      _getType(DropdownButtonFormField<T>, text: text, key: key);

  if (foundDropdownFormField == null ||
      foundDropdownFormField.evaluate().isEmpty) {
    fail('did not find the DropdownButtonFormField to tapping the value $item');
  }

  // Open the dropdown
  await tester.tap(foundDropdownFormField);
  await tester.pumpAndSettle();

  final dropdownItem = find.text(item);
  final hasElementOnTheDropdownFormField = find.descendant(
    of: foundDropdownFormField,
    matching: dropdownItem,
  );

  expect(hasElementOnTheDropdownFormField, findsOneWidget);

  // Select the dropdown item
  await tester.tap(dropdownItem.last);
  await tester.pumpAndSettle();
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> theAppIsRunning(Widget widget) async {
    await pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: Asuka.builder,
        home: widget,
      ),
    );
  }

  Future<void> iTapText({required String text}) async {
    await tap(find.text(text));
    await pumpAndSettle();
  }
}
