// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'audio_tile_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AudioTileActionTearOff {
  const _$AudioTileActionTearOff();

// ignore: unused_element
  _Initial initial() {
    return const _Initial();
  }

// ignore: unused_element
  _Notice notice(String message) {
    return _Notice(
      message,
    );
  }

// ignore: unused_element
  _ActionSheet actionSheet(AudioEntity audio) {
    return _ActionSheet(
      audio,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AudioTileAction = _$AudioTileActionTearOff();

/// @nodoc
mixin _$AudioTileAction {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult notice(String message),
    @required TResult actionSheet(AudioEntity audio),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult notice(String message),
    TResult actionSheet(AudioEntity audio),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult notice(_Notice value),
    @required TResult actionSheet(_ActionSheet value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult notice(_Notice value),
    TResult actionSheet(_ActionSheet value),
    @required TResult orElse(),
  });
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
    properties..add(DiagnosticsProperty('type', 'AudioTileAction.initial'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult notice(String message),
    @required TResult actionSheet(AudioEntity audio),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult notice(String message),
    TResult actionSheet(AudioEntity audio),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult notice(_Notice value),
    @required TResult actionSheet(_ActionSheet value),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult notice(_Notice value),
    TResult actionSheet(_ActionSheet value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
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
    Object message = freezed,
  }) {
    return _then(_Notice(
      message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$_Notice with DiagnosticableTreeMixin implements _Notice {
  const _$_Notice(this.message) : assert(message != null);

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
        (other is _Notice &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  _$NoticeCopyWith<_Notice> get copyWith =>
      __$NoticeCopyWithImpl<_Notice>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult notice(String message),
    @required TResult actionSheet(AudioEntity audio),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return notice(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult notice(String message),
    TResult actionSheet(AudioEntity audio),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (notice != null) {
      return notice(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult notice(_Notice value),
    @required TResult actionSheet(_ActionSheet value),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return notice(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult notice(_Notice value),
    TResult actionSheet(_ActionSheet value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (notice != null) {
      return notice(this);
    }
    return orElse();
  }
}

abstract class _Notice implements AudioTileAction {
  const factory _Notice(String message) = _$_Notice;

  String get message;
  _$NoticeCopyWith<_Notice> get copyWith;
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
    Object audio = freezed,
  }) {
    return _then(_ActionSheet(
      audio == freezed ? _value.audio : audio as AudioEntity,
    ));
  }
}

/// @nodoc
class _$_ActionSheet with DiagnosticableTreeMixin implements _ActionSheet {
  const _$_ActionSheet(this.audio) : assert(audio != null);

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
        (other is _ActionSheet &&
            (identical(other.audio, audio) ||
                const DeepCollectionEquality().equals(other.audio, audio)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(audio);

  @override
  _$ActionSheetCopyWith<_ActionSheet> get copyWith =>
      __$ActionSheetCopyWithImpl<_ActionSheet>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult notice(String message),
    @required TResult actionSheet(AudioEntity audio),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return actionSheet(audio);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult notice(String message),
    TResult actionSheet(AudioEntity audio),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (actionSheet != null) {
      return actionSheet(audio);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult notice(_Notice value),
    @required TResult actionSheet(_ActionSheet value),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return actionSheet(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult notice(_Notice value),
    TResult actionSheet(_ActionSheet value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (actionSheet != null) {
      return actionSheet(this);
    }
    return orElse();
  }
}

abstract class _ActionSheet implements AudioTileAction {
  const factory _ActionSheet(AudioEntity audio) = _$_ActionSheet;

  AudioEntity get audio;
  _$ActionSheetCopyWith<_ActionSheet> get copyWith;
}
