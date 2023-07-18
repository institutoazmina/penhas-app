import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import 'quiz_typedef.dart';

class QuizHorizontalButtonsWidget extends StatelessWidget {
  const QuizHorizontalButtonsWidget._({
    Key? key,
    required this.options,
    required this.onUserReply,
  }) : super(key: key);

  factory QuizHorizontalButtonsWidget({
    Key? key,
    required String reference,
    required List<QuizMessageChoiceOption> options,
    required UserReaction onPressed,
  }) =>
      QuizHorizontalButtonsWidget._(
        key: key,
        options: options,
        onUserReply: (String reply) => onPressed({reference: reply}),
      );

  final OnUserReply onUserReply;
  final List<QuizMessageChoiceOption> options;

  @override
  Widget build(BuildContext context) {
    const horizontalMargin = 24.0, marginBetween = 18;
    final qtyOptions = options.length,
        totalSpacing = horizontalMargin * 2 + marginBetween * (qtyOptions - 1);

    return LayoutBuilder(
      builder: (_, constraints) {
        final buttonWidth = (constraints.maxWidth - totalSpacing) / qtyOptions;

        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: horizontalMargin,
          ),
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: options
                .map(
                  (option) => _ActionButton(
                    width: buttonWidth,
                    title: option.display,
                    onPressed: () => onUserReply(option.index),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.width,
    this.height = 40.0,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        elevation: 0.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: DesignSystemColors.ligthPurple),
        ),
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: DesignSystemColors.ligthPurple,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
