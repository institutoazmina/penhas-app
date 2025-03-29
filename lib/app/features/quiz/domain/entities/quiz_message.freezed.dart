// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
    TResult? Function(String reference, String content)? text,
    TResult? Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult? Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult? Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult? Function(String reference, List<MessageOption> options)?
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
    TResult? Function(_TextMessage value)? text,
    TResult? Function(_SentMessage value)? sent,
    TResult? Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult? Function(_SingleChoiceMessage value)? singleChoice,
    TResult? Function(_MultipleChoiceMessage value)? multipleChoices,
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

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizMessageCopyWith<QuizMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizMessageCopyWith<$Res> {
  factory $QuizMessageCopyWith(
          QuizMessage value, $Res Function(QuizMessage) then) =
      _$QuizMessageCopyWithImpl<$Res, QuizMessage>;
  @useResult
  $Res call({String reference});
}

/// @nodoc
class _$QuizMessageCopyWithImpl<$Res, $Val extends QuizMessage>
    implements $QuizMessageCopyWith<$Res> {
  _$QuizMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = null,
  }) {
    return _then(_value.copyWith(
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextMessageImplCopyWith<$Res>
    implements $QuizMessageCopyWith<$Res> {
  factory _$$TextMessageImplCopyWith(
          _$TextMessageImpl value, $Res Function(_$TextMessageImpl) then) =
      __$$TextMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String reference, String content});
}

/// @nodoc
class __$$TextMessageImplCopyWithImpl<$Res>
    extends _$QuizMessageCopyWithImpl<$Res, _$TextMessageImpl>
    implements _$$TextMessageImplCopyWith<$Res> {
  __$$TextMessageImplCopyWithImpl(
      _$TextMessageImpl _value, $Res Function(_$TextMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = null,
    Object? content = null,
  }) {
    return _then(_$TextMessageImpl(
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TextMessageImpl extends _TextMessage {
  const _$TextMessageImpl({this.reference = '', required this.content})
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextMessageImpl &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference, content);

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextMessageImplCopyWith<_$TextMessageImpl> get copyWith =>
      __$$TextMessageImplCopyWithImpl<_$TextMessageImpl>(this, _$identity);

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
    TResult? Function(String reference, String content)? text,
    TResult? Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult? Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult? Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult? Function(String reference, List<MessageOption> options)?
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
    TResult? Function(_TextMessage value)? text,
    TResult? Function(_SentMessage value)? sent,
    TResult? Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult? Function(_SingleChoiceMessage value)? singleChoice,
    TResult? Function(_MultipleChoiceMessage value)? multipleChoices,
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
      {final String reference,
      required final String content}) = _$TextMessageImpl;
  const _TextMessage._() : super._();

  @override
  String get reference;
  String get content;

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextMessageImplCopyWith<_$TextMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SentMessageImplCopyWith<$Res>
    implements $QuizMessageCopyWith<$Res> {
  factory _$$SentMessageImplCopyWith(
          _$SentMessageImpl value, $Res Function(_$SentMessageImpl) then) =
      __$$SentMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String reference,
      String content,
      UserAnswer? answer,
      AnswerStatus status});
}

/// @nodoc
class __$$SentMessageImplCopyWithImpl<$Res>
    extends _$QuizMessageCopyWithImpl<$Res, _$SentMessageImpl>
    implements _$$SentMessageImplCopyWith<$Res> {
  __$$SentMessageImplCopyWithImpl(
      _$SentMessageImpl _value, $Res Function(_$SentMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = null,
    Object? content = null,
    Object? answer = freezed,
    Object? status = null,
  }) {
    return _then(_$SentMessageImpl(
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as UserAnswer?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AnswerStatus,
    ));
  }
}

/// @nodoc

class _$SentMessageImpl extends _SentMessage {
  const _$SentMessageImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentMessageImpl &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, reference, content, answer, status);

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SentMessageImplCopyWith<_$SentMessageImpl> get copyWith =>
      __$$SentMessageImplCopyWithImpl<_$SentMessageImpl>(this, _$identity);

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
    TResult? Function(String reference, String content)? text,
    TResult? Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult? Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult? Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult? Function(String reference, List<MessageOption> options)?
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
    TResult? Function(_TextMessage value)? text,
    TResult? Function(_SentMessage value)? sent,
    TResult? Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult? Function(_SingleChoiceMessage value)? singleChoice,
    TResult? Function(_MultipleChoiceMessage value)? multipleChoices,
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
      final AnswerStatus status}) = _$SentMessageImpl;
  const _SentMessage._() : super._();

  @override
  String get reference;
  String get content;
  UserAnswer? get answer;
  AnswerStatus get status;

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SentMessageImplCopyWith<_$SentMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HorizontalButtonsMessageImplCopyWith<$Res>
    implements $QuizMessageCopyWith<$Res> {
  factory _$$HorizontalButtonsMessageImplCopyWith(
          _$HorizontalButtonsMessageImpl value,
          $Res Function(_$HorizontalButtonsMessageImpl) then) =
      __$$HorizontalButtonsMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String reference, List<ButtonOption> buttons});
}

