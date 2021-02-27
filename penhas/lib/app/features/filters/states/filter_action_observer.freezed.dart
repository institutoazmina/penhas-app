// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'filter_action_observer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$FilterActionObserverTearOff {
  const _$FilterActionObserverTearOff();

// ignore: unused_element
  _Reset reset() {
    return const _Reset();
  }

// ignore: unused_element
  _Updated updated(List<FilterTagEntity> tags) {
    return _Updated(
      tags,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $FilterActionObserver = _$FilterActionObserverTearOff();

/// @nodoc
mixin _$FilterActionObserver {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult reset(),
    @required TResult updated(List<FilterTagEntity> tags),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult reset(),
    TResult updated(List<FilterTagEntity> tags),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult reset(_Reset value),
    @required TResult updated(_Updated value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult reset(_Reset value),
    TResult updated(_Updated value),
    @required TResult orElse(),
  });
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
abstract class _$ResetCopyWith<$Res> {
  factory _$ResetCopyWith(_Reset value, $Res Function(_Reset) then) =
      __$ResetCopyWithImpl<$Res>;
}

/// @nodoc
class __$ResetCopyWithImpl<$Res>
    extends _$FilterActionObserverCopyWithImpl<$Res>
    implements _$ResetCopyWith<$Res> {
  __$ResetCopyWithImpl(_Reset _value, $Res Function(_Reset) _then)
      : super(_value, (v) => _then(v as _Reset));

  @override
  _Reset get _value => super._value as _Reset;
}

/// @nodoc
class _$_Reset with DiagnosticableTreeMixin implements _Reset {
  const _$_Reset();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FilterActionObserver.reset()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'FilterActionObserver.reset'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Reset);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult reset(),
    @required TResult updated(List<FilterTagEntity> tags),
  }) {
    assert(reset != null);
    assert(updated != null);
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult reset(),
    TResult updated(List<FilterTagEntity> tags),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult reset(_Reset value),
    @required TResult updated(_Updated value),
  }) {
    assert(reset != null);
    assert(updated != null);
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult reset(_Reset value),
    TResult updated(_Updated value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
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
abstract class _$UpdatedCopyWith<$Res> {
  factory _$UpdatedCopyWith(_Updated value, $Res Function(_Updated) then) =
      __$UpdatedCopyWithImpl<$Res>;
  $Res call({List<FilterTagEntity> tags});
}

/// @nodoc
class __$UpdatedCopyWithImpl<$Res>
    extends _$FilterActionObserverCopyWithImpl<$Res>
    implements _$UpdatedCopyWith<$Res> {
  __$UpdatedCopyWithImpl(_Updated _value, $Res Function(_Updated) _then)
      : super(_value, (v) => _then(v as _Updated));

  @override
  _Updated get _value => super._value as _Updated;

  @override
  $Res call({
    Object tags = freezed,
  }) {
    return _then(_Updated(
      tags == freezed ? _value.tags : tags as List<FilterTagEntity>,
    ));
  }
}

/// @nodoc
class _$_Updated with DiagnosticableTreeMixin implements _Updated {
  const _$_Updated(this.tags) : assert(tags != null);

  @override
  final List<FilterTagEntity> tags;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FilterActionObserver.updated(tags: $tags)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FilterActionObserver.updated'))
      ..add(DiagnosticsProperty('tags', tags));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Updated &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(tags);

  @JsonKey(ignore: true)
  @override
  _$UpdatedCopyWith<_Updated> get copyWith =>
      __$UpdatedCopyWithImpl<_Updated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult reset(),
    @required TResult updated(List<FilterTagEntity> tags),
  }) {
    assert(reset != null);
    assert(updated != null);
    return updated(tags);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult reset(),
    TResult updated(List<FilterTagEntity> tags),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (updated != null) {
      return updated(tags);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult reset(_Reset value),
    @required TResult updated(_Updated value),
  }) {
    assert(reset != null);
    assert(updated != null);
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult reset(_Reset value),
    TResult updated(_Updated value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class _Updated implements FilterActionObserver {
  const factory _Updated(List<FilterTagEntity> tags) = _$_Updated;

  List<FilterTagEntity> get tags;
  @JsonKey(ignore: true)
  _$UpdatedCopyWith<_Updated> get copyWith;
}
