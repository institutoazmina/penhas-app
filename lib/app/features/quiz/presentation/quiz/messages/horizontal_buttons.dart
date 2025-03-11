import 'package:flutter/material.dart';

import '../../../../../shared/design_system/button_shape.dart';
import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/text_styles.dart';
import '../../../domain/entities/answer.dart';
import '../../../domain/entities/quiz_message.dart';
import '../quiz_page.dart';

const _buttonHeight = 48.0;
const _horizontalMargin = 24.0;
const _spaceBetweenButtons = 16.0;
const _spaceAroundButtons = _horizontalMargin * 2;

typedef OnButtonPressed = void Function(ButtonOption button);

class HorizontalButtonsMessageWidget extends StatelessWidget {
  const HorizontalButtonsMessageWidget(
    this.buttons,
    this.onReply, {
    Key? key,
  }) : super(key: key);

  final List<ButtonOption> buttons;
  final ValueChanged<AnswerValue> onReply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalMargin,
        vertical: 8,
      ),
      child: buttons.length == 1
          ? _SingleButton(buttons.first, onPressed: _onPressed)
          : _ButtonGroup(buttons, onPressed: _onPressed),
    );
  }

  void _onPressed(ButtonOption button) {
    onReply(button.asAnswerValue);
  }
}

class _SingleButton extends StatelessWidget {
  const _SingleButton._(
    this.button, {
    Key? key,
    this.onPressed,
  }) : super(key: key);

  factory _SingleButton(
    ButtonOption button, {
    required OnButtonPressed onPressed,
  }) =>
      _SingleButton._(
        button,
        onPressed: () => onPressed(button),
      );

  final ButtonOption button;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return _FilledButton(button.label, onPressed: onPressed);
  }
}

class _ButtonGroup extends StatelessWidget {
  const _ButtonGroup(
    this.buttons, {
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final List<ButtonOption> buttons;
  final OnButtonPressed onPressed;

  @override
  Widget build(BuildContext context) {
    final constraints = QuizContent.of(context)?.widget.constraints;
    final maxWidth = constraints?.maxWidth ?? MediaQuery.of(context).size.width;

    final totalSpaceBetween = _spaceBetweenButtons * (buttons.length - 1);
    final utilSpace = maxWidth - _spaceAroundButtons - totalSpaceBetween;
    final width = utilSpace / buttons.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: buttons
          .map(
            (button) => _OutlinedButton(
              button.label,
              width: width,
              onPressed: () => onPressed(button),
            ),
          )
          .toList(),
    );
  }
}

class _FilledButton extends StatelessWidget {
  const _FilledButton(
    this.label, {
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: DesignSystemColors.ligthPurple,
        elevation: 0,
        shape: kButtonShapeFilled,
        minimumSize: const Size(double.infinity, _buttonHeight),
      ),
      child: Text(
        label.toUpperCase(),
        style: kTextStyleDefaultFilledButtonLabel,
      ),
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  const _OutlinedButton(
    this.label, {
    Key? key,
    this.width = double.infinity,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: DesignSystemColors.ligthPurple,
        backgroundColor: Colors.white,
        elevation: 0,
        shape: kButtonShapeOutlinePurple,
        side: kButtonShapeOutlinePurple.side,
        minimumSize: Size(width, _buttonHeight),
      ),
      child: Text(
        label.toUpperCase(),
        style: theme.textTheme.labelLarge?.copyWith(
          color: DesignSystemColors.ligthPurple,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
