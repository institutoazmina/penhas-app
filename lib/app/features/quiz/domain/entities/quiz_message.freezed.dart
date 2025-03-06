// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'quiz_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuizMessage {
  String get reference => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String reference, String content) text,
    required TResult Function(String reference, String content,
            UserAnswer? answer, AnswerStatus status)
        sent,
    required TResult Function(String reference, List<ButtonOption> buttons)
        horizontalButtons,
    required TResult Function(String reference, List<MessageOption> options)
        singleChoice,
    required TResult Function(String reference, List<MessageOption> options)
        multipleChoices,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TextMessage value) text,
    required TResult Function(_SentMessage value) sent,
    required TResult Function(_HorizontalButtonsMessage value)
        horizontalButtons,
    required TResult Function(_SingleChoiceMessage value) singleChoice,
    required TResult Function(_MultipleChoiceMessage value) multipleChoices,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuizMessageCopyWith<QuizMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizMessageCopyWith<$Res> {
  factory $QuizMessageCopyWith(
          QuizMessage value, $Res Function(QuizMessage) then) =
      _$QuizMessageCopyWithImpl<$Res>;
  $Res call({String reference});
}

/// @nodoc
class _$QuizMessageCopyWithImpl<$Res> implements $QuizMessageCopyWith<$Res> {
  _$QuizMessageCopyWithImpl(this._value, this._then);

  final QuizMessage _value;
  // ignore: unused_field
  final $Res Function(QuizMessage) _then;

