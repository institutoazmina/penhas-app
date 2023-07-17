import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../domain/entities/chat_channel_message.dart';

class ChatChannelMessagePage extends StatelessWidget {
  const ChatChannelMessagePage({
    Key? key,
    required this.content,
  }) : super(key: key);

  final ChatChannelMessage content;

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry margin = content.content.isMe
        ? const EdgeInsets.only(left: 36.0, right: 12.0, bottom: 8.0, top: 8.0)
        : const EdgeInsets.only(left: 12.0, right: 36.0, bottom: 8.0, top: 8.0);

    final EdgeInsetsGeometry padding = content.content.isMe
        ? const EdgeInsets.only(left: 18.0, right: 8.0, bottom: 10.0, top: 10.0)
        : const EdgeInsets.only(
            left: 8.0,
            right: 18.0,
            bottom: 10.0,
            top: 10.0,
          );

    final Color color = content.content.isMe
        ? DesignSystemColors.ligthPurple
        : const Color.fromRGBO(239, 239, 239, 1.0);
    final Color textColor = content.content.isMe ? Colors.white : Colors.black;

    const Radius radius = Radius.circular(16.0);

    final BorderRadiusGeometry borderRadius = content.content.isMe
        ? const BorderRadius.only(
            topLeft: radius,
            topRight: radius,
            bottomLeft: radius,
          )
        : const BorderRadius.only(
            topLeft: radius,
            topRight: radius,
            bottomRight: radius,
          );

    final AlignmentGeometry alignment =
        content.content.isMe ? Alignment.centerRight : Alignment.centerLeft;

    if (content.content.message == null || content.content.message!.isEmpty) {
      return Container();
    }

    return Container(
      margin: margin,
      alignment: alignment,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(color: color, borderRadius: borderRadius),
        child: Container(
          constraints: const BoxConstraints(minWidth: 60.0),
          child: HtmlWidget(
            content.content.message!,
            textStyle: TextStyle(fontSize: 15.0, color: textColor),
          ),
        ),
      ),
    );
  }
}
