import 'package:flutter/material.dart' hide Element, Text;
import 'package:mastodon_dart/mastodon_dart.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import 'emoji_text_span.dart';

/// A dead-simple HTML parser that handles 99% of Mastodon
/// content.
///
/// ActivityPub allows any HTML tags in the content field,
/// but Mastodon only uses a few tags with classnames. Instead
/// of using a more robust HTML parsing widget, we pick out the
/// common cases and build them perfectly.
///
/// TODO: add mention/hashtag/link tap gestures
/// TODO: use app theme?
class StatusContent extends StatelessWidget {
  final Document html;
  final Status status;
  final Color textColor;

  StatusContent({
    @required Status status,
    this.textColor = Colors.black,
  })  : html = parse(status.content),
        status = status;

  Element get body => html.body;
  String get text => html.body.text;
  String get content => html.body.innerHtml;

  TextStyle get textStyle => TextStyle(
        fontSize: 16,
        height: 1.1,
        color: textColor,
      );

  TextStyle get linkStyle => textStyle.copyWith(
        color: Colors.blue,
      );

  List<TextSpan> parseNode(Node message) {
    final spans = <TextSpan>[];

    for (final node in message.nodes) {
      if (node is Text) {
        spans.add(
          EmojiTextSpan(
            text: node.text,
          ),
        );
      } else if (node is Element) {
        switch (node.localName) {
          case "a":
            spans.add(
              TextSpan(
                children: parseNode(node),
                style: linkStyle,
              ),
            );
            break;
          case "p":
            spans.addAll(parseNode(node));
            spans.add(TextSpan(text: "\n\n"));
            break;
          case "br":
            spans.add(TextSpan(text: "\n"));
            break;
          case "span":
            switch (node.className) {
              case "invisible":
                break;
              case "ellipsis":
                spans.add(EmojiTextSpan(text: node.text + "..."));
                break;
              default:
                spans.addAll(parseNode(node));
            }
            break;
          default:
            spans.addAll(parseNode(node));
        }
      }
    }

    final allWhitespace = RegExp(r"^\s*$", multiLine: false);

    /// Remove all the trailing whitespace
    final filtered = spans.reversed
        .skipWhile(
          (span) => allWhitespace.hasMatch(span?.toPlainText()),
        )
        .toList()
        .reversed
        .toList();

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final spans = parseNode(html.body);

    return RichText(
      text: TextSpan(
        style: textStyle,
        children: spans,
      ),
    );
  }
}