  @override
  $Res call({
    Object? reference = freezed,
  }) {
    return _then(_value.copyWith(
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TextMessageCopyWith<$Res>
    implements $QuizMessageCopyWith<$Res> {
  factory _$$_TextMessageCopyWith(
          _$_TextMessage value, $Res Function(_$_TextMessage) then) =
      __$$_TextMessageCopyWithImpl<$Res>;
  @override
  $Res call({String reference, String content});
}

/// @nodoc
class __$$_TextMessageCopyWithImpl<$Res> extends _$QuizMessageCopyWithImpl<$Res>
    implements _$$_TextMessageCopyWith<$Res> {
  __$$_TextMessageCopyWithImpl(
      _$_TextMessage _value, $Res Function(_$_TextMessage) _then)
      : super(_value, (v) => _then(v as _$_TextMessage));

  @override
  _$_TextMessage get _value => super._value as _$_TextMessage;

  @override
  $Res call({
    Object? reference = freezed,
    Object? content = freezed,
  }) {
    return _then(_$_TextMessage(
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TextMessage extends _TextMessage {
  const _$_TextMessage({this.reference = '', required this.content})
      : super._();

  @override
  @JsonKey()
  final String reference;
  @override
  final String content;

  @override
  String toString() {
    return 'QuizMessage.text(reference: $reference, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextMessage &&
            const DeepCollectionEquality().equals(other.reference, reference) &&
            const DeepCollectionEquality().equals(other.content, content));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(reference),
      const DeepCollectionEquality().hash(content));

  @JsonKey(ignore: true)
  @override
  _$$_TextMessageCopyWith<_$_TextMessage> get copyWith =>
      __$$_TextMessageCopyWithImpl<_$_TextMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String reference, String content) text,
    required TResult Function(String reference, String content,
            UserAnswer? answer, AnswerStatus status)
        sent,
    required TResult Function(String reference, List<ButtonOption> buttons)
        horizontalButtons,
    required TResult Function(String reference, List<MessageOption> options)
        singleChoice,
    required TResult Function(String reference, List<MessageOption> options)
        multipleChoices,
  }) {
    return text(reference, content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
  }) {
    return text?.call(reference, content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(reference, content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TextMessage value) text,
    required TResult Function(_SentMessage value) sent,
    required TResult Function(_HorizontalButtonsMessage value)
        horizontalButtons,
    required TResult Function(_SingleChoiceMessage value) singleChoice,
    required TResult Function(_MultipleChoiceMessage value) multipleChoices,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }
}

abstract class _TextMessage extends QuizMessage {
  const factory _TextMessage(
      {final String reference, required final String content}) = _$_TextMessage;
  const _TextMessage._() : super._();

  @override
  String get reference;
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$_TextMessageCopyWith<_$_TextMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SentMessageCopyWith<$Res>
    implements $QuizMessageCopyWith<$Res> {
  factory _$$_SentMessageCopyWith(
          _$_SentMessage value, $Res Function(_$_SentMessage) then) =
      __$$_SentMessageCopyWithImpl<$Res>;
  @override
  $Res call(
      {String reference,
      String content,
      UserAnswer? answer,
      AnswerStatus status});
}

/// @nodoc
class __$$_SentMessageCopyWithImpl<$Res> extends _$QuizMessageCopyWithImpl<$Res>
    implements _$$_SentMessageCopyWith<$Res> {
  __$$_SentMessageCopyWithImpl(
      _$_SentMessage _value, $Res Function(_$_SentMessage) _then)
      : super(_value, (v) => _then(v as _$_SentMessage));

  @override
  _$_SentMessage get _value => super._value as _$_SentMessage;

  @override
  $Res call({
    Object? reference = freezed,
    Object? content = freezed,
    Object? answer = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_SentMessage(
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      answer: answer == freezed
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as UserAnswer?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AnswerStatus,
    ));
  }
}

/// @nodoc

class _$_SentMessage extends _SentMessage {
  const _$_SentMessage(
      {this.reference = '',
      required this.content,
      this.answer,
      this.status = AnswerStatus.sending})
      : super._();

  @override
  @JsonKey()
  final String reference;
  @override
  final String content;
  @override
  final UserAnswer? answer;
  @override
  @JsonKey()
  final AnswerStatus status;

  @override
  String toString() {
    return 'QuizMessage.sent(reference: $reference, content: $content, answer: $answer, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SentMessage &&
            const DeepCollectionEquality().equals(other.reference, reference) &&
            const DeepCollectionEquality().equals(other.content, content) &&
            const DeepCollectionEquality().equals(other.answer, answer) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(reference),
      const DeepCollectionEquality().hash(content),
      const DeepCollectionEquality().hash(answer),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_SentMessageCopyWith<_$_SentMessage> get copyWith =>
      __$$_SentMessageCopyWithImpl<_$_SentMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String reference, String content) text,
    required TResult Function(String reference, String content,
            UserAnswer? answer, AnswerStatus status)
        sent,
    required TResult Function(String reference, List<ButtonOption> buttons)
        horizontalButtons,
    required TResult Function(String reference, List<MessageOption> options)
        singleChoice,
    required TResult Function(String reference, List<MessageOption> options)
        multipleChoices,
  }) {
    return sent(reference, content, answer, status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
  }) {
    return sent?.call(reference, content, answer, status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(reference, content, answer, status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TextMessage value) text,
    required TResult Function(_SentMessage value) sent,
    required TResult Function(_HorizontalButtonsMessage value)
        horizontalButtons,
    required TResult Function(_SingleChoiceMessage value) singleChoice,
    required TResult Function(_MultipleChoiceMessage value) multipleChoices,
  }) {
    return sent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
  }) {
    return sent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(this);
    }
    return orElse();
  }
}

abstract class _SentMessage extends QuizMessage {
  const factory _SentMessage(
      {final String reference,
      required final String content,
      final UserAnswer? answer,
      final AnswerStatus status}) = _$_SentMessage;
  const _SentMessage._() : super._();

  @override
  String get reference;
  String get content;
  UserAnswer? get answer;
  AnswerStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_SentMessageCopyWith<_$_SentMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_HorizontalButtonsMessageCopyWith<$Res>
    implements $QuizMessageCopyWith<$Res> {
  factory _$$_HorizontalButtonsMessageCopyWith(
          _$_HorizontalButtonsMessage value,
          $Res Function(_$_HorizontalButtonsMessage) then) =
      __$$_HorizontalButtonsMessageCopyWithImpl<$Res>;
  @override
  $Res call({String reference, List<ButtonOption> buttons});
}

/// @nodoc
class __$$_HorizontalButtonsMessageCopyWithImpl<$Res>
    extends _$QuizMessageCopyWithImpl<$Res>
    implements _$$_HorizontalButtonsMessageCopyWith<$Res> {
  __$$_HorizontalButtonsMessageCopyWithImpl(_$_HorizontalButtonsMessage _value,
      $Res Function(_$_HorizontalButtonsMessage) _then)
      : super(_value, (v) => _then(v as _$_HorizontalButtonsMessage));

  @override
  _$_HorizontalButtonsMessage get _value =>
      super._value as _$_HorizontalButtonsMessage;

  @override
  $Res call({
    Object? reference = freezed,
    Object? buttons = freezed,
  }) {
    return _then(_$_HorizontalButtonsMessage(
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      buttons: buttons == freezed
          ? _value._buttons
          : buttons // ignore: cast_nullable_to_non_nullable
              as List<ButtonOption>,
    ));
  }
}

/// @nodoc

class _$_HorizontalButtonsMessage extends _HorizontalButtonsMessage {
  const _$_HorizontalButtonsMessage(
      {required this.reference, required final List<ButtonOption> buttons})
      : _buttons = buttons,
        super._();

  @override
  final String reference;
  final List<ButtonOption> _buttons;
  @override
  List<ButtonOption> get buttons {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_buttons);
  }

  @override
  String toString() {
    return 'QuizMessage.horizontalButtons(reference: $reference, buttons: $buttons)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HorizontalButtonsMessage &&
            const DeepCollectionEquality().equals(other.reference, reference) &&
            const DeepCollectionEquality().equals(other._buttons, _buttons));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(reference),
      const DeepCollectionEquality().hash(_buttons));

  @JsonKey(ignore: true)
  @override
  _$$_HorizontalButtonsMessageCopyWith<_$_HorizontalButtonsMessage>
      get copyWith => __$$_HorizontalButtonsMessageCopyWithImpl<
          _$_HorizontalButtonsMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String reference, String content) text,
    required TResult Function(String reference, String content,
            UserAnswer? answer, AnswerStatus status)
        sent,
    required TResult Function(String reference, List<ButtonOption> buttons)
        horizontalButtons,
    required TResult Function(String reference, List<MessageOption> options)
        singleChoice,
    required TResult Function(String reference, List<MessageOption> options)
        multipleChoices,
  }) {
    return horizontalButtons(reference, buttons);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
  }) {
    return horizontalButtons?.call(reference, buttons);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
    required TResult orElse(),
  }) {
    if (horizontalButtons != null) {
      return horizontalButtons(reference, buttons);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TextMessage value) text,
    required TResult Function(_SentMessage value) sent,
    required TResult Function(_HorizontalButtonsMessage value)
        horizontalButtons,
    required TResult Function(_SingleChoiceMessage value) singleChoice,
    required TResult Function(_MultipleChoiceMessage value) multipleChoices,
  }) {
    return horizontalButtons(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
  }) {
    return horizontalButtons?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
    required TResult orElse(),
  }) {
    if (horizontalButtons != null) {
      return horizontalButtons(this);
    }
    return orElse();
  }
}

