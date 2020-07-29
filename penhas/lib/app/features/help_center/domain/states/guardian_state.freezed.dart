// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'guardian_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$GuardianStateTearOff {
  const _$GuardianStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _Loaded loaded(List<GuardianTileEntity> tiles) {
    return _Loaded(
      tiles,
    );
  }

  _ErrorDetails error(String message) {
    return _ErrorDetails(
      message,
    );
  }
}

// ignore: unused_element
const $GuardianState = _$GuardianStateTearOff();

mixin _$GuardianState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loaded(List<GuardianTileEntity> tiles),
    @required Result error(String message),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loaded(List<GuardianTileEntity> tiles),
    Result error(String message),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loaded(_Loaded value),
    @required Result error(_ErrorDetails value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loaded(_Loaded value),
    Result error(_ErrorDetails value),
    @required Result orElse(),
  });
}

abstract class $GuardianStateCopyWith<$Res> {
  factory $GuardianStateCopyWith(
          GuardianState value, $Res Function(GuardianState) then) =
      _$GuardianStateCopyWithImpl<$Res>;
}

class _$GuardianStateCopyWithImpl<$Res>
    implements $GuardianStateCopyWith<$Res> {
  _$GuardianStateCopyWithImpl(this._value, this._then);

  final GuardianState _value;
  // ignore: unused_field
  final $Res Function(GuardianState) _then;
}

abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

class __$InitialCopyWithImpl<$Res> extends _$GuardianStateCopyWithImpl<$Res>
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
    return 'GuardianState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'GuardianState.initial'));
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
    @required Result loaded(List<GuardianTileEntity> tiles),
    @required Result error(String message),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loaded(List<GuardianTileEntity> tiles),
    Result error(String message),
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
    @required Result loaded(_Loaded value),
    @required Result error(_ErrorDetails value),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loaded(_Loaded value),
    Result error(_ErrorDetails value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements GuardianState {
  const factory _Initial() = _$_Initial;
}

abstract class _$LoadedCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) then) =
      __$LoadedCopyWithImpl<$Res>;
  $Res call({List<GuardianTileEntity> tiles});
}

class __$LoadedCopyWithImpl<$Res> extends _$GuardianStateCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(_Loaded _value, $Res Function(_Loaded) _then)
      : super(_value, (v) => _then(v as _Loaded));

  @override
  _Loaded get _value => super._value as _Loaded;

  @override
  $Res call({
    Object tiles = freezed,
  }) {
    return _then(_Loaded(
      tiles == freezed ? _value.tiles : tiles as List<GuardianTileEntity>,
    ));
  }
}

class _$_Loaded with DiagnosticableTreeMixin implements _Loaded {
  const _$_Loaded(this.tiles) : assert(tiles != null);

  @override
  final List<GuardianTileEntity> tiles;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GuardianState.loaded(tiles: $tiles)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GuardianState.loaded'))
      ..add(DiagnosticsProperty('tiles', tiles));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Loaded &&
            (identical(other.tiles, tiles) ||
                const DeepCollectionEquality().equals(other.tiles, tiles)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(tiles);

  @override
  _$LoadedCopyWith<_Loaded> get copyWith =>
      __$LoadedCopyWithImpl<_Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loaded(List<GuardianTileEntity> tiles),
    @required Result error(String message),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return loaded(tiles);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loaded(List<GuardianTileEntity> tiles),
    Result error(String message),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(tiles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loaded(_Loaded value),
    @required Result error(_ErrorDetails value),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loaded(_Loaded value),
    Result error(_ErrorDetails value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements GuardianState {
  const factory _Loaded(List<GuardianTileEntity> tiles) = _$_Loaded;

  List<GuardianTileEntity> get tiles;
  _$LoadedCopyWith<_Loaded> get copyWith;
}

abstract class _$ErrorDetailsCopyWith<$Res> {
  factory _$ErrorDetailsCopyWith(
          _ErrorDetails value, $Res Function(_ErrorDetails) then) =
      __$ErrorDetailsCopyWithImpl<$Res>;
  $Res call({String message});
}

class __$ErrorDetailsCopyWithImpl<$Res>
    extends _$GuardianStateCopyWithImpl<$Res>
    implements _$ErrorDetailsCopyWith<$Res> {
  __$ErrorDetailsCopyWithImpl(
      _ErrorDetails _value, $Res Function(_ErrorDetails) _then)
      : super(_value, (v) => _then(v as _ErrorDetails));

  @override
  _ErrorDetails get _value => super._value as _ErrorDetails;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_ErrorDetails(
      message == freezed ? _value.message : message as String,
    ));
  }
}

class _$_ErrorDetails with DiagnosticableTreeMixin implements _ErrorDetails {
  const _$_ErrorDetails(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GuardianState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GuardianState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ErrorDetails &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  _$ErrorDetailsCopyWith<_ErrorDetails> get copyWith =>
      __$ErrorDetailsCopyWithImpl<_ErrorDetails>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loaded(List<GuardianTileEntity> tiles),
    @required Result error(String message),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return error(message);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loaded(List<GuardianTileEntity> tiles),
    Result error(String message),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loaded(_Loaded value),
    @required Result error(_ErrorDetails value),
  }) {
    assert(initial != null);
    assert(loaded != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loaded(_Loaded value),
    Result error(_ErrorDetails value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorDetails implements GuardianState {
  const factory _ErrorDetails(String message) = _$_ErrorDetails;

  String get message;
  _$ErrorDetailsCopyWith<_ErrorDetails> get copyWith;
}
