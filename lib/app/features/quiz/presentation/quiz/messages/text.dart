import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../domain/entities/answer.dart';

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget._(
    this.content, {
    Key? key,
    required this.backgroundColor,
    required this.textColor,
    this.margin,
    this.padding,
    this.borderRadius,
    this.alignment,
    this.bottom,
    this.onTap,
  }) : super(key: key);

  factory TextMessageWidget.sent(
    String content,
    AnswerStatus status, [
    VoidCallback? onRetry,
  ]) {
    assert(status != AnswerStatus.failed || onRetry != null);
    const radius = Radius.circular(16.0);
    return TextMessageWidget._(
      content,
      alignment: Alignment.centerRight,
      backgroundColor: DesignSystemColors.ligthPurple,
      textColor: Colors.white,
      margin: const EdgeInsets.only(
        left: 36.0,
        right: 12.0,
        top: 8.0,
      ),
      padding: const EdgeInsets.only(
        left: 18.0,
        right: 8.0,
        bottom: 10.0,
        top: 10.0,
      ),
      borderRadius: const BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
      ),
      bottom: _MessageStatusWidget(status),
      onTap: status == AnswerStatus.failed ? onRetry : null,
    );
  }

  factory TextMessageWidget.received(String content) {
    const radius = Radius.circular(16.0);
    return TextMessageWidget._(
      content,
      backgroundColor: const Color.fromRGBO(239, 239, 239, 1.0),
      textColor: Colors.black,
      margin: const EdgeInsets.only(
        left: 12.0,
        right: 36.0,
        top: 8.0,
      ),
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 18.0,
        bottom: 10.0,
        top: 10.0,
      ),
      borderRadius: const BorderRadius.only(
        topLeft: radius,
        topRight: radius,
        bottomRight: radius,
      ),
      alignment: Alignment.centerLeft,
    );
  }

  final String content;

  final Color backgroundColor;
  final Color textColor;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final AlignmentGeometry? alignment;
  final Widget? bottom;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: margin,
            alignment: alignment,
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: borderRadius,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 60.0),
                child: HtmlWidget(
                  content,
                  textStyle: theme.textTheme.bodyLarge?.copyWith(
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 8.0),
            child: bottom,
          ),
        ],
      ),
    );
  }
}

class _MessageStatusWidget extends StatefulWidget {
  const _MessageStatusWidget(
    this.status, {
    Key? key,
  }) : super(key: key);

  final AnswerStatus status;

  @override
  State<_MessageStatusWidget> createState() => _MessageStatusWidgetState();
}

class _MessageStatusWidgetState extends State<_MessageStatusWidget> {
  AnswerStatus get status => widget.status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AnswerStatus.sent:
        return const SizedBox.shrink();
      case AnswerStatus.sending:
        return const _SendingMessageWidget();
      case AnswerStatus.failed:
        return const _FailToSendMessageWidget();
    }
  }
}

class _SendingMessageWidget extends StatelessWidget {
  const _SendingMessageWidget();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8, right: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enviando...',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(width: 8.0),
          const SizedBox.square(
            dimension: 12.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _FailToSendMessageWidget extends StatelessWidget {
  const _FailToSendMessageWidget();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8, right: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Falha ao enviar, toque para tentar novamente.',
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.red),
          ),
          const SizedBox(width: 4.0),
          const SizedBox.square(
            dimension: 16.0,
            child: Icon(Icons.error, color: Colors.red, size: 16.0),
          ),
        ],
      ),
    );
  }
}