abstract class _HorizontalButtonsMessage extends QuizMessage {
  const factory _HorizontalButtonsMessage(
      {required final String reference,
      required final List<ButtonOption> buttons}) = _$_HorizontalButtonsMessage;
  const _HorizontalButtonsMessage._() : super._();

  @override
  String get reference;
  List<ButtonOption> get buttons;
  @override
  @JsonKey(ignore: true)
  _$$_HorizontalButtonsMessageCopyWith<_$_HorizontalButtonsMessage>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SingleChoiceMessageCopyWith<$Res>
    implements $QuizMessageCopyWith<$Res> {
  factory _$$_SingleChoiceMessageCopyWith(_$_SingleChoiceMessage value,
          $Res Function(_$_SingleChoiceMessage) then) =
      __$$_SingleChoiceMessageCopyWithImpl<$Res>;
  @override
  $Res call({String reference, List<MessageOption> options});
}

/// @nodoc
class __$$_SingleChoiceMessageCopyWithImpl<$Res>
    extends _$QuizMessageCopyWithImpl<$Res>
    implements _$$_SingleChoiceMessageCopyWith<$Res> {
  __$$_SingleChoiceMessageCopyWithImpl(_$_SingleChoiceMessage _value,
      $Res Function(_$_SingleChoiceMessage) _then)
      : super(_value, (v) => _then(v as _$_SingleChoiceMessage));

  @override
  _$_SingleChoiceMessage get _value => super._value as _$_SingleChoiceMessage;

  @override
  $Res call({
    Object? reference = freezed,
    Object? options = freezed,
  }) {
    return _then(_$_SingleChoiceMessage(
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      options: options == freezed
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<MessageOption>,
    ));
  }
}

/// @nodoc

class _$_SingleChoiceMessage extends _SingleChoiceMessage {
  const _$_SingleChoiceMessage(
      {required this.reference, required final List<MessageOption> options})
      : _options = options,
        super._();

