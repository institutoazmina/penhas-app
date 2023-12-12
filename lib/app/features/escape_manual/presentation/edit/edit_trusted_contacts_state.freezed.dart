// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'edit_trusted_contacts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EditTrustedContactsStateTearOff {
  const _$EditTrustedContactsStateTearOff();

  _LoadedState loaded(List<ContactEntity> contacts) {
    return _LoadedState(
      contacts,
    );
  }
}

/// @nodoc
const $EditTrustedContactsState = _$EditTrustedContactsStateTearOff();

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
    TResult Function(List<ContactEntity> contacts)? loaded,
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
    TResult Function(_LoadedState value)? loaded,
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
      _$EditTrustedContactsStateCopyWithImpl<$Res>;
  $Res call({List<ContactEntity> contacts});
}

/// @nodoc
class _$EditTrustedContactsStateCopyWithImpl<$Res>
    implements $EditTrustedContactsStateCopyWith<$Res> {
  _$EditTrustedContactsStateCopyWithImpl(this._value, this._then);

  final EditTrustedContactsState _value;
  // ignore: unused_field
  final $Res Function(EditTrustedContactsState) _then;

  @override
  $Res call({
    Object? contacts = freezed,
  }) {
    return _then(_value.copyWith(
      contacts: contacts == freezed
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<ContactEntity>,
    ));
  }
}

/// @nodoc
abstract class _$LoadedStateCopyWith<$Res>
    implements $EditTrustedContactsStateCopyWith<$Res> {
  factory _$LoadedStateCopyWith(
          _LoadedState value, $Res Function(_LoadedState) then) =
      __$LoadedStateCopyWithImpl<$Res>;
  @override
  $Res call({List<ContactEntity> contacts});
}

/// @nodoc
class __$LoadedStateCopyWithImpl<$Res>
    extends _$EditTrustedContactsStateCopyWithImpl<$Res>
    implements _$LoadedStateCopyWith<$Res> {
  __$LoadedStateCopyWithImpl(
      _LoadedState _value, $Res Function(_LoadedState) _then)
      : super(_value, (v) => _then(v as _LoadedState));

  @override
  _LoadedState get _value => super._value as _LoadedState;

  @override
  $Res call({
    Object? contacts = freezed,
  }) {
    return _then(_LoadedState(
      contacts == freezed
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<ContactEntity>,
    ));
  }
}

/// @nodoc

class _$_LoadedState implements _LoadedState {
  const _$_LoadedState(this.contacts);

  @override
  final List<ContactEntity> contacts;

  @override
  String toString() {
    return 'EditTrustedContactsState.loaded(contacts: $contacts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadedState &&
            const DeepCollectionEquality().equals(other.contacts, contacts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(contacts));

  @JsonKey(ignore: true)
  @override
  _$LoadedStateCopyWith<_LoadedState> get copyWith =>
      __$LoadedStateCopyWithImpl<_LoadedState>(this, _$identity);

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
    TResult Function(List<ContactEntity> contacts)? loaded,
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
    TResult Function(_LoadedState value)? loaded,
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
  const factory _LoadedState(List<ContactEntity> contacts) = _$_LoadedState;

  @override
  List<ContactEntity> get contacts;
  @override
  @JsonKey(ignore: true)
  _$LoadedStateCopyWith<_LoadedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$EditTrustedContactsReactionTearOff {
  const _$EditTrustedContactsReactionTearOff();

  _RequestContactInfo requestContactInfo(ContactEntity contact) {
    return _RequestContactInfo(
      contact,
    );
  }

  _AskForDeleteConfirmation askForDeleteConfirmation(ContactEntity contact) {
    return _AskForDeleteConfirmation(
      contact,
    );
  }
}

/// @nodoc
const $EditTrustedContactsReaction = _$EditTrustedContactsReactionTearOff();

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
    TResult Function(ContactEntity contact)? requestContactInfo,
    TResult Function(ContactEntity contact)? askForDeleteConfirmation,
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
    TResult Function(_RequestContactInfo value)? requestContactInfo,
    TResult Function(_AskForDeleteConfirmation value)? askForDeleteConfirmation,
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
      _$EditTrustedContactsReactionCopyWithImpl<$Res>;
  $Res call({ContactEntity contact});
}

/// @nodoc
class _$EditTrustedContactsReactionCopyWithImpl<$Res>
    implements $EditTrustedContactsReactionCopyWith<$Res> {
  _$EditTrustedContactsReactionCopyWithImpl(this._value, this._then);

  final EditTrustedContactsReaction _value;
  // ignore: unused_field
  final $Res Function(EditTrustedContactsReaction) _then;

  @override
  $Res call({
    Object? contact = freezed,
  }) {
    return _then(_value.copyWith(
      contact: contact == freezed
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactEntity,
    ));
  }
}

/// @nodoc
abstract class _$RequestContactInfoCopyWith<$Res>
    implements $EditTrustedContactsReactionCopyWith<$Res> {
  factory _$RequestContactInfoCopyWith(
          _RequestContactInfo value, $Res Function(_RequestContactInfo) then) =
      __$RequestContactInfoCopyWithImpl<$Res>;
  @override
  $Res call({ContactEntity contact});
}

/// @nodoc
class __$RequestContactInfoCopyWithImpl<$Res>
    extends _$EditTrustedContactsReactionCopyWithImpl<$Res>
    implements _$RequestContactInfoCopyWith<$Res> {
  __$RequestContactInfoCopyWithImpl(
      _RequestContactInfo _value, $Res Function(_RequestContactInfo) _then)
      : super(_value, (v) => _then(v as _RequestContactInfo));

  @override
  _RequestContactInfo get _value => super._value as _RequestContactInfo;

  @override
  $Res call({
    Object? contact = freezed,
  }) {
    return _then(_RequestContactInfo(
      contact == freezed
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactEntity,
    ));
  }
}

/// @nodoc

class _$_RequestContactInfo implements _RequestContactInfo {
  const _$_RequestContactInfo(this.contact);

