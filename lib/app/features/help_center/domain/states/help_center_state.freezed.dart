// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'help_center_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HelpCenterState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(GuardianAlertMessageAction action)
        guardianTriggered,
    required TResult Function(String callingNumber) callingPolice,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(GuardianAlertMessageAction action)? guardianTriggered,
    TResult? Function(String callingNumber)? callingPolice,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(GuardianAlertMessageAction action)? guardianTriggered,
    TResult Function(String callingNumber)? callingPolice,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GuardianTriggered value) guardianTriggered,
    required TResult Function(_CallingPolice value) callingPolice,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GuardianTriggered value)? guardianTriggered,
    TResult? Function(_CallingPolice value)? callingPolice,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GuardianTriggered value)? guardianTriggered,
    TResult Function(_CallingPolice value)? callingPolice,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelpCenterStateCopyWith<$Res> {
  factory $HelpCenterStateCopyWith(
          HelpCenterState value, $Res Function(HelpCenterState) then) =
      _$HelpCenterStateCopyWithImpl<$Res, HelpCenterState>;
}

/// @nodoc
class _$HelpCenterStateCopyWithImpl<$Res, $Val extends HelpCenterState>
    implements $HelpCenterStateCopyWith<$Res> {
  _$HelpCenterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$HelpCenterStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'HelpCenterState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(GuardianAlertMessageAction action)
        guardianTriggered,
    required TResult Function(String callingNumber) callingPolice,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(GuardianAlertMessageAction action)? guardianTriggered,
    TResult? Function(String callingNumber)? callingPolice,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(GuardianAlertMessageAction action)? guardianTriggered,
    TResult Function(String callingNumber)? callingPolice,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GuardianTriggered value) guardianTriggered,
    required TResult Function(_CallingPolice value) callingPolice,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GuardianTriggered value)? guardianTriggered,
    TResult? Function(_CallingPolice value)? callingPolice,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GuardianTriggered value)? guardianTriggered,
    TResult Function(_CallingPolice value)? callingPolice,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements HelpCenterState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$GuardianTriggeredImplCopyWith<$Res> {
  factory _$$GuardianTriggeredImplCopyWith(_$GuardianTriggeredImpl value,
          $Res Function(_$GuardianTriggeredImpl) then) =
      __$$GuardianTriggeredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GuardianAlertMessageAction action});
}

/// @nodoc
class __$$GuardianTriggeredImplCopyWithImpl<$Res>
    extends _$HelpCenterStateCopyWithImpl<$Res, _$GuardianTriggeredImpl>
    implements _$$GuardianTriggeredImplCopyWith<$Res> {
  __$$GuardianTriggeredImplCopyWithImpl(_$GuardianTriggeredImpl _value,
      $Res Function(_$GuardianTriggeredImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
  }) {
    return _then(_$GuardianTriggeredImpl(
      null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as GuardianAlertMessageAction,
    ));
  }
}

/// @nodoc

class _$GuardianTriggeredImpl implements _GuardianTriggered {
  const _$GuardianTriggeredImpl(this.action);

  @override
  final GuardianAlertMessageAction action;

  @override
  String toString() {
    return 'HelpCenterState.guardianTriggered(action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuardianTriggeredImpl &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode => Object.hash(runtimeType, action);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GuardianTriggeredImplCopyWith<_$GuardianTriggeredImpl> get copyWith =>
      __$$GuardianTriggeredImplCopyWithImpl<_$GuardianTriggeredImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(GuardianAlertMessageAction action)
        guardianTriggered,
    required TResult Function(String callingNumber) callingPolice,
  }) {
    return guardianTriggered(action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(GuardianAlertMessageAction action)? guardianTriggered,
    TResult? Function(String callingNumber)? callingPolice,
  }) {
    return guardianTriggered?.call(action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(GuardianAlertMessageAction action)? guardianTriggered,
    TResult Function(String callingNumber)? callingPolice,
    required TResult orElse(),
  }) {
    if (guardianTriggered != null) {
      return guardianTriggered(action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GuardianTriggered value) guardianTriggered,
    required TResult Function(_CallingPolice value) callingPolice,
  }) {
    return guardianTriggered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GuardianTriggered value)? guardianTriggered,
    TResult? Function(_CallingPolice value)? callingPolice,
  }) {
    return guardianTriggered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GuardianTriggered value)? guardianTriggered,
    TResult Function(_CallingPolice value)? callingPolice,
    required TResult orElse(),
  }) {
    if (guardianTriggered != null) {
      return guardianTriggered(this);
    }
    return orElse();
  }
}

abstract class _GuardianTriggered implements HelpCenterState {
  const factory _GuardianTriggered(final GuardianAlertMessageAction action) =
      _$GuardianTriggeredImpl;

  GuardianAlertMessageAction get action;
  @JsonKey(ignore: true)
  _$$GuardianTriggeredImplCopyWith<_$GuardianTriggeredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CallingPoliceImplCopyWith<$Res> {
  factory _$$CallingPoliceImplCopyWith(
          _$CallingPoliceImpl value, $Res Function(_$CallingPoliceImpl) then) =
      __$$CallingPoliceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String callingNumber});
}

/// @nodoc
class __$$CallingPoliceImplCopyWithImpl<$Res>
    extends _$HelpCenterStateCopyWithImpl<$Res, _$CallingPoliceImpl>
    implements _$$CallingPoliceImplCopyWith<$Res> {
  __$$CallingPoliceImplCopyWithImpl(
      _$CallingPoliceImpl _value, $Res Function(_$CallingPoliceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callingNumber = null,
  }) {
    return _then(_$CallingPoliceImpl(
      null == callingNumber
          ? _value.callingNumber
          : callingNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CallingPoliceImpl implements _CallingPolice {
  const _$CallingPoliceImpl(this.callingNumber);

  @override
  final String callingNumber;

  @override
  String toString() {
    return 'HelpCenterState.callingPolice(callingNumber: $callingNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallingPoliceImpl &&
            (identical(other.callingNumber, callingNumber) ||
                other.callingNumber == callingNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callingNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CallingPoliceImplCopyWith<_$CallingPoliceImpl> get copyWith =>
      __$$CallingPoliceImplCopyWithImpl<_$CallingPoliceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(GuardianAlertMessageAction action)
        guardianTriggered,
    required TResult Function(String callingNumber) callingPolice,
  }) {
    return callingPolice(callingNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(GuardianAlertMessageAction action)? guardianTriggered,
    TResult? Function(String callingNumber)? callingPolice,
  }) {
    return callingPolice?.call(callingNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(GuardianAlertMessageAction action)? guardianTriggered,
    TResult Function(String callingNumber)? callingPolice,
    required TResult orElse(),
  }) {
    if (callingPolice != null) {
      return callingPolice(callingNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GuardianTriggered value) guardianTriggered,
    required TResult Function(_CallingPolice value) callingPolice,
  }) {
    return callingPolice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GuardianTriggered value)? guardianTriggered,
    TResult? Function(_CallingPolice value)? callingPolice,
  }) {
    return callingPolice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GuardianTriggered value)? guardianTriggered,
    TResult Function(_CallingPolice value)? callingPolice,
    required TResult orElse(),
  }) {
    if (callingPolice != null) {
      return callingPolice(this);
    }
    return orElse();
  }
}

abstract class _CallingPolice implements HelpCenterState {
  const factory _CallingPolice(final String callingNumber) =
      _$CallingPoliceImpl;

  String get callingNumber;
  @JsonKey(ignore: true)
  _$$CallingPoliceImplCopyWith<_$CallingPoliceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
