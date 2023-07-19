import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../../appstate/domain/entities/app_state_entity.dart';

class QuizMessageWidget extends StatelessWidget {
  const QuizMessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final QuizMessageEntity message;

  @override
  Widget build(BuildContext context) {
    final bool isDisplayTextResponse =
        message.type == QuizMessageType.displayTextResponse;
    final EdgeInsetsGeometry margin = isDisplayTextResponse
        ? const EdgeInsets.only(left: 36.0, right: 12.0, bottom: 8.0, top: 8.0)
        : const EdgeInsets.only(left: 12.0, right: 36.0, bottom: 8.0, top: 8.0);

    final EdgeInsetsGeometry padding = isDisplayTextResponse
        ? const EdgeInsets.only(left: 18.0, right: 8.0, bottom: 10.0, top: 10.0)
        : const EdgeInsets.only(
            left: 8.0,
            right: 18.0,
            bottom: 10.0,
            top: 10.0,
          );

    final Color color = isDisplayTextResponse
        ? DesignSystemColors.ligthPurple
        : const Color.fromRGBO(239, 239, 239, 1.0);
    final Color textColor = isDisplayTextResponse ? Colors.white : Colors.black;

    const Radius radius = Radius.circular(16.0);

    final BorderRadiusGeometry borderRadius = isDisplayTextResponse
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
        isDisplayTextResponse ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      margin: margin,
      alignment: alignment,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(color: color, borderRadius: borderRadius),
        child: Container(
          constraints: const BoxConstraints(minWidth: 60.0),
          child: HtmlWidget(
            message.content!,
            textStyle: TextStyle(fontSize: 15.0, color: textColor),
          ),
        ),
      ),
    );
  }
}