/// @nodoc
class __$$HorizontalButtonsMessageImplCopyWithImpl<$Res>
    extends _$QuizMessageCopyWithImpl<$Res, _$HorizontalButtonsMessageImpl>
    implements _$$HorizontalButtonsMessageImplCopyWith<$Res> {
  __$$HorizontalButtonsMessageImplCopyWithImpl(
      _$HorizontalButtonsMessageImpl _value,
      $Res Function(_$HorizontalButtonsMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = null,
    Object? buttons = null,
  }) {
    return _then(_$HorizontalButtonsMessageImpl(
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      buttons: null == buttons
          ? _value._buttons
          : buttons // ignore: cast_nullable_to_non_nullable
              as List<ButtonOption>,
    ));
  }
}

/// @nodoc

class _$HorizontalButtonsMessageImpl extends _HorizontalButtonsMessage {
  const _$HorizontalButtonsMessageImpl(
      {required this.reference, required final List<ButtonOption> buttons})
      : _buttons = buttons,
        super._();

  @override
  final String reference;
  final List<ButtonOption> _buttons;
  @override
  List<ButtonOption> get buttons {
    if (_buttons is EqualUnmodifiableListView) return _buttons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_buttons);
  }

  @override
  String toString() {
    return 'QuizMessage.horizontalButtons(reference: $reference, buttons: $buttons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HorizontalButtonsMessageImpl &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            const DeepCollectionEquality().equals(other._buttons, _buttons));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, reference, const DeepCollectionEquality().hash(_buttons));

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HorizontalButtonsMessageImplCopyWith<_$HorizontalButtonsMessageImpl>
      get copyWith => __$$HorizontalButtonsMessageImplCopyWithImpl<
          _$HorizontalButtonsMessageImpl>(this, _$identity);

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
    TResult? Function(String reference, String content)? text,
    TResult? Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult? Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult? Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult? Function(String reference, List<MessageOption> options)?
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
    TResult? Function(_TextMessage value)? text,
    TResult? Function(_SentMessage value)? sent,
    TResult? Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult? Function(_SingleChoiceMessage value)? singleChoice,
    TResult? Function(_MultipleChoiceMessage value)? multipleChoices,
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
          required final List<ButtonOption> buttons}) =
      _$HorizontalButtonsMessageImpl;
  const _HorizontalButtonsMessage._() : super._();

  @override
  String get reference;
  List<ButtonOption> get buttons;

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HorizontalButtonsMessageImplCopyWith<_$HorizontalButtonsMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SingleChoiceMessageImplCopyWith<$Res>
    implements $QuizMessageCopyWith<$Res> {
  factory _$$SingleChoiceMessageImplCopyWith(_$SingleChoiceMessageImpl value,
          $Res Function(_$SingleChoiceMessageImpl) then) =
      __$$SingleChoiceMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String reference, List<MessageOption> options});
}