  @override
  final ContactEntity contact;

  @override
  String toString() {
    return 'EditTrustedContactsReaction.requestContactInfo(contact: $contact)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestContactInfo &&
            const DeepCollectionEquality().equals(other.contact, contact));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(contact));

  @JsonKey(ignore: true)
  @override
  _$RequestContactInfoCopyWith<_RequestContactInfo> get copyWith =>
      __$RequestContactInfoCopyWithImpl<_RequestContactInfo>(this, _$identity);

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
    TResult Function(ContactEntity contact)? requestContactInfo,
    TResult Function(ContactEntity contact)? askForDeleteConfirmation,
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
    TResult Function(_RequestContactInfo value)? requestContactInfo,
    TResult Function(_AskForDeleteConfirmation value)? askForDeleteConfirmation,
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
  const factory _RequestContactInfo(ContactEntity contact) =
      _$_RequestContactInfo;

  @override
  ContactEntity get contact;
  @override
  @JsonKey(ignore: true)
  _$RequestContactInfoCopyWith<_RequestContactInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AskForDeleteConfirmationCopyWith<$Res>
    implements $EditTrustedContactsReactionCopyWith<$Res> {
  factory _$AskForDeleteConfirmationCopyWith(_AskForDeleteConfirmation value,
          $Res Function(_AskForDeleteConfirmation) then) =
      __$AskForDeleteConfirmationCopyWithImpl<$Res>;
  @override
  $Res call({ContactEntity contact});
}

/// @nodoc
class __$AskForDeleteConfirmationCopyWithImpl<$Res>
    extends _$EditTrustedContactsReactionCopyWithImpl<$Res>
    implements _$AskForDeleteConfirmationCopyWith<$Res> {
  __$AskForDeleteConfirmationCopyWithImpl(_AskForDeleteConfirmation _value,
      $Res Function(_AskForDeleteConfirmation) _then)
      : super(_value, (v) => _then(v as _AskForDeleteConfirmation));

  @override
  _AskForDeleteConfirmation get _value =>
      super._value as _AskForDeleteConfirmation;

  @override
  $Res call({
    Object? contact = freezed,
  }) {
    return _then(_AskForDeleteConfirmation(
      contact == freezed
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactEntity,
    ));
  }
}

/// @nodoc

class _$_AskForDeleteConfirmation implements _AskForDeleteConfirmation {
  const _$_AskForDeleteConfirmation(this.contact);

  @override
  final ContactEntity contact;

  @override
  String toString() {
    return 'EditTrustedContactsReaction.askForDeleteConfirmation(contact: $contact)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AskForDeleteConfirmation &&
            const DeepCollectionEquality().equals(other.contact, contact));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(contact));

  @JsonKey(ignore: true)
  @override
  _$AskForDeleteConfirmationCopyWith<_AskForDeleteConfirmation> get copyWith =>
      __$AskForDeleteConfirmationCopyWithImpl<_AskForDeleteConfirmation>(
          this, _$identity);

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
    TResult Function(ContactEntity contact)? requestContactInfo,
    TResult Function(ContactEntity contact)? askForDeleteConfirmation,
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
    TResult Function(_RequestContactInfo value)? requestContactInfo,
    TResult Function(_AskForDeleteConfirmation value)? askForDeleteConfirmation,
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
  const factory _AskForDeleteConfirmation(ContactEntity contact) =
      _$_AskForDeleteConfirmation;

  @override
  ContactEntity get contact;
  @override
  @JsonKey(ignore: true)
  _$AskForDeleteConfirmationCopyWith<_AskForDeleteConfirmation> get copyWith =>
      throw _privateConstructorUsedError;
}
