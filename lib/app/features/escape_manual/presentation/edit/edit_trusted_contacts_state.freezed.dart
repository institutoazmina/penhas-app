// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_trusted_contacts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditTrustedContactsState {
  List<ContactEntity> get contacts => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<ContactEntity> contacts) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ContactEntity> contacts)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ContactEntity> contacts)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadedState value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadedState value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadedState value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditTrustedContactsStateCopyWith<EditTrustedContactsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditTrustedContactsStateCopyWith<$Res> {
  factory $EditTrustedContactsStateCopyWith(EditTrustedContactsState value,
          $Res Function(EditTrustedContactsState) then) =
      _$EditTrustedContactsStateCopyWithImpl<$Res, EditTrustedContactsState>;
  @useResult
  $Res call({List<ContactEntity> contacts});
}

/// @nodoc
class _$EditTrustedContactsStateCopyWithImpl<$Res,
        $Val extends EditTrustedContactsState>
    implements $EditTrustedContactsStateCopyWith<$Res> {
  _$EditTrustedContactsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contacts = null,
  }) {
    return _then(_value.copyWith(
      contacts: null == contacts
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<ContactEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadedStateImplCopyWith<$Res>
    implements $EditTrustedContactsStateCopyWith<$Res> {
  factory _$$LoadedStateImplCopyWith(
          _$LoadedStateImpl value, $Res Function(_$LoadedStateImpl) then) =
      __$$LoadedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ContactEntity> contacts});
}

/// @nodoc
class __$$LoadedStateImplCopyWithImpl<$Res>
    extends _$EditTrustedContactsStateCopyWithImpl<$Res, _$LoadedStateImpl>
    implements _$$LoadedStateImplCopyWith<$Res> {
  __$$LoadedStateImplCopyWithImpl(
      _$LoadedStateImpl _value, $Res Function(_$LoadedStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contacts = null,
  }) {
    return _then(_$LoadedStateImpl(
      null == contacts
          ? _value._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<ContactEntity>,
    ));
  }
}

/// @nodoc

class _$LoadedStateImpl implements _LoadedState {
  const _$LoadedStateImpl(final List<ContactEntity> contacts)
      : _contacts = contacts;

  final List<ContactEntity> _contacts;
  @override
  List<ContactEntity> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  @override
  String toString() {
    return 'EditTrustedContactsState.loaded(contacts: $contacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedStateImpl &&
            const DeepCollectionEquality().equals(other._contacts, _contacts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_contacts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedStateImplCopyWith<_$LoadedStateImpl> get copyWith =>
      __$$LoadedStateImplCopyWithImpl<_$LoadedStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<ContactEntity> contacts) loaded,
  }) {
    return loaded(contacts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ContactEntity> contacts)? loaded,
  }) {
    return loaded?.call(contacts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ContactEntity> contacts)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(contacts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadedState value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadedState value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadedState value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _LoadedState implements EditTrustedContactsState {
  const factory _LoadedState(final List<ContactEntity> contacts) =
      _$LoadedStateImpl;

  @override
  List<ContactEntity> get contacts;
  @override
  @JsonKey(ignore: true)
  _$$LoadedStateImplCopyWith<_$LoadedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EditTrustedContactsReaction {
  ContactEntity get contact => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ContactEntity contact) requestContactInfo,
    required TResult Function(ContactEntity contact) askForDeleteConfirmation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ContactEntity contact)? requestContactInfo,
    TResult? Function(ContactEntity contact)? askForDeleteConfirmation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ContactEntity contact)? requestContactInfo,
    TResult Function(ContactEntity contact)? askForDeleteConfirmation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestContactInfo value) requestContactInfo,
    required TResult Function(_AskForDeleteConfirmation value)
        askForDeleteConfirmation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestContactInfo value)? requestContactInfo,
    TResult? Function(_AskForDeleteConfirmation value)?
        askForDeleteConfirmation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestContactInfo value)? requestContactInfo,
    TResult Function(_AskForDeleteConfirmation value)? askForDeleteConfirmation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditTrustedContactsReactionCopyWith<EditTrustedContactsReaction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditTrustedContactsReactionCopyWith<$Res> {
  factory $EditTrustedContactsReactionCopyWith(
          EditTrustedContactsReaction value,
          $Res Function(EditTrustedContactsReaction) then) =
      _$EditTrustedContactsReactionCopyWithImpl<$Res,
          EditTrustedContactsReaction>;
  @useResult
  $Res call({ContactEntity contact});
}

