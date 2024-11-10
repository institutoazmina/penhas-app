import 'package:flutter/material.dart';

import '../../../domain/entities/answer.dart';
import '../../../domain/entities/quiz_message.dart';
import '../quiz_page.dart';
import 'horizontal_buttons.dart';
import 'multiple_choices.dart';
import 'single_choice.dart';
import 'text.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget(
    this.message, {
    Key? key,
  }) : super(key: key);

  final QuizMessage message;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  QuizMessage get message => widget.message;

  @override
  Widget build(BuildContext context) {
    return message.map(
      text: (msg) => TextMessageWidget.received(msg.content),
      sent: (msg) => TextMessageWidget.sent(msg.content, msg.status, _onRetry),
      horizontalButtons: (msg) =>
          HorizontalButtonsMessageWidget(msg.buttons, _onReply),
      singleChoice: (msg) =>
          SingleChoiceMessageWidget(options: msg.options, onReply: _onReply),
      multipleChoices: (msg) =>
          MultipleChoicesMessageWidget(options: msg.options, onReply: _onReply),
    );
  }

  void _onReply(AnswerValue value) {
    final state = QuizContent.of(context);
    state?.onReply(
      UserAnswer(
        value: value,
        message: message,
      ),
    );
  }

  void _onRetry() {
    final state = QuizContent.of(context);
    message.mapOrNull(
      sent: (msg) => state?.onRetry(msg.answer!),
    );
  }
}

class AnimatedMessage extends StatelessWidget {
  const AnimatedMessage({
    Key? key,
    required this.index,
    required this.message,
    required this.animation,
  }) : super(key: key);

  final int index;
  final QuizMessage message;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutExpo,
      ).drive(
        Tween<double>(begin: -1, end: 1),
      ),
      child: SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ).drive(
          Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ),
        ),
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ).drive(
            Tween<double>(begin: 0.1, end: 1),
          ),
          child: MessageWidget(
            message,
            key: ValueKey(
              '${animation.status.name}_quiz_message[$index]',
            ),
          ),
        ),
      ),
    );
  }
}

class InteractionBox extends StatelessWidget {
  const InteractionBox({
    Key? key,
    required this.animation,
    required this.message,
  }) : super(key: key);

  final Animation<double> animation;
  final QuizMessage? message;

  @override
  Widget build(BuildContext context) {
    final item = message;
    if (item == null) return const SizedBox.shrink();

    return SlideTransition(
      position: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ).drive(
        Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ),
      ),
      child: MessageWidget(item),
    );
  }
}
