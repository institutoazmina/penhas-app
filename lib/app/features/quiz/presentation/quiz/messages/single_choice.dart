import 'package:flutter/material.dart';

import '../../../domain/entities/answer.dart';
import '../../../domain/entities/quiz_message.dart';
import 'choices_box.dart';

class SingleChoiceMessageWidget extends StatefulWidget {
  const SingleChoiceMessageWidget({
    super.key,
    required this.options,
    this.onReply,
  });

  final List<MessageOption> options;
  final ValueChanged<AnswerValue>? onReply;

  @override
  State<SingleChoiceMessageWidget> createState() =>
      _SingleChoiceMessageWidgetState();
}

class _SingleChoiceMessageWidgetState extends State<SingleChoiceMessageWidget> {
  MessageOption? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return ChoicesBox(
      onSend: _selectedOption != null ? _onSend : null,
      children: widget.options
          .map(
            (option) => RadioOption(
              option,
              selectedValue: _selectedOption,
              onChanged: _onChangeValue,
            ),
          )
          .toList(),
    );
  }

  void _onChangeValue(MessageOption? value) {
    setState(() {
      _selectedOption = value;
    });
  }

  void _onSend() {
    final selectedValue = _selectedOption;
    if (selectedValue == null) return;

    widget.onReply?.call(selectedValue.asAnswerValue);
  }
}

class RadioOption extends StatelessWidget {
  const RadioOption(
    this.option, {
    super.key,
    required this.selectedValue,
    this.onChanged,
  });

  final MessageOption option;
  final MessageOption? selectedValue;
  final ValueChanged<MessageOption?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<MessageOption>(
      onChanged: onChanged,
      title: Text(option.label),
      value: option,
      groupValue: selectedValue,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
