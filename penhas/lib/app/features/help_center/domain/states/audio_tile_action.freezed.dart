// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'audio_tile_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

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
  _ActionSheet actionSheet(AudioTileActionSheetEntity actionSheet) {
    return _ActionSheet(
      actionSheet,
    );
  }
}

// ignore: unused_element
const $AudioTileAction = _$AudioTileActionTearOff();

mixin _$AudioTileAction {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result notice(String message),
    @required Result actionSheet(AudioTileActionSheetEntity actionSheet),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result notice(String message),
    Result actionSheet(AudioTileActionSheetEntity actionSheet),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result notice(_Notice value),
    @required Result actionSheet(_ActionSheet value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result notice(_Notice value),
    Result actionSheet(_ActionSheet value),
    @required Result orElse(),
  });
}

abstract class $AudioTileActionCopyWith<$Res> {
  factory $AudioTileActionCopyWith(
          AudioTileAction value, $Res Function(AudioTileAction) then) =
      _$AudioTileActionCopyWithImpl<$Res>;
}

class _$AudioTileActionCopyWithImpl<$Res>
    implements $AudioTileActionCopyWith<$Res> {
  _$AudioTileActionCopyWithImpl(this._value, this._then);

  final AudioTileAction _value;
  // ignore: unused_field
  final $Res Function(AudioTileAction) _then;
}

abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

class __$InitialCopyWithImpl<$Res> extends _$AudioTileActionCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

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
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result notice(String message),
    @required Result actionSheet(AudioTileActionSheetEntity actionSheet),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result notice(String message),
    Result actionSheet(AudioTileActionSheetEntity actionSheet),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result notice(_Notice value),
    @required Result actionSheet(_ActionSheet value),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result notice(_Notice value),
    Result actionSheet(_ActionSheet value),
    @required Result orElse(),
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

abstract class _$NoticeCopyWith<$Res> {
  factory _$NoticeCopyWith(_Notice value, $Res Function(_Notice) then) =
      __$NoticeCopyWithImpl<$Res>;
  $Res call({String message});
}

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
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result notice(String message),
    @required Result actionSheet(AudioTileActionSheetEntity actionSheet),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return notice(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result notice(String message),
    Result actionSheet(AudioTileActionSheetEntity actionSheet),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (notice != null) {
      return notice(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result notice(_Notice value),
    @required Result actionSheet(_ActionSheet value),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return notice(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result notice(_Notice value),
    Result actionSheet(_ActionSheet value),
    @required Result orElse(),
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

abstract class _$ActionSheetCopyWith<$Res> {
  factory _$ActionSheetCopyWith(
          _ActionSheet value, $Res Function(_ActionSheet) then) =
      __$ActionSheetCopyWithImpl<$Res>;
  $Res call({AudioTileActionSheetEntity actionSheet});
}

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
    Object actionSheet = freezed,
  }) {
    return _then(_ActionSheet(
      actionSheet == freezed
          ? _value.actionSheet
          : actionSheet as AudioTileActionSheetEntity,
    ));
  }
}

class _$_ActionSheet with DiagnosticableTreeMixin implements _ActionSheet {
  const _$_ActionSheet(this.actionSheet) : assert(actionSheet != null);

  @override
  final AudioTileActionSheetEntity actionSheet;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AudioTileAction.actionSheet(actionSheet: $actionSheet)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AudioTileAction.actionSheet'))
      ..add(DiagnosticsProperty('actionSheet', actionSheet));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ActionSheet &&
            (identical(other.actionSheet, actionSheet) ||
                const DeepCollectionEquality()
                    .equals(other.actionSheet, actionSheet)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(actionSheet);

  @override
  _$ActionSheetCopyWith<_ActionSheet> get copyWith =>
      __$ActionSheetCopyWithImpl<_ActionSheet>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result notice(String message),
    @required Result actionSheet(AudioTileActionSheetEntity actionSheet),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return actionSheet(this.actionSheet);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result notice(String message),
    Result actionSheet(AudioTileActionSheetEntity actionSheet),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (actionSheet != null) {
      return actionSheet(this.actionSheet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result notice(_Notice value),
    @required Result actionSheet(_ActionSheet value),
  }) {
    assert(initial != null);
    assert(notice != null);
    assert(actionSheet != null);
    return actionSheet(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result notice(_Notice value),
    Result actionSheet(_ActionSheet value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (actionSheet != null) {
      return actionSheet(this);
    }
    return orElse();
  }
}

abstract class _ActionSheet implements AudioTileAction {
  const factory _ActionSheet(AudioTileActionSheetEntity actionSheet) =
      _$_ActionSheet;

  AudioTileActionSheetEntity get actionSheet;
  _$ActionSheetCopyWith<_ActionSheet> get copyWith;
}
