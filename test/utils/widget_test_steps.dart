import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/shared/password_text_input.dart';

Future<void> iSeeButton({
  required WidgetTester tester,
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
  WidgetTester tester,
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

Future<void> iSeePasswordField({
  required WidgetTester tester,
  String? text,
  Key? key,
}) async {
  if (text != null) {
    expect(
        find.ancestor(
          of: find.text(text),
          matching: find.byType(PassordInputField),
        ),
        findsOneWidget);

    return;
  }

  if (key != null) {
    expect(
        find.ancestor(
          of: find.byKey(key),
          matching: find.byType(PassordInputField),
        ),
        findsOneWidget);

    return;
  }

  expect(find.byType(PassordInputField), findsOneWidget);
}
