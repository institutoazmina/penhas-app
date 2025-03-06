// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'filter_action_observer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FilterActionObserver {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() reset,
    required TResult Function(List<FilterTagEntity> tags) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? reset,
    TResult Function(List<FilterTagEntity> tags)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? reset,
    TResult Function(List<FilterTagEntity> tags)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Reset value) reset,
    required TResult Function(_Updated value) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Reset value)? reset,
    TResult Function(_Updated value)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Reset value)? reset,
    TResult Function(_Updated value)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterActionObserverCopyWith<$Res> {
  factory $FilterActionObserverCopyWith(FilterActionObserver value,
          $Res Function(FilterActionObserver) then) =
      _$FilterActionObserverCopyWithImpl<$Res>;
}

/// @nodoc
class _$FilterActionObserverCopyWithImpl<$Res>
    implements $FilterActionObserverCopyWith<$Res> {
  _$FilterActionObserverCopyWithImpl(this._value, this._then);

  final FilterActionObserver _value;
  // ignore: unused_field
  final $Res Function(FilterActionObserver) _then;
}

/// @nodoc
abstract class _$$_ResetCopyWith<$Res> {
  factory _$$_ResetCopyWith(_$_Reset value, $Res Function(_$_Reset) then) =
      __$$_ResetCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ResetCopyWithImpl<$Res>
    extends _$FilterActionObserverCopyWithImpl<$Res>
    implements _$$_ResetCopyWith<$Res> {
  __$$_ResetCopyWithImpl(_$_Reset _value, $Res Function(_$_Reset) _then)
      : super(_value, (v) => _then(v as _$_Reset));

  @override
  _$_Reset get _value => super._value as _$_Reset;
}

/// @nodoc

class _$_Reset implements _Reset {
  const _$_Reset();

  @override
  String toString() {
    return 'FilterActionObserver.reset()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Reset);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() reset,
    required TResult Function(List<FilterTagEntity> tags) updated,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? reset,
    TResult Function(List<FilterTagEntity> tags)? updated,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? reset,
    TResult Function(List<FilterTagEntity> tags)? updated,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Reset value) reset,
    required TResult Function(_Updated value) updated,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Reset value)? reset,
    TResult Function(_Updated value)? updated,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Reset value)? reset,
    TResult Function(_Updated value)? updated,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class _Reset implements FilterActionObserver {
  const factory _Reset() = _$_Reset;
}

/// @nodoc
abstract class _$$_UpdatedCopyWith<$Res> {
  factory _$$_UpdatedCopyWith(
          _$_Updated value, $Res Function(_$_Updated) then) =
      __$$_UpdatedCopyWithImpl<$Res>;
  $Res call({List<FilterTagEntity> tags});
}

/// @nodoc
class __$$_UpdatedCopyWithImpl<$Res>
    extends _$FilterActionObserverCopyWithImpl<$Res>
    implements _$$_UpdatedCopyWith<$Res> {
  __$$_UpdatedCopyWithImpl(_$_Updated _value, $Res Function(_$_Updated) _then)
      : super(_value, (v) => _then(v as _$_Updated));

  @override
  _$_Updated get _value => super._value as _$_Updated;

  @override
  $Res call({
    Object? tags = freezed,
  }) {
    return _then(_$_Updated(
      tags == freezed
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<FilterTagEntity>,
    ));
  }
}

/// @nodoc

class _$_Updated implements _Updated {
  const _$_Updated(final List<FilterTagEntity> tags) : _tags = tags;

  final List<FilterTagEntity> _tags;
  @override
  List<FilterTagEntity> get tags {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'FilterActionObserver.updated(tags: $tags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Updated &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  _$$_UpdatedCopyWith<_$_Updated> get copyWith =>
      __$$_UpdatedCopyWithImpl<_$_Updated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() reset,
    required TResult Function(List<FilterTagEntity> tags) updated,
  }) {
    return updated(tags);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? reset,
    TResult Function(List<FilterTagEntity> tags)? updated,
  }) {
    return updated?.call(tags);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? reset,
    TResult Function(List<FilterTagEntity> tags)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(tags);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Reset value) reset,
    required TResult Function(_Updated value) updated,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Reset value)? reset,
    TResult Function(_Updated value)? updated,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Reset value)? reset,
    TResult Function(_Updated value)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class _Updated implements FilterActionObserver {
  const factory _Updated(final List<FilterTagEntity> tags) = _$_Updated;

  List<FilterTagEntity> get tags;
  @JsonKey(ignore: true)
  _$$_UpdatedCopyWith<_$_Updated> get copyWith =>
      throw _privateConstructorUsedError;
}
