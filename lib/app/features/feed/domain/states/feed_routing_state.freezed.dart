// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'feed_routing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FeedRoutingState {
  String get title => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) initial,
    required TResult Function(String title, String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String title)? initial,
    TResult Function(String title, String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? initial,
    TResult Function(String title, String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_ErrorDetails value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_ErrorDetails value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_ErrorDetails value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FeedRoutingStateCopyWith<FeedRoutingState> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $FeedRoutingStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  $Res call({String title});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$FeedRoutingStateCopyWithImpl<$Res>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, (v) => _then(v as _$_Initial));

  @override
  _$_Initial get _value => super._value as _$_Initial;

  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_$_Initial(
      title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(this.title);

  @override
  final String title;

  @override
  String toString() {
    return 'FeedRoutingState.initial(title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            const DeepCollectionEquality().equals(other.title, title));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(title));

  @JsonKey(ignore: true)
  @override
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) initial,
    required TResult Function(String title, String message) error,
  }) {
    return initial(title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String title)? initial,
    TResult Function(String title, String message)? error,
  }) {
    return initial?.call(title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? initial,
    TResult Function(String title, String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_ErrorDetails value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_ErrorDetails value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_ErrorDetails value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements FeedRoutingState {
  const factory _Initial(final String title) = _$_Initial;

  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorDetailsCopyWith<$Res>
    implements $FeedRoutingStateCopyWith<$Res> {
  factory _$$_ErrorDetailsCopyWith(
          _$_ErrorDetails value, $Res Function(_$_ErrorDetails) then) =
      __$$_ErrorDetailsCopyWithImpl<$Res>;
  @override
  $Res call({String title, String message});
}

/// @nodoc
class __$$_ErrorDetailsCopyWithImpl<$Res>
    extends _$FeedRoutingStateCopyWithImpl<$Res>
    implements _$$_ErrorDetailsCopyWith<$Res> {
  __$$_ErrorDetailsCopyWithImpl(
      _$_ErrorDetails _value, $Res Function(_$_ErrorDetails) _then)
      : super(_value, (v) => _then(v as _$_ErrorDetails));

  @override
  _$_ErrorDetails get _value => super._value as _$_ErrorDetails;

  @override
  $Res call({
    Object? title = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_ErrorDetails(
      title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ErrorDetails implements _ErrorDetails {
  const _$_ErrorDetails(this.title, this.message);

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
        (other.runtimeType == runtimeType &&
            other is _$_ErrorDetails &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_ErrorDetailsCopyWith<_$_ErrorDetails> get copyWith =>
      __$$_ErrorDetailsCopyWithImpl<_$_ErrorDetails>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) initial,
    required TResult Function(String title, String message) error,
  }) {
    return error(title, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String title)? initial,
    TResult Function(String title, String message)? error,
  }) {
    return error?.call(title, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? initial,
    TResult Function(String title, String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(title, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_ErrorDetails value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_ErrorDetails value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_ErrorDetails value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorDetails implements FeedRoutingState {
  const factory _ErrorDetails(final String title, final String message) =
      _$_ErrorDetails;

  @override
  String get title;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_ErrorDetailsCopyWith<_$_ErrorDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
