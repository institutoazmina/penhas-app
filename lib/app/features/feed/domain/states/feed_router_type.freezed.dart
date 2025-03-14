// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'feed_router_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FeedRouterType {
  int get clientId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int clientId) chat,
    required TResult Function(int clientId) profile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int clientId)? chat,
    TResult Function(int clientId)? profile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int clientId)? chat,
    TResult Function(int clientId)? profile,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chat value) chat,
    required TResult Function(_Profile value) profile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Chat value)? chat,
    TResult Function(_Profile value)? profile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chat value)? chat,
    TResult Function(_Profile value)? profile,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FeedRouterTypeCopyWith<FeedRouterType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedRouterTypeCopyWith<$Res> {
  factory $FeedRouterTypeCopyWith(
          FeedRouterType value, $Res Function(FeedRouterType) then) =
      _$FeedRouterTypeCopyWithImpl<$Res>;
  $Res call({int clientId});
}

/// @nodoc
class _$FeedRouterTypeCopyWithImpl<$Res>
    implements $FeedRouterTypeCopyWith<$Res> {
  _$FeedRouterTypeCopyWithImpl(this._value, this._then);

  final FeedRouterType _value;
  // ignore: unused_field
  final $Res Function(FeedRouterType) _then;

  @override
  $Res call({
    Object? clientId = freezed,
  }) {
    return _then(_value.copyWith(
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_ChatCopyWith<$Res> implements $FeedRouterTypeCopyWith<$Res> {
  factory _$$_ChatCopyWith(_$_Chat value, $Res Function(_$_Chat) then) =
      __$$_ChatCopyWithImpl<$Res>;
  @override
  $Res call({int clientId});
}

/// @nodoc
class __$$_ChatCopyWithImpl<$Res> extends _$FeedRouterTypeCopyWithImpl<$Res>
    implements _$$_ChatCopyWith<$Res> {
  __$$_ChatCopyWithImpl(_$_Chat _value, $Res Function(_$_Chat) _then)
      : super(_value, (v) => _then(v as _$_Chat));

  @override
  _$_Chat get _value => super._value as _$_Chat;

  @override
  $Res call({
    Object? clientId = freezed,
  }) {
    return _then(_$_Chat(
      clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Chat implements _Chat {
  const _$_Chat(this.clientId);

  @override
  final int clientId;

  @override
  String toString() {
    return 'FeedRouterType.chat(clientId: $clientId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Chat &&
            const DeepCollectionEquality().equals(other.clientId, clientId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(clientId));

  @JsonKey(ignore: true)
  @override
  _$$_ChatCopyWith<_$_Chat> get copyWith =>
      __$$_ChatCopyWithImpl<_$_Chat>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int clientId) chat,
    required TResult Function(int clientId) profile,
  }) {
    return chat(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int clientId)? chat,
    TResult Function(int clientId)? profile,
  }) {
    return chat?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int clientId)? chat,
    TResult Function(int clientId)? profile,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chat value) chat,
    required TResult Function(_Profile value) profile,
  }) {
    return chat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Chat value)? chat,
    TResult Function(_Profile value)? profile,
  }) {
    return chat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chat value)? chat,
    TResult Function(_Profile value)? profile,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(this);
    }
    return orElse();
  }
}

abstract class _Chat implements FeedRouterType {
  const factory _Chat(final int clientId) = _$_Chat;

  @override
  int get clientId;
  @override
  @JsonKey(ignore: true)
  _$$_ChatCopyWith<_$_Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ProfileCopyWith<$Res>
    implements $FeedRouterTypeCopyWith<$Res> {
  factory _$$_ProfileCopyWith(
          _$_Profile value, $Res Function(_$_Profile) then) =
      __$$_ProfileCopyWithImpl<$Res>;
  @override
  $Res call({int clientId});
}

/// @nodoc
class __$$_ProfileCopyWithImpl<$Res> extends _$FeedRouterTypeCopyWithImpl<$Res>
    implements _$$_ProfileCopyWith<$Res> {
  __$$_ProfileCopyWithImpl(_$_Profile _value, $Res Function(_$_Profile) _then)
      : super(_value, (v) => _then(v as _$_Profile));

  @override
  _$_Profile get _value => super._value as _$_Profile;

  @override
  $Res call({
    Object? clientId = freezed,
  }) {
    return _then(_$_Profile(
      clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Profile implements _Profile {
  const _$_Profile(this.clientId);

  @override
  final int clientId;

  @override
  String toString() {
    return 'FeedRouterType.profile(clientId: $clientId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Profile &&
            const DeepCollectionEquality().equals(other.clientId, clientId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(clientId));

  @JsonKey(ignore: true)
  @override
  _$$_ProfileCopyWith<_$_Profile> get copyWith =>
      __$$_ProfileCopyWithImpl<_$_Profile>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int clientId) chat,
    required TResult Function(int clientId) profile,
  }) {
    return profile(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int clientId)? chat,
    TResult Function(int clientId)? profile,
  }) {
    return profile?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int clientId)? chat,
    TResult Function(int clientId)? profile,
    required TResult orElse(),
  }) {
    if (profile != null) {
      return profile(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Chat value) chat,
    required TResult Function(_Profile value) profile,
  }) {
    return profile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Chat value)? chat,
    TResult Function(_Profile value)? profile,
  }) {
    return profile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Chat value)? chat,
    TResult Function(_Profile value)? profile,
    required TResult orElse(),
  }) {
    if (profile != null) {
      return profile(this);
    }
    return orElse();
  }
}

abstract class _Profile implements FeedRouterType {
  const factory _Profile(final int clientId) = _$_Profile;

  @override
  int get clientId;
  @override
  @JsonKey(ignore: true)
  _$$_ProfileCopyWith<_$_Profile> get copyWith =>
      throw _privateConstructorUsedError;
}
