// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'feed_router_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$FeedRouterTypeTearOff {
  const _$FeedRouterTypeTearOff();

// ignore: unused_element
  _Chat chat(int clientId) {
    return _Chat(
      clientId,
    );
  }

// ignore: unused_element
  _Profile profile(int clientId) {
    return _Profile(
      clientId,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $FeedRouterType = _$FeedRouterTypeTearOff();

/// @nodoc
mixin _$FeedRouterType {
  int get clientId;

  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult chat(int clientId),
    @required TResult profile(int clientId),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult chat(int clientId),
    TResult profile(int clientId),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult chat(_Chat value),
    @required TResult profile(_Profile value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult chat(_Chat value),
    TResult profile(_Profile value),
    @required TResult orElse(),
  });

  @JsonKey(ignore: true)
  $FeedRouterTypeCopyWith<FeedRouterType> get copyWith;
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
    Object clientId = freezed,
  }) {
    return _then(_value.copyWith(
      clientId: clientId == freezed ? _value.clientId : clientId as int,
    ));
  }
}

/// @nodoc
abstract class _$ChatCopyWith<$Res> implements $FeedRouterTypeCopyWith<$Res> {
  factory _$ChatCopyWith(_Chat value, $Res Function(_Chat) then) =
      __$ChatCopyWithImpl<$Res>;
  @override
  $Res call({int clientId});
}

/// @nodoc
class __$ChatCopyWithImpl<$Res> extends _$FeedRouterTypeCopyWithImpl<$Res>
    implements _$ChatCopyWith<$Res> {
  __$ChatCopyWithImpl(_Chat _value, $Res Function(_Chat) _then)
      : super(_value, (v) => _then(v as _Chat));

  @override
  _Chat get _value => super._value as _Chat;

  @override
  $Res call({
    Object clientId = freezed,
  }) {
    return _then(_Chat(
      clientId == freezed ? _value.clientId : clientId as int,
    ));
  }
}

/// @nodoc
class _$_Chat implements _Chat {
  const _$_Chat(this.clientId) : assert(clientId != null);

  @override
  final int clientId;

  @override
  String toString() {
    return 'FeedRouterType.chat(clientId: $clientId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Chat &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality()
                    .equals(other.clientId, clientId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(clientId);

  @JsonKey(ignore: true)
  @override
  _$ChatCopyWith<_Chat> get copyWith =>
      __$ChatCopyWithImpl<_Chat>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult chat(int clientId),
    @required TResult profile(int clientId),
  }) {
    assert(chat != null);
    assert(profile != null);
    return chat(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult chat(int clientId),
    TResult profile(int clientId),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (chat != null) {
      return chat(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult chat(_Chat value),
    @required TResult profile(_Profile value),
  }) {
    assert(chat != null);
    assert(profile != null);
    return chat(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult chat(_Chat value),
    TResult profile(_Profile value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (chat != null) {
      return chat(this);
    }
    return orElse();
  }
}

abstract class _Chat implements FeedRouterType {
  const factory _Chat(int clientId) = _$_Chat;

  @override
  int get clientId;
  @override
  @JsonKey(ignore: true)
  _$ChatCopyWith<_Chat> get copyWith;
}

/// @nodoc
abstract class _$ProfileCopyWith<$Res>
    implements $FeedRouterTypeCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) then) =
      __$ProfileCopyWithImpl<$Res>;
  @override
  $Res call({int clientId});
}

/// @nodoc
class __$ProfileCopyWithImpl<$Res> extends _$FeedRouterTypeCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(_Profile _value, $Res Function(_Profile) _then)
      : super(_value, (v) => _then(v as _Profile));

  @override
  _Profile get _value => super._value as _Profile;

  @override
  $Res call({
    Object clientId = freezed,
  }) {
    return _then(_Profile(
      clientId == freezed ? _value.clientId : clientId as int,
    ));
  }
}

/// @nodoc
class _$_Profile implements _Profile {
  const _$_Profile(this.clientId) : assert(clientId != null);

  @override
  final int clientId;

  @override
  String toString() {
    return 'FeedRouterType.profile(clientId: $clientId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Profile &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality()
                    .equals(other.clientId, clientId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(clientId);

  @JsonKey(ignore: true)
  @override
  _$ProfileCopyWith<_Profile> get copyWith =>
      __$ProfileCopyWithImpl<_Profile>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult chat(int clientId),
    @required TResult profile(int clientId),
  }) {
    assert(chat != null);
    assert(profile != null);
    return profile(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult chat(int clientId),
    TResult profile(int clientId),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (profile != null) {
      return profile(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult chat(_Chat value),
    @required TResult profile(_Profile value),
  }) {
    assert(chat != null);
    assert(profile != null);
    return profile(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult chat(_Chat value),
    TResult profile(_Profile value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (profile != null) {
      return profile(this);
    }
    return orElse();
  }
}

abstract class _Profile implements FeedRouterType {
  const factory _Profile(int clientId) = _$_Profile;

  @override
  int get clientId;
  @override
  @JsonKey(ignore: true)
  _$ProfileCopyWith<_Profile> get copyWith;
}