/// @nodoc
class __$$SingleChoiceMessageImplCopyWithImpl<$Res>
    extends _$QuizMessageCopyWithImpl<$Res, _$SingleChoiceMessageImpl>
    implements _$$SingleChoiceMessageImplCopyWith<$Res> {
  __$$SingleChoiceMessageImplCopyWithImpl(_$SingleChoiceMessageImpl _value,
      $Res Function(_$SingleChoiceMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = null,
    Object? options = null,
  }) {
    return _then(_$SingleChoiceMessageImpl(
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<MessageOption>,
    ));
  }
}

/// @nodoc

class _$SingleChoiceMessageImpl extends _SingleChoiceMessage {
  const _$SingleChoiceMessageImpl(
      {required this.reference, required final List<MessageOption> options})
      : _options = options,
        super._();

  @override
  final String reference;
  final List<MessageOption> _options;
  @override
  List<MessageOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'QuizMessage.singleChoice(reference: $reference, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SingleChoiceMessageImpl &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, reference, const DeepCollectionEquality().hash(_options));

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SingleChoiceMessageImplCopyWith<_$SingleChoiceMessageImpl> get copyWith =>
      __$$SingleChoiceMessageImplCopyWithImpl<_$SingleChoiceMessageImpl>(
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
    TResult? Function(String reference, String content)? text,
    TResult? Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult? Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult? Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult? Function(String reference, List<MessageOption> options)?
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
    TResult? Function(_TextMessage value)? text,
    TResult? Function(_SentMessage value)? sent,
    TResult? Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult? Function(_SingleChoiceMessage value)? singleChoice,
    TResult? Function(_MultipleChoiceMessage value)? multipleChoices,
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
      required final List<MessageOption> options}) = _$SingleChoiceMessageImpl;
  const _SingleChoiceMessage._() : super._();

  @override
  String get reference;
  List<MessageOption> get options;

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SingleChoiceMessageImplCopyWith<_$SingleChoiceMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MultipleChoiceMessageImplCopyWith<$Res>
    implements $QuizMessageCopyWith<$Res> {
  factory _$$MultipleChoiceMessageImplCopyWith(
          _$MultipleChoiceMessageImpl value,
          $Res Function(_$MultipleChoiceMessageImpl) then) =
      __$$MultipleChoiceMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String reference, List<MessageOption> options});
}

/// @nodoc
class __$$MultipleChoiceMessageImplCopyWithImpl<$Res>
    extends _$QuizMessageCopyWithImpl<$Res, _$MultipleChoiceMessageImpl>
    implements _$$MultipleChoiceMessageImplCopyWith<$Res> {
  __$$MultipleChoiceMessageImplCopyWithImpl(_$MultipleChoiceMessageImpl _value,
      $Res Function(_$MultipleChoiceMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reference = null,
    Object? options = null,
  }) {
    return _then(_$MultipleChoiceMessageImpl(
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<MessageOption>,
    ));
  }
}

/// @nodoc

class _$MultipleChoiceMessageImpl extends _MultipleChoiceMessage {
  const _$MultipleChoiceMessageImpl(
      {required this.reference, required final List<MessageOption> options})
      : _options = options,
        super._();

