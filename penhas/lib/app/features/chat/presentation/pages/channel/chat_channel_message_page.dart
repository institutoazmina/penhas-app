import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_message.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatChannelMessagePage extends StatelessWidget {
  final ChatChannelMessage content;

  const ChatChannelMessagePage({
    Key key,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry margin = content.content.isMe
        ? EdgeInsets.only(left: 36.0, right: 12.0, bottom: 8.0, top: 8.0)
        : EdgeInsets.only(left: 12.0, right: 36.0, bottom: 8.0, top: 8.0);

    EdgeInsetsGeometry padding = content.content.isMe
        ? EdgeInsets.only(left: 18.0, right: 8.0, bottom: 10.0, top: 10.0)
        : EdgeInsets.only(left: 8.0, right: 18.0, bottom: 10.0, top: 10.0);

    Color color = content.content.isMe
        ? DesignSystemColors.ligthPurple
        : Color.fromRGBO(239, 239, 239, 1.0);
    Color textColor = content.content.isMe ? Colors.white : Colors.black;

    Radius radius = Radius.circular(16.0);

    BorderRadiusGeometry borderRadius = content.content.isMe
        ? BorderRadius.only(
            topLeft: radius, topRight: radius, bottomLeft: radius)
        : BorderRadius.only(
            topLeft: radius, topRight: radius, bottomRight: radius);

    AlignmentGeometry alignment =
        content.content.isMe ? Alignment.centerRight : Alignment.centerLeft;

    if (content.content.message == null || content.content.message.isEmpty) {
      return Container();
    }

    return Container(
      margin: margin,
      alignment: alignment,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(color: color, borderRadius: borderRadius),
        child: Container(
          constraints: BoxConstraints(minWidth: 60.0),
          child: Container(
            child: HtmlWidget(
              content.content.message,
              textStyle: TextStyle(fontSize: 15.0, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