/// @nodoc
class _$EditTrustedContactsReactionCopyWithImpl<$Res,
        $Val extends EditTrustedContactsReaction>
    implements $EditTrustedContactsReactionCopyWith<$Res> {
  _$EditTrustedContactsReactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = null,
  }) {
    return _then(_value.copyWith(
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactEntity,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestContactInfoImplCopyWith<$Res>
    implements $EditTrustedContactsReactionCopyWith<$Res> {
  factory _$$RequestContactInfoImplCopyWith(_$RequestContactInfoImpl value,
          $Res Function(_$RequestContactInfoImpl) then) =
      __$$RequestContactInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ContactEntity contact});
}

/// @nodoc
class __$$RequestContactInfoImplCopyWithImpl<$Res>
    extends _$EditTrustedContactsReactionCopyWithImpl<$Res,
        _$RequestContactInfoImpl>
    implements _$$RequestContactInfoImplCopyWith<$Res> {
  __$$RequestContactInfoImplCopyWithImpl(_$RequestContactInfoImpl _value,
      $Res Function(_$RequestContactInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = null,
  }) {
    return _then(_$RequestContactInfoImpl(
      null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactEntity,
    ));
  }
}

/// @nodoc

class _$RequestContactInfoImpl implements _RequestContactInfo {
  const _$RequestContactInfoImpl(this.contact);

  @override
  final ContactEntity contact;

  @override
  String toString() {
    return 'EditTrustedContactsReaction.requestContactInfo(contact: $contact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestContactInfoImpl &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestContactInfoImplCopyWith<_$RequestContactInfoImpl> get copyWith =>
      __$$RequestContactInfoImplCopyWithImpl<_$RequestContactInfoImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ContactEntity contact) requestContactInfo,
    required TResult Function(ContactEntity contact) askForDeleteConfirmation,
  }) {
    return requestContactInfo(contact);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ContactEntity contact)? requestContactInfo,
    TResult? Function(ContactEntity contact)? askForDeleteConfirmation,
  }) {
    return requestContactInfo?.call(contact);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ContactEntity contact)? requestContactInfo,
    TResult Function(ContactEntity contact)? askForDeleteConfirmation,
    required TResult orElse(),
  }) {
    if (requestContactInfo != null) {
      return requestContactInfo(contact);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestContactInfo value) requestContactInfo,
    required TResult Function(_AskForDeleteConfirmation value)
        askForDeleteConfirmation,
  }) {
    return requestContactInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestContactInfo value)? requestContactInfo,
    TResult? Function(_AskForDeleteConfirmation value)?
        askForDeleteConfirmation,
  }) {
    return requestContactInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestContactInfo value)? requestContactInfo,
    TResult Function(_AskForDeleteConfirmation value)? askForDeleteConfirmation,
    required TResult orElse(),
  }) {
    if (requestContactInfo != null) {
      return requestContactInfo(this);
    }
    return orElse();
  }
}

abstract class _RequestContactInfo implements EditTrustedContactsReaction {
  const factory _RequestContactInfo(final ContactEntity contact) =
      _$RequestContactInfoImpl;

  @override
  ContactEntity get contact;
  @override
  @JsonKey(ignore: true)
  _$$RequestContactInfoImplCopyWith<_$RequestContactInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AskForDeleteConfirmationImplCopyWith<$Res>
    implements $EditTrustedContactsReactionCopyWith<$Res> {
  factory _$$AskForDeleteConfirmationImplCopyWith(
          _$AskForDeleteConfirmationImpl value,
          $Res Function(_$AskForDeleteConfirmationImpl) then) =
      __$$AskForDeleteConfirmationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ContactEntity contact});
}

/// @nodoc
class __$$AskForDeleteConfirmationImplCopyWithImpl<$Res>
    extends _$EditTrustedContactsReactionCopyWithImpl<$Res,
        _$AskForDeleteConfirmationImpl>
    implements _$$AskForDeleteConfirmationImplCopyWith<$Res> {
  __$$AskForDeleteConfirmationImplCopyWithImpl(
      _$AskForDeleteConfirmationImpl _value,
      $Res Function(_$AskForDeleteConfirmationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = null,
  }) {
    return _then(_$AskForDeleteConfirmationImpl(
      null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactEntity,
    ));
  }
}

/// @nodoc

class _$AskForDeleteConfirmationImpl implements _AskForDeleteConfirmation {
  const _$AskForDeleteConfirmationImpl(this.contact);

  @override
  final ContactEntity contact;

  @override
  String toString() {
    return 'EditTrustedContactsReaction.askForDeleteConfirmation(contact: $contact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AskForDeleteConfirmationImpl &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AskForDeleteConfirmationImplCopyWith<_$AskForDeleteConfirmationImpl>
      get copyWith => __$$AskForDeleteConfirmationImplCopyWithImpl<
          _$AskForDeleteConfirmationImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ContactEntity contact) requestContactInfo,
    required TResult Function(ContactEntity contact) askForDeleteConfirmation,
  }) {
    return askForDeleteConfirmation(contact);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ContactEntity contact)? requestContactInfo,
    TResult? Function(ContactEntity contact)? askForDeleteConfirmation,
  }) {
    return askForDeleteConfirmation?.call(contact);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ContactEntity contact)? requestContactInfo,
    TResult Function(ContactEntity contact)? askForDeleteConfirmation,
    required TResult orElse(),
  }) {
    if (askForDeleteConfirmation != null) {
      return askForDeleteConfirmation(contact);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestContactInfo value) requestContactInfo,
    required TResult Function(_AskForDeleteConfirmation value)
        askForDeleteConfirmation,
  }) {
    return askForDeleteConfirmation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestContactInfo value)? requestContactInfo,
    TResult? Function(_AskForDeleteConfirmation value)?
        askForDeleteConfirmation,
  }) {
    return askForDeleteConfirmation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestContactInfo value)? requestContactInfo,
    TResult Function(_AskForDeleteConfirmation value)? askForDeleteConfirmation,
    required TResult orElse(),
  }) {
    if (askForDeleteConfirmation != null) {
      return askForDeleteConfirmation(this);
    }
    return orElse();
  }
}

abstract class _AskForDeleteConfirmation
    implements EditTrustedContactsReaction {
  const factory _AskForDeleteConfirmation(final ContactEntity contact) =
      _$AskForDeleteConfirmationImpl;

  @override
  ContactEntity get contact;
  @override
  @JsonKey(ignore: true)
  _$$AskForDeleteConfirmationImplCopyWith<_$AskForDeleteConfirmationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
