// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_tile_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioTileAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) notice,
    required TResult Function(AudioEntity audio) actionSheet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? notice,
    TResult? Function(AudioEntity audio)? actionSheet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? notice,
    TResult Function(AudioEntity audio)? actionSheet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Notice value) notice,
    required TResult Function(_ActionSheet value) actionSheet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Notice value)? notice,
    TResult? Function(_ActionSheet value)? actionSheet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Notice value)? notice,
    TResult Function(_ActionSheet value)? actionSheet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioTileActionCopyWith<$Res> {
  factory $AudioTileActionCopyWith(
          AudioTileAction value, $Res Function(AudioTileAction) then) =
      _$AudioTileActionCopyWithImpl<$Res, AudioTileAction>;
}

/// @nodoc
class _$AudioTileActionCopyWithImpl<$Res, $Val extends AudioTileAction>
    implements $AudioTileActionCopyWith<$Res> {
  _$AudioTileActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AudioTileActionCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AudioTileAction.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) notice,
    required TResult Function(AudioEntity audio) actionSheet,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? notice,
    TResult? Function(AudioEntity audio)? actionSheet,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? notice,
    TResult Function(AudioEntity audio)? actionSheet,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Notice value) notice,
    required TResult Function(_ActionSheet value) actionSheet,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Notice value)? notice,
    TResult? Function(_ActionSheet value)? actionSheet,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Notice value)? notice,
    TResult Function(_ActionSheet value)? actionSheet,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AudioTileAction {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$NoticeImplCopyWith<$Res> {
  factory _$$NoticeImplCopyWith(
          _$NoticeImpl value, $Res Function(_$NoticeImpl) then) =
      __$$NoticeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NoticeImplCopyWithImpl<$Res>
    extends _$AudioTileActionCopyWithImpl<$Res, _$NoticeImpl>
    implements _$$NoticeImplCopyWith<$Res> {
  __$$NoticeImplCopyWithImpl(
      _$NoticeImpl _value, $Res Function(_$NoticeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$NoticeImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NoticeImpl implements _Notice {
  const _$NoticeImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AudioTileAction.notice(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeImplCopyWith<_$NoticeImpl> get copyWith =>
      __$$NoticeImplCopyWithImpl<_$NoticeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) notice,
    required TResult Function(AudioEntity audio) actionSheet,
  }) {
    return notice(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? notice,
    TResult? Function(AudioEntity audio)? actionSheet,
  }) {
    return notice?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? notice,
    TResult Function(AudioEntity audio)? actionSheet,
    required TResult orElse(),
  }) {
    if (notice != null) {
      return notice(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Notice value) notice,
    required TResult Function(_ActionSheet value) actionSheet,
  }) {
    return notice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Notice value)? notice,
    TResult? Function(_ActionSheet value)? actionSheet,
  }) {
    return notice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Notice value)? notice,
    TResult Function(_ActionSheet value)? actionSheet,
    required TResult orElse(),
  }) {
    if (notice != null) {
      return notice(this);
    }
    return orElse();
  }
}

abstract class _Notice implements AudioTileAction {
  const factory _Notice(final String message) = _$NoticeImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$NoticeImplCopyWith<_$NoticeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActionSheetImplCopyWith<$Res> {
  factory _$$ActionSheetImplCopyWith(
          _$ActionSheetImpl value, $Res Function(_$ActionSheetImpl) then) =
      __$$ActionSheetImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AudioEntity audio});
}

/// @nodoc
class __$$ActionSheetImplCopyWithImpl<$Res>
    extends _$AudioTileActionCopyWithImpl<$Res, _$ActionSheetImpl>
    implements _$$ActionSheetImplCopyWith<$Res> {
  __$$ActionSheetImplCopyWithImpl(
      _$ActionSheetImpl _value, $Res Function(_$ActionSheetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audio = null,
  }) {
    return _then(_$ActionSheetImpl(
      null == audio
          ? _value.audio
          : audio // ignore: cast_nullable_to_non_nullable
              as AudioEntity,
    ));
  }
}

/// @nodoc

class _$ActionSheetImpl implements _ActionSheet {
  const _$ActionSheetImpl(this.audio);

  @override
  final AudioEntity audio;

  @override
  String toString() {
    return 'AudioTileAction.actionSheet(audio: $audio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionSheetImpl &&
            (identical(other.audio, audio) || other.audio == audio));
  }

  @override
  int get hashCode => Object.hash(runtimeType, audio);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionSheetImplCopyWith<_$ActionSheetImpl> get copyWith =>
      __$$ActionSheetImplCopyWithImpl<_$ActionSheetImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String message) notice,
    required TResult Function(AudioEntity audio) actionSheet,
  }) {
    return actionSheet(audio);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String message)? notice,
    TResult? Function(AudioEntity audio)? actionSheet,
  }) {
    return actionSheet?.call(audio);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String message)? notice,
    TResult Function(AudioEntity audio)? actionSheet,
    required TResult orElse(),
  }) {
    if (actionSheet != null) {
      return actionSheet(audio);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Notice value) notice,
    required TResult Function(_ActionSheet value) actionSheet,
  }) {
    return actionSheet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Notice value)? notice,
    TResult? Function(_ActionSheet value)? actionSheet,
  }) {
    return actionSheet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Notice value)? notice,
    TResult Function(_ActionSheet value)? actionSheet,
    required TResult orElse(),
  }) {
    if (actionSheet != null) {
      return actionSheet(this);
    }
    return orElse();
  }
}

abstract class _ActionSheet implements AudioTileAction {
  const factory _ActionSheet(final AudioEntity audio) = _$ActionSheetImpl;

  AudioEntity get audio;
  @JsonKey(ignore: true)
  _$$ActionSheetImplCopyWith<_$ActionSheetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