  @override
  final String reference;
  final List<MessageOption> _options;
  @override
  List<MessageOption> get options {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'QuizMessage.singleChoice(reference: $reference, options: $options)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SingleChoiceMessage &&
            const DeepCollectionEquality().equals(other.reference, reference) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(reference),
      const DeepCollectionEquality().hash(_options));

  @JsonKey(ignore: true)
  @override
  _$$_SingleChoiceMessageCopyWith<_$_SingleChoiceMessage> get copyWith =>
      __$$_SingleChoiceMessageCopyWithImpl<_$_SingleChoiceMessage>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String reference, String content) text,
    required TResult Function(String reference, String content,
            UserAnswer? answer, AnswerStatus status)
        sent,
    required TResult Function(String reference, List<ButtonOption> buttons)
        horizontalButtons,
    required TResult Function(String reference, List<MessageOption> options)
        singleChoice,
    required TResult Function(String reference, List<MessageOption> options)
        multipleChoices,
  }) {
    return singleChoice(reference, options);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
  }) {
    return singleChoice?.call(reference, options);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
    required TResult orElse(),
  }) {
    if (singleChoice != null) {
      return singleChoice(reference, options);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TextMessage value) text,
    required TResult Function(_SentMessage value) sent,
    required TResult Function(_HorizontalButtonsMessage value)
        horizontalButtons,
    required TResult Function(_SingleChoiceMessage value) singleChoice,
    required TResult Function(_MultipleChoiceMessage value) multipleChoices,
  }) {
    return singleChoice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
  }) {
    return singleChoice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
    required TResult orElse(),
  }) {
    if (singleChoice != null) {
      return singleChoice(this);
    }
    return orElse();
  }
}

abstract class _SingleChoiceMessage extends QuizMessage {
  const factory _SingleChoiceMessage(
      {required final String reference,
      required final List<MessageOption> options}) = _$_SingleChoiceMessage;
  const _SingleChoiceMessage._() : super._();

  @override
  String get reference;
  List<MessageOption> get options;
  @override
  @JsonKey(ignore: true)
  _$$_SingleChoiceMessageCopyWith<_$_SingleChoiceMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_MultipleChoiceMessageCopyWith<$Res>
    implements $QuizMessageCopyWith<$Res> {
  factory _$$_MultipleChoiceMessageCopyWith(_$_MultipleChoiceMessage value,
          $Res Function(_$_MultipleChoiceMessage) then) =
      __$$_MultipleChoiceMessageCopyWithImpl<$Res>;
  @override
  $Res call({String reference, List<MessageOption> options});
}

/// @nodoc
class __$$_MultipleChoiceMessageCopyWithImpl<$Res>
    extends _$QuizMessageCopyWithImpl<$Res>
    implements _$$_MultipleChoiceMessageCopyWith<$Res> {
  __$$_MultipleChoiceMessageCopyWithImpl(_$_MultipleChoiceMessage _value,
      $Res Function(_$_MultipleChoiceMessage) _then)
      : super(_value, (v) => _then(v as _$_MultipleChoiceMessage));

  @override
  _$_MultipleChoiceMessage get _value =>
      super._value as _$_MultipleChoiceMessage;

  @override
  $Res call({
    Object? reference = freezed,
    Object? options = freezed,
  }) {
    return _then(_$_MultipleChoiceMessage(
      reference: reference == freezed
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      options: options == freezed
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<MessageOption>,
    ));
  }
}

/// @nodoc

class _$_MultipleChoiceMessage extends _MultipleChoiceMessage {
  const _$_MultipleChoiceMessage(
      {required this.reference, required final List<MessageOption> options})
      : _options = options,
        super._();

  @override
  final String reference;
  final List<MessageOption> _options;
  @override
  List<MessageOption> get options {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'QuizMessage.multipleChoices(reference: $reference, options: $options)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MultipleChoiceMessage &&
            const DeepCollectionEquality().equals(other.reference, reference) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(reference),
      const DeepCollectionEquality().hash(_options));

