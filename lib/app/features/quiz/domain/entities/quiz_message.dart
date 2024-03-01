import 'package:freezed_annotation/freezed_annotation.dart';

import 'answer.dart';

part 'quiz_message.freezed.dart';

@freezed
class QuizMessage with _$QuizMessage {
  const QuizMessage._();

  const factory QuizMessage.text({
    @Default('') String reference,
    required String content,
  }) = _TextMessage;

  const factory QuizMessage.sent({
    @Default('') String reference,
    required String content,
    UserAnswer? answer,
    @Default(AnswerStatus.sending) AnswerStatus status,
  }) = _SentMessage;

  factory QuizMessage.button({
    required String reference,
    required String label,
    required String value,
    ButtonAction? action,
  }) =>
      QuizMessage.horizontalButtons(
        reference: reference,
        buttons: [
          ButtonOption(label: label, value: value, action: action),
        ],
      );

  const factory QuizMessage.horizontalButtons({
    required String reference,
    required List<ButtonOption> buttons,
  }) = _HorizontalButtonsMessage;

  const factory QuizMessage.singleChoice({
    required String reference,
    required List<MessageOption> options,
  }) = _SingleChoiceMessage;

  const factory QuizMessage.multipleChoices({
    required String reference,
    required List<MessageOption> options,
  }) = _MultipleChoiceMessage;

  QuizMessage maybeChangeStatus(AnswerStatus status) => maybeMap<QuizMessage>(
        sent: (message) => message.copyWith(status: status),
        orElse: () => this,
      );

  bool get isSent => maybeMap<bool>(
        sent: (_) => true,
        orElse: () => false,
      );

  bool get isInteractive => maybeMap<bool>(
        text: (_) => false,
        sent: (_) => false,
        orElse: () => true,
      );
}

@freezed
class MessageOption with _$MessageOption {
  const MessageOption._();

  const factory MessageOption({
    required String label,
    required String value,
  }) = _MessageOption;

  const factory MessageOption.button({
    required String label,
    required String value,
    ButtonAction? action,
  }) = ButtonOption;

  AnswerValue get asAnswerValue => AnswerValue(value, readable: label);
}

@freezed
class ButtonAction with _$ButtonAction {
  const ButtonAction._();

  const factory ButtonAction.navigate({
    required String route,
    required String readableResult,
  }) = _NavigateAction;
}
