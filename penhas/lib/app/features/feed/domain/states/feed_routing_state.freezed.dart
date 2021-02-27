// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'feed_routing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$FeedRoutingStateTearOff {
  const _$FeedRoutingStateTearOff();

// ignore: unused_element
  _Initial initial(String title) {
    return _Initial(
      title,
    );
  }

// ignore: unused_element
  _ErrorDetails error(String title, String message) {
    return _ErrorDetails(
      title,
      message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $FeedRoutingState = _$FeedRoutingStateTearOff();

/// @nodoc
mixin _$FeedRoutingState {
  String get title;

  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(String title),
    @required TResult error(String title, String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(String title),
    TResult error(String title, String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult error(_ErrorDetails value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult error(_ErrorDetails value),
    @required TResult orElse(),
  });

  @JsonKey(ignore: true)
  $FeedRoutingStateCopyWith<FeedRoutingState> get copyWith;
}

/// @nodoc
abstract class $FeedRoutingStateCopyWith<$Res> {
  factory $FeedRoutingStateCopyWith(
          FeedRoutingState value, $Res Function(FeedRoutingState) then) =
      _$FeedRoutingStateCopyWithImpl<$Res>;
  $Res call({String title});
}

/// @nodoc
class _$FeedRoutingStateCopyWithImpl<$Res>
    implements $FeedRoutingStateCopyWith<$Res> {
  _$FeedRoutingStateCopyWithImpl(this._value, this._then);

  final FeedRoutingState _value;
  // ignore: unused_field
  final $Res Function(FeedRoutingState) _then;

  @override
  $Res call({
    Object title = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res>
    implements $FeedRoutingStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call({String title});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$FeedRoutingStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object title = freezed,
  }) {
    return _then(_Initial(
      title == freezed ? _value.title : title as String,
    ));
  }
}

/// @nodoc
class _$_Initial implements _Initial {
  const _$_Initial(this.title) : assert(title != null);

  @override
  final String title;

  @override
  String toString() {
    return 'FeedRoutingState.initial(title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Initial &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(title);

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(String title),
    @required TResult error(String title, String message),
  }) {
    assert(initial != null);
    assert(error != null);
    return initial(title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(String title),
    TResult error(String title, String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult error(_ErrorDetails value),
  }) {
    assert(initial != null);
    assert(error != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult error(_ErrorDetails value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements FeedRoutingState {
  const factory _Initial(String title) = _$_Initial;

  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith;
}

/// @nodoc
abstract class _$ErrorDetailsCopyWith<$Res>
    implements $FeedRoutingStateCopyWith<$Res> {
  factory _$ErrorDetailsCopyWith(
          _ErrorDetails value, $Res Function(_ErrorDetails) then) =
      __$ErrorDetailsCopyWithImpl<$Res>;
  @override
  $Res call({String title, String message});
}

/// @nodoc
class __$ErrorDetailsCopyWithImpl<$Res>
    extends _$FeedRoutingStateCopyWithImpl<$Res>
    implements _$ErrorDetailsCopyWith<$Res> {
  __$ErrorDetailsCopyWithImpl(
      _ErrorDetails _value, $Res Function(_ErrorDetails) _then)
      : super(_value, (v) => _then(v as _ErrorDetails));

  @override
  _ErrorDetails get _value => super._value as _ErrorDetails;

  @override
  $Res call({
    Object title = freezed,
    Object message = freezed,
  }) {
    return _then(_ErrorDetails(
      title == freezed ? _value.title : title as String,
      message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$_ErrorDetails implements _ErrorDetails {
  const _$_ErrorDetails(this.title, this.message)
      : assert(title != null),
        assert(message != null);

  @override
  final String title;
  @override
  final String message;

  @override
  String toString() {
    return 'FeedRoutingState.error(title: $title, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ErrorDetails &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  _$ErrorDetailsCopyWith<_ErrorDetails> get copyWith =>
      __$ErrorDetailsCopyWithImpl<_ErrorDetails>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(String title),
    @required TResult error(String title, String message),
  }) {
    assert(initial != null);
    assert(error != null);
    return error(title, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(String title),
    TResult error(String title, String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(title, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult error(_ErrorDetails value),
  }) {
    assert(initial != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult error(_ErrorDetails value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorDetails implements FeedRoutingState {
  const factory _ErrorDetails(String title, String message) = _$_ErrorDetails;

  @override
  String get title;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$ErrorDetailsCopyWith<_ErrorDetails> get copyWith;
}
