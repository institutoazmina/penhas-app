// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'audio_tile_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AudioTileActionTearOff {
  const _$AudioTileActionTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _Notice notice(String message) {
    return _Notice(
      message,
    );
  }

  _ActionSheet actionSheet(AudioEntity audio) {
    return _ActionSheet(
      audio,
    );
  }
}

/// @nodoc
const $AudioTileAction = _$AudioTileActionTearOff();

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
    TResult Function()? initial,
    TResult Function(String message)? notice,
    TResult Function(AudioEntity audio)? actionSheet,
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
    TResult Function(_Initial value)? initial,
    TResult Function(_Notice value)? notice,
    TResult Function(_ActionSheet value)? actionSheet,
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
      _$AudioTileActionCopyWithImpl<$Res>;
}

/// @nodoc
class _$AudioTileActionCopyWithImpl<$Res>
    implements $AudioTileActionCopyWith<$Res> {
  _$AudioTileActionCopyWithImpl(this._value, this._then);

  final AudioTileAction _value;
  // ignore: unused_field
  final $Res Function(AudioTileAction) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$AudioTileActionCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc

class _$_Initial with DiagnosticableTreeMixin implements _Initial {
  const _$_Initial();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AudioTileAction.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AudioTileAction.initial'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
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
    TResult Function()? initial,
    TResult Function(String message)? notice,
    TResult Function(AudioEntity audio)? actionSheet,
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
    TResult Function(_Initial value)? initial,
    TResult Function(_Notice value)? notice,
    TResult Function(_ActionSheet value)? actionSheet,
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
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$NoticeCopyWith<$Res> {
  factory _$NoticeCopyWith(_Notice value, $Res Function(_Notice) then) =
      __$NoticeCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$NoticeCopyWithImpl<$Res> extends _$AudioTileActionCopyWithImpl<$Res>
    implements _$NoticeCopyWith<$Res> {
  __$NoticeCopyWithImpl(_Notice _value, $Res Function(_Notice) _then)
      : super(_value, (v) => _then(v as _Notice));

  @override
  _Notice get _value => super._value as _Notice;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_Notice(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Notice with DiagnosticableTreeMixin implements _Notice {
  const _$_Notice(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AudioTileAction.notice(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AudioTileAction.notice'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Notice &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$NoticeCopyWith<_Notice> get copyWith =>
      __$NoticeCopyWithImpl<_Notice>(this, _$identity);

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
    TResult Function()? initial,
    TResult Function(String message)? notice,
    TResult Function(AudioEntity audio)? actionSheet,
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
    TResult Function(_Initial value)? initial,
    TResult Function(_Notice value)? notice,
    TResult Function(_ActionSheet value)? actionSheet,
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
  const factory _Notice(String message) = _$_Notice;

  String get message;
  @JsonKey(ignore: true)
  _$NoticeCopyWith<_Notice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ActionSheetCopyWith<$Res> {
  factory _$ActionSheetCopyWith(
          _ActionSheet value, $Res Function(_ActionSheet) then) =
      __$ActionSheetCopyWithImpl<$Res>;
  $Res call({AudioEntity audio});
}

/// @nodoc
class __$ActionSheetCopyWithImpl<$Res>
    extends _$AudioTileActionCopyWithImpl<$Res>
    implements _$ActionSheetCopyWith<$Res> {
  __$ActionSheetCopyWithImpl(
      _ActionSheet _value, $Res Function(_ActionSheet) _then)
      : super(_value, (v) => _then(v as _ActionSheet));

  @override
  _ActionSheet get _value => super._value as _ActionSheet;

  @override
  $Res call({
    Object? audio = freezed,
  }) {
    return _then(_ActionSheet(
      audio == freezed
          ? _value.audio
          : audio // ignore: cast_nullable_to_non_nullable
              as AudioEntity,
    ));
  }
}

/// @nodoc

class _$_ActionSheet with DiagnosticableTreeMixin implements _ActionSheet {
  const _$_ActionSheet(this.audio);

  @override
  final AudioEntity audio;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AudioTileAction.actionSheet(audio: $audio)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AudioTileAction.actionSheet'))
      ..add(DiagnosticsProperty('audio', audio));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ActionSheet &&
            const DeepCollectionEquality().equals(other.audio, audio));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(audio));

  @JsonKey(ignore: true)
  @override
  _$ActionSheetCopyWith<_ActionSheet> get copyWith =>
      __$ActionSheetCopyWithImpl<_ActionSheet>(this, _$identity);

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
    TResult Function()? initial,
    TResult Function(String message)? notice,
    TResult Function(AudioEntity audio)? actionSheet,
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
    TResult Function(_Initial value)? initial,
    TResult Function(_Notice value)? notice,
    TResult Function(_ActionSheet value)? actionSheet,
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
  const factory _ActionSheet(AudioEntity audio) = _$_ActionSheet;

  AudioEntity get audio;
  @JsonKey(ignore: true)
  _$ActionSheetCopyWith<_ActionSheet> get copyWith =>
      throw _privateConstructorUsedError;
}
