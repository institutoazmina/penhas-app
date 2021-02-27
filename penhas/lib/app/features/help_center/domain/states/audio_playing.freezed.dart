// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'audio_playing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AudioPlayingTearOff {
  const _$AudioPlayingTearOff();

// ignore: unused_element
  _None none() {
    return const _None();
  }

// ignore: unused_element
  _Playing playing(AudioEntity audio) {
    return _Playing(
      audio,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AudioPlaying = _$AudioPlayingTearOff();

/// @nodoc
mixin _$AudioPlaying {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult none(),
    @required TResult playing(AudioEntity audio),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult none(),
    TResult playing(AudioEntity audio),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult none(_None value),
    @required TResult playing(_Playing value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult none(_None value),
    TResult playing(_Playing value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $AudioPlayingCopyWith<$Res> {
  factory $AudioPlayingCopyWith(
          AudioPlaying value, $Res Function(AudioPlaying) then) =
      _$AudioPlayingCopyWithImpl<$Res>;
}

/// @nodoc
class _$AudioPlayingCopyWithImpl<$Res> implements $AudioPlayingCopyWith<$Res> {
  _$AudioPlayingCopyWithImpl(this._value, this._then);

  final AudioPlaying _value;
  // ignore: unused_field
  final $Res Function(AudioPlaying) _then;
}

/// @nodoc
abstract class _$NoneCopyWith<$Res> {
  factory _$NoneCopyWith(_None value, $Res Function(_None) then) =
      __$NoneCopyWithImpl<$Res>;
}

/// @nodoc
class __$NoneCopyWithImpl<$Res> extends _$AudioPlayingCopyWithImpl<$Res>
    implements _$NoneCopyWith<$Res> {
  __$NoneCopyWithImpl(_None _value, $Res Function(_None) _then)
      : super(_value, (v) => _then(v as _None));

  @override
  _None get _value => super._value as _None;
}

/// @nodoc
class _$_None implements _None {
  const _$_None();

  @override
  String toString() {
    return 'AudioPlaying.none()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _None);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult none(),
    @required TResult playing(AudioEntity audio),
  }) {
    assert(none != null);
    assert(playing != null);
    return none();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult none(),
    TResult playing(AudioEntity audio),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult none(_None value),
    @required TResult playing(_Playing value),
  }) {
    assert(none != null);
    assert(playing != null);
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult none(_None value),
    TResult playing(_Playing value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _None implements AudioPlaying {
  const factory _None() = _$_None;
}

/// @nodoc
abstract class _$PlayingCopyWith<$Res> {
  factory _$PlayingCopyWith(_Playing value, $Res Function(_Playing) then) =
      __$PlayingCopyWithImpl<$Res>;
  $Res call({AudioEntity audio});
}

/// @nodoc
class __$PlayingCopyWithImpl<$Res> extends _$AudioPlayingCopyWithImpl<$Res>
    implements _$PlayingCopyWith<$Res> {
  __$PlayingCopyWithImpl(_Playing _value, $Res Function(_Playing) _then)
      : super(_value, (v) => _then(v as _Playing));

  @override
  _Playing get _value => super._value as _Playing;

  @override
  $Res call({
    Object audio = freezed,
  }) {
    return _then(_Playing(
      audio == freezed ? _value.audio : audio as AudioEntity,
    ));
  }
}

/// @nodoc
class _$_Playing implements _Playing {
  const _$_Playing(this.audio) : assert(audio != null);

  @override
  final AudioEntity audio;

  @override
  String toString() {
    return 'AudioPlaying.playing(audio: $audio)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Playing &&
            (identical(other.audio, audio) ||
                const DeepCollectionEquality().equals(other.audio, audio)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(audio);

  @override
  _$PlayingCopyWith<_Playing> get copyWith =>
      __$PlayingCopyWithImpl<_Playing>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult none(),
    @required TResult playing(AudioEntity audio),
  }) {
    assert(none != null);
    assert(playing != null);
    return playing(audio);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult none(),
    TResult playing(AudioEntity audio),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (playing != null) {
      return playing(audio);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult none(_None value),
    @required TResult playing(_Playing value),
  }) {
    assert(none != null);
    assert(playing != null);
    return playing(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult none(_None value),
    TResult playing(_Playing value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (playing != null) {
      return playing(this);
    }
    return orElse();
  }
}

abstract class _Playing implements AudioPlaying {
  const factory _Playing(AudioEntity audio) = _$_Playing;

  AudioEntity get audio;
  _$PlayingCopyWith<_Playing> get copyWith;
}