  @JsonKey(ignore: true)
  @override
  _$$_MultipleChoiceMessageCopyWith<_$_MultipleChoiceMessage> get copyWith =>
      __$$_MultipleChoiceMessageCopyWithImpl<_$_MultipleChoiceMessage>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String reference, String content) text,
    required TResult Function(String reference, String content,
            UserAnswer? answer, AnswerStatus status)
        sent,
    required TResult Function(String reference, List<ButtonOption> buttons)
        horizontalButtons,
    required TResult Function(String reference, List<MessageOption> options)
        singleChoice,
    required TResult Function(String reference, List<MessageOption> options)
        multipleChoices,
  }) {
    return multipleChoices(reference, options);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
  }) {
    return multipleChoices?.call(reference, options);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String reference, String content)? text,
    TResult Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult Function(String reference, List<MessageOption> options)?
        multipleChoices,
    required TResult orElse(),
  }) {
    if (multipleChoices != null) {
      return multipleChoices(reference, options);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TextMessage value) text,
    required TResult Function(_SentMessage value) sent,
    required TResult Function(_HorizontalButtonsMessage value)
        horizontalButtons,
    required TResult Function(_SingleChoiceMessage value) singleChoice,
    required TResult Function(_MultipleChoiceMessage value) multipleChoices,
  }) {
    return multipleChoices(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
  }) {
    return multipleChoices?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TextMessage value)? text,
    TResult Function(_SentMessage value)? sent,
    TResult Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult Function(_SingleChoiceMessage value)? singleChoice,
    TResult Function(_MultipleChoiceMessage value)? multipleChoices,
    required TResult orElse(),
  }) {
    if (multipleChoices != null) {
      return multipleChoices(this);
    }
    return orElse();
  }
}

abstract class _MultipleChoiceMessage extends QuizMessage {
  const factory _MultipleChoiceMessage(
      {required final String reference,
      required final List<MessageOption> options}) = _$_MultipleChoiceMessage;
  const _MultipleChoiceMessage._() : super._();

