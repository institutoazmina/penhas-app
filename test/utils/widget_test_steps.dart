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