  @override
  final String reference;
  final List<MessageOption> _options;
  @override
  List<MessageOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'QuizMessage.multipleChoices(reference: $reference, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultipleChoiceMessageImpl &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, reference, const DeepCollectionEquality().hash(_options));

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MultipleChoiceMessageImplCopyWith<_$MultipleChoiceMessageImpl>
      get copyWith => __$$MultipleChoiceMessageImplCopyWithImpl<
          _$MultipleChoiceMessageImpl>(this, _$identity);

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
    TResult? Function(String reference, String content)? text,
    TResult? Function(String reference, String content, UserAnswer? answer,
            AnswerStatus status)?
        sent,
    TResult? Function(String reference, List<ButtonOption> buttons)?
        horizontalButtons,
    TResult? Function(String reference, List<MessageOption> options)?
        singleChoice,
    TResult? Function(String reference, List<MessageOption> options)?
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
    TResult? Function(_TextMessage value)? text,
    TResult? Function(_SentMessage value)? sent,
    TResult? Function(_HorizontalButtonsMessage value)? horizontalButtons,
    TResult? Function(_SingleChoiceMessage value)? singleChoice,
    TResult? Function(_MultipleChoiceMessage value)? multipleChoices,
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
          required final List<MessageOption> options}) =
      _$MultipleChoiceMessageImpl;
  const _MultipleChoiceMessage._() : super._();

  @override
  String get reference;
  List<MessageOption> get options;

  /// Create a copy of QuizMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MultipleChoiceMessageImplCopyWith<_$MultipleChoiceMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
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
    TResult? Function(String label, String value)? $default, {
    TResult? Function(String label, String value, ButtonAction? action)? button,
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
    TResult? Function(_MessageOption value)? $default, {
    TResult? Function(ButtonOption value)? button,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MessageOption value)? $default, {
    TResult Function(ButtonOption value)? button,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of MessageOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageOptionCopyWith<MessageOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageOptionCopyWith<$Res> {
  factory $MessageOptionCopyWith(
          MessageOption value, $Res Function(MessageOption) then) =
      _$MessageOptionCopyWithImpl<$Res, MessageOption>;
  @useResult
  $Res call({String label, String value});
}

/// @nodoc
class _$MessageOptionCopyWithImpl<$Res, $Val extends MessageOption>
    implements $MessageOptionCopyWith<$Res> {
  _$MessageOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageOptionImplCopyWith<$Res>
    implements $MessageOptionCopyWith<$Res> {
  factory _$$MessageOptionImplCopyWith(
          _$MessageOptionImpl value, $Res Function(_$MessageOptionImpl) then) =
      __$$MessageOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String value});
}

/// @nodoc
class __$$MessageOptionImplCopyWithImpl<$Res>
    extends _$MessageOptionCopyWithImpl<$Res, _$MessageOptionImpl>
    implements _$$MessageOptionImplCopyWith<$Res> {
  __$$MessageOptionImplCopyWithImpl(
      _$MessageOptionImpl _value, $Res Function(_$MessageOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
  }) {
    return _then(_$MessageOptionImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MessageOptionImpl extends _MessageOption {
  const _$MessageOptionImpl({required this.label, required this.value})
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageOptionImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, value);

  /// Create a copy of MessageOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageOptionImplCopyWith<_$MessageOptionImpl> get copyWith =>
      __$$MessageOptionImplCopyWithImpl<_$MessageOptionImpl>(this, _$identity);

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
    TResult? Function(String label, String value)? $default, {
    TResult? Function(String label, String value, ButtonAction? action)? button,
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
    TResult? Function(_MessageOption value)? $default, {
    TResult? Function(ButtonOption value)? button,
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
      required final String value}) = _$MessageOptionImpl;
  const _MessageOption._() : super._();

  @override
  String get label;
  @override
  String get value;

  /// Create a copy of MessageOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageOptionImplCopyWith<_$MessageOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ButtonOptionImplCopyWith<$Res>
    implements $MessageOptionCopyWith<$Res> {
  factory _$$ButtonOptionImplCopyWith(
          _$ButtonOptionImpl value, $Res Function(_$ButtonOptionImpl) then) =
      __$$ButtonOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String value, ButtonAction? action});

  $ButtonActionCopyWith<$Res>? get action;
}

/// @nodoc
class __$$ButtonOptionImplCopyWithImpl<$Res>
    extends _$MessageOptionCopyWithImpl<$Res, _$ButtonOptionImpl>
    implements _$$ButtonOptionImplCopyWith<$Res> {
  __$$ButtonOptionImplCopyWithImpl(
      _$ButtonOptionImpl _value, $Res Function(_$ButtonOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
    Object? action = freezed,
  }) {
    return _then(_$ButtonOptionImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as ButtonAction?,
    ));
  }

  /// Create a copy of MessageOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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

class _$ButtonOptionImpl extends ButtonOption {
  const _$ButtonOptionImpl(
      {required this.label, required this.value, this.action})
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ButtonOptionImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, value, action);

  /// Create a copy of MessageOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ButtonOptionImplCopyWith<_$ButtonOptionImpl> get copyWith =>
      __$$ButtonOptionImplCopyWithImpl<_$ButtonOptionImpl>(this, _$identity);

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
    TResult? Function(String label, String value)? $default, {
    TResult? Function(String label, String value, ButtonAction? action)? button,
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
    TResult? Function(_MessageOption value)? $default, {
    TResult? Function(ButtonOption value)? button,
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
      final ButtonAction? action}) = _$ButtonOptionImpl;
  const ButtonOption._() : super._();

  @override
  String get label;
  @override
  String get value;
  ButtonAction? get action;

  /// Create a copy of MessageOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ButtonOptionImplCopyWith<_$ButtonOptionImpl> get copyWith =>
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
    TResult? Function(String route, String readableResult)? navigate,
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
    TResult? Function(_NavigateAction value)? navigate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NavigateAction value)? navigate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ButtonAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ButtonActionCopyWith<ButtonAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ButtonActionCopyWith<$Res> {
  factory $ButtonActionCopyWith(
          ButtonAction value, $Res Function(ButtonAction) then) =
      _$ButtonActionCopyWithImpl<$Res, ButtonAction>;
  @useResult
  $Res call({String route, String readableResult});
}

/// @nodoc
class _$ButtonActionCopyWithImpl<$Res, $Val extends ButtonAction>
    implements $ButtonActionCopyWith<$Res> {
  _$ButtonActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ButtonAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? route = null,
    Object? readableResult = null,
  }) {
    return _then(_value.copyWith(
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      readableResult: null == readableResult
          ? _value.readableResult
          : readableResult // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NavigateActionImplCopyWith<$Res>
    implements $ButtonActionCopyWith<$Res> {
  factory _$$NavigateActionImplCopyWith(_$NavigateActionImpl value,
          $Res Function(_$NavigateActionImpl) then) =
      __$$NavigateActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String route, String readableResult});
}

/// @nodoc
class __$$NavigateActionImplCopyWithImpl<$Res>
    extends _$ButtonActionCopyWithImpl<$Res, _$NavigateActionImpl>
    implements _$$NavigateActionImplCopyWith<$Res> {
  __$$NavigateActionImplCopyWithImpl(
      _$NavigateActionImpl _value, $Res Function(_$NavigateActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ButtonAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? route = null,
    Object? readableResult = null,
  }) {
    return _then(_$NavigateActionImpl(
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      readableResult: null == readableResult
          ? _value.readableResult
          : readableResult // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NavigateActionImpl extends _NavigateAction {
  const _$NavigateActionImpl(
      {required this.route, required this.readableResult})
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigateActionImpl &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.readableResult, readableResult) ||
                other.readableResult == readableResult));
  }

  @override
  int get hashCode => Object.hash(runtimeType, route, readableResult);

  /// Create a copy of ButtonAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NavigateActionImplCopyWith<_$NavigateActionImpl> get copyWith =>
      __$$NavigateActionImplCopyWithImpl<_$NavigateActionImpl>(
          this, _$identity);

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
    TResult? Function(String route, String readableResult)? navigate,
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
    TResult? Function(_NavigateAction value)? navigate,
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
      required final String readableResult}) = _$NavigateActionImpl;
  const _NavigateAction._() : super._();

  @override
  String get route;
  @override
  String get readableResult;

  /// Create a copy of ButtonAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NavigateActionImplCopyWith<_$NavigateActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
