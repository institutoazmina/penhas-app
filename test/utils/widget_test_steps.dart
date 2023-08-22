import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/shared/password_text_input.dart';

Future<void> iSeeButton({
  String? text,
  Key? key,
}) async {
  if (text != null) {
    final targetText = find.text(text);
    expect(targetText, findsOneWidget);

    final targetRaisedButton = find.ancestor(
      of: targetText,
      matching: find.byType(RaisedButton),
    );

    expect(targetRaisedButton, findsOneWidget);

    return;
  }

  fail('did not find the widget');
}

Future<void> iSeeText(
  String text,
) async {
  expect(find.text(text), findsOneWidget);
}

Future<void> theAppIsRunning(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: widget,
    ),
  );
}

Future<void> iTapText(WidgetTester tester, {required String text}) async {
  await tester.tap(find.text(text));
  await tester.pump();
}

Future<void> iSeePasswordField({
  String? text,
  Key? key,
}) async {
  final finder = _getPasswordField(text: text, key: key);

  if (finder != null && finder.evaluate().isNotEmpty) {
    expect(finder, findsOneWidget);
    return;
  }

  expect(find.byType(PassordInputField), findsOneWidget);
}

Future<void> iEnterIntoPasswordField(
  WidgetTester tester, {
  String? text,
  Key? key,
  required String password,
}) async {
  Finder? finder = _getPasswordField(text: text, key: key);

  if (finder == null) {
    fail('did not find the PasswordInputField to enter the value $password');
  }

  await tester.enterText(finder, password);
  await tester.pump();
}

Future<void> iSeePasswordFieldErrorMessage(
  WidgetTester tester, {
  String? text,
  Key? key,
  required String message,
}) async {
  Finder? finder = _getPasswordField(text: text, key: key);

  if (finder == null) {
    fail('did not find the PasswordInputField');
  }

  final textFieldFinder = find.descendant(
    of: finder,
    matching: find.byType(TextField),
  );

  TextField textField = tester.widget(textFieldFinder) as TextField;
  expect(textField.decoration?.errorText, message);
}

Finder? _getPasswordField({String? text, Key? key}) {
  if (text != null) {
    return find.ancestor(
      of: find.text(text),
      matching: find.byType(PassordInputField),
    );
  }

  if (key != null) {
    return find.ancestor(
      of: find.byKey(key),
      matching: find.byType(PassordInputField),
    );
  }

  return null;
}
