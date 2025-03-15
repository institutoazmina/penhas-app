import 'package:flutter/material.dart';

import '../../../domain/entities/answer.dart';
import '../../../domain/entities/quiz_message.dart';
import 'choices_box.dart';

class MultipleChoicesMessageWidget extends StatefulWidget {
  const MultipleChoicesMessageWidget({
    super.key,
    required this.options,
    this.onReply,
  });

  final List<MessageOption> options;
  final ValueChanged<AnswerValue>? onReply;

  @override
  State<MultipleChoicesMessageWidget> createState() =>
      _MultipleChoicesMessageWidgetState();
}

class _MultipleChoicesMessageWidgetState
    extends State<MultipleChoicesMessageWidget> {
  final _selectedOptions = <MessageOption>{};

  @override
  Widget build(BuildContext context) {
    return ChoicesBox(
      onSend: _selectedOptions.isNotEmpty ? _onSend : null,
      children: widget.options
          .map(
            (option) => CheckboxOption(
              option,
              isChecked: _selectedOptions.contains(option),
              onChange: (isChecked) =>
                  _onChangeSelection(isChecked == true, option),
            ),
          )
          .toList(),
    );
  }

  void _onChangeSelection(bool isChecked, MessageOption answer) {
    setState(() {
      if (isChecked == true) {
        _selectedOptions.add(answer);
      } else {
        _selectedOptions.remove(answer);
      }
    });
  }

  void _onSend() {
    final selectedValues = _selectedOptions;
    if (selectedValues.isEmpty) return;

    widget.onReply?.call(
      AnswerValue(
        selectedValues.map((e) => e.value).join(','),
        readable: widget.options
            // preserve the order of the options
            .where((element) => _selectedOptions.contains(element))
            .map((e) => e.label)
            .join(', '),
      ),
    );
  }
}

class CheckboxOption extends StatelessWidget {
  const CheckboxOption(
    this.option, {
    super.key,
    required this.isChecked,
    this.onChange,
  });

  final MessageOption option;
  final bool isChecked;
  final ValueChanged<bool?>? onChange;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      onChanged: onChange,
      value: isChecked,
      title: Text(option.label),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