  @override
  String get reference;
  List<MessageOption> get options;
  @override
  @JsonKey(ignore: true)
  _$$_MultipleChoiceMessageCopyWith<_$_MultipleChoiceMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MessageOption {
  String get label => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String label, String value) $default, {
    required TResult Function(String label, String value, ButtonAction? action)
        button,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String label, String value)? $default, {
    TResult Function(String label, String value, ButtonAction? action)? button,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String label, String value)? $default, {
    TResult Function(String label, String value, ButtonAction? action)? button,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MessageOption value) $default, {
    required TResult Function(ButtonOption value) button,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_MessageOption value)? $default, {
    TResult Function(ButtonOption value)? button,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MessageOption value)? $default, {
    TResult Function(ButtonOption value)? button,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageOptionCopyWith<MessageOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageOptionCopyWith<$Res> {
  factory $MessageOptionCopyWith(
          MessageOption value, $Res Function(MessageOption) then) =
      _$MessageOptionCopyWithImpl<$Res>;
  $Res call({String label, String value});
}

/// @nodoc
class _$MessageOptionCopyWithImpl<$Res>
    implements $MessageOptionCopyWith<$Res> {
  _$MessageOptionCopyWithImpl(this._value, this._then);

  final MessageOption _value;
  // ignore: unused_field
  final $Res Function(MessageOption) _then;

  @override
  $Res call({
    Object? label = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageOptionCopyWith<$Res>
    implements $MessageOptionCopyWith<$Res> {
  factory _$$_MessageOptionCopyWith(
          _$_MessageOption value, $Res Function(_$_MessageOption) then) =
      __$$_MessageOptionCopyWithImpl<$Res>;
  @override
  $Res call({String label, String value});
}

/// @nodoc
class __$$_MessageOptionCopyWithImpl<$Res>
    extends _$MessageOptionCopyWithImpl<$Res>
    implements _$$_MessageOptionCopyWith<$Res> {
  __$$_MessageOptionCopyWithImpl(
      _$_MessageOption _value, $Res Function(_$_MessageOption) _then)
      : super(_value, (v) => _then(v as _$_MessageOption));

  @override
  _$_MessageOption get _value => super._value as _$_MessageOption;

  @override
  $Res call({
    Object? label = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_MessageOption(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_MessageOption extends _MessageOption {
  const _$_MessageOption({required this.label, required this.value})
      : super._();

  @override
  final String label;
  @override
  final String value;

  @override
  String toString() {
    return 'MessageOption(label: $label, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageOption &&
            const DeepCollectionEquality().equals(other.label, label) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(label),
      const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_MessageOptionCopyWith<_$_MessageOption> get copyWith =>
      __$$_MessageOptionCopyWithImpl<_$_MessageOption>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String label, String value) $default, {
    required TResult Function(String label, String value, ButtonAction? action)
        button,
  }) {
    return $default(label, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String label, String value)? $default, {
    TResult Function(String label, String value, ButtonAction? action)? button,
  }) {
    return $default?.call(label, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String label, String value)? $default, {
    TResult Function(String label, String value, ButtonAction? action)? button,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(label, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MessageOption value) $default, {
    required TResult Function(ButtonOption value) button,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_MessageOption value)? $default, {
    TResult Function(ButtonOption value)? button,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MessageOption value)? $default, {
    TResult Function(ButtonOption value)? button,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _MessageOption extends MessageOption {
  const factory _MessageOption(
      {required final String label,
      required final String value}) = _$_MessageOption;
  const _MessageOption._() : super._();

  @override
  String get label;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$_MessageOptionCopyWith<_$_MessageOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ButtonOptionCopyWith<$Res>
    implements $MessageOptionCopyWith<$Res> {
  factory _$$ButtonOptionCopyWith(
          _$ButtonOption value, $Res Function(_$ButtonOption) then) =
      __$$ButtonOptionCopyWithImpl<$Res>;
  @override
  $Res call({String label, String value, ButtonAction? action});

  $ButtonActionCopyWith<$Res>? get action;
}

/// @nodoc
class __$$ButtonOptionCopyWithImpl<$Res>
    extends _$MessageOptionCopyWithImpl<$Res>
    implements _$$ButtonOptionCopyWith<$Res> {
  __$$ButtonOptionCopyWithImpl(
      _$ButtonOption _value, $Res Function(_$ButtonOption) _then)
      : super(_value, (v) => _then(v as _$ButtonOption));

  @override
  _$ButtonOption get _value => super._value as _$ButtonOption;

  @override
  $Res call({
    Object? label = freezed,
    Object? value = freezed,
    Object? action = freezed,
  }) {
    return _then(_$ButtonOption(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as ButtonAction?,
    ));
  }

  @override
  $ButtonActionCopyWith<$Res>? get action {
    if (_value.action == null) {
      return null;
    }

    return $ButtonActionCopyWith<$Res>(_value.action!, (value) {
      return _then(_value.copyWith(action: value));
    });
  }
}

/// @nodoc

class _$ButtonOption extends ButtonOption {
  const _$ButtonOption({required this.label, required this.value, this.action})
      : super._();

  @override
  final String label;
  @override
  final String value;
  @override
  final ButtonAction? action;

  @override
  String toString() {
    return 'MessageOption.button(label: $label, value: $value, action: $action)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ButtonOption &&
            const DeepCollectionEquality().equals(other.label, label) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.action, action));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(label),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(action));

  @JsonKey(ignore: true)
  @override
  _$$ButtonOptionCopyWith<_$ButtonOption> get copyWith =>
      __$$ButtonOptionCopyWithImpl<_$ButtonOption>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String label, String value) $default, {
    required TResult Function(String label, String value, ButtonAction? action)
        button,
  }) {
    return button(label, value, action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String label, String value)? $default, {
    TResult Function(String label, String value, ButtonAction? action)? button,
  }) {
    return button?.call(label, value, action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String label, String value)? $default, {
    TResult Function(String label, String value, ButtonAction? action)? button,
    required TResult orElse(),
  }) {
    if (button != null) {
      return button(label, value, action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MessageOption value) $default, {
    required TResult Function(ButtonOption value) button,
  }) {
    return button(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_MessageOption value)? $default, {
    TResult Function(ButtonOption value)? button,
  }) {
    return button?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MessageOption value)? $default, {
    TResult Function(ButtonOption value)? button,
    required TResult orElse(),
  }) {
    if (button != null) {
      return button(this);
    }
    return orElse();
  }
}

abstract class ButtonOption extends MessageOption {
  const factory ButtonOption(
      {required final String label,
      required final String value,
      final ButtonAction? action}) = _$ButtonOption;
  const ButtonOption._() : super._();

  @override
  String get label;
  @override
  String get value;
  ButtonAction? get action;
  @override
  @JsonKey(ignore: true)
  _$$ButtonOptionCopyWith<_$ButtonOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ButtonAction {
  String get route => throw _privateConstructorUsedError;
  String get readableResult => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String route, String readableResult) navigate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String route, String readableResult)? navigate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String route, String readableResult)? navigate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NavigateAction value) navigate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NavigateAction value)? navigate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NavigateAction value)? navigate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ButtonActionCopyWith<ButtonAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ButtonActionCopyWith<$Res> {
  factory $ButtonActionCopyWith(
          ButtonAction value, $Res Function(ButtonAction) then) =
      _$ButtonActionCopyWithImpl<$Res>;
  $Res call({String route, String readableResult});
}

/// @nodoc
class _$ButtonActionCopyWithImpl<$Res> implements $ButtonActionCopyWith<$Res> {
  _$ButtonActionCopyWithImpl(this._value, this._then);

  final ButtonAction _value;
  // ignore: unused_field
  final $Res Function(ButtonAction) _then;

  @override
  $Res call({
    Object? route = freezed,
    Object? readableResult = freezed,
  }) {
    return _then(_value.copyWith(
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      readableResult: readableResult == freezed
          ? _value.readableResult
          : readableResult // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_NavigateActionCopyWith<$Res>
    implements $ButtonActionCopyWith<$Res> {
  factory _$$_NavigateActionCopyWith(
          _$_NavigateAction value, $Res Function(_$_NavigateAction) then) =
      __$$_NavigateActionCopyWithImpl<$Res>;
  @override
  $Res call({String route, String readableResult});
}

/// @nodoc
class __$$_NavigateActionCopyWithImpl<$Res>
    extends _$ButtonActionCopyWithImpl<$Res>
    implements _$$_NavigateActionCopyWith<$Res> {
  __$$_NavigateActionCopyWithImpl(
      _$_NavigateAction _value, $Res Function(_$_NavigateAction) _then)
      : super(_value, (v) => _then(v as _$_NavigateAction));

  @override
  _$_NavigateAction get _value => super._value as _$_NavigateAction;

  @override
  $Res call({
    Object? route = freezed,
    Object? readableResult = freezed,
  }) {
    return _then(_$_NavigateAction(
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      readableResult: readableResult == freezed
          ? _value.readableResult
          : readableResult // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_NavigateAction extends _NavigateAction {
  const _$_NavigateAction({required this.route, required this.readableResult})
      : super._();

  @override
  final String route;
  @override
  final String readableResult;

  @override
  String toString() {
    return 'ButtonAction.navigate(route: $route, readableResult: $readableResult)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NavigateAction &&
            const DeepCollectionEquality().equals(other.route, route) &&
            const DeepCollectionEquality()
                .equals(other.readableResult, readableResult));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(route),
      const DeepCollectionEquality().hash(readableResult));

  @JsonKey(ignore: true)
  @override
  _$$_NavigateActionCopyWith<_$_NavigateAction> get copyWith =>
      __$$_NavigateActionCopyWithImpl<_$_NavigateAction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String route, String readableResult) navigate,
  }) {
    return navigate(route, readableResult);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String route, String readableResult)? navigate,
  }) {
    return navigate?.call(route, readableResult);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String route, String readableResult)? navigate,
    required TResult orElse(),
  }) {
    if (navigate != null) {
      return navigate(route, readableResult);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NavigateAction value) navigate,
  }) {
    return navigate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NavigateAction value)? navigate,
  }) {
    return navigate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NavigateAction value)? navigate,
    required TResult orElse(),
  }) {
    if (navigate != null) {
      return navigate(this);
    }
    return orElse();
  }
}

abstract class _NavigateAction extends ButtonAction {
  const factory _NavigateAction(
      {required final String route,
      required final String readableResult}) = _$_NavigateAction;
  const _NavigateAction._() : super._();

  @override
  String get route;
  @override
  String get readableResult;
  @override
  @JsonKey(ignore: true)
  _$$_NavigateActionCopyWith<_$_NavigateAction> get copyWith =>
      throw _privateConstructorUsedError;
}
