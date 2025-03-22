// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_trusted_contacts_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditTrustedContactsController
    on EditTrustedContactsControllerBase, Store {
  Computed<EditTrustedContactsState>? _$stateComputed;

  @override
  EditTrustedContactsState get state =>
      (_$stateComputed ??= Computed<EditTrustedContactsState>(() => super.state,
              name: 'EditTrustedContactsControllerBase.state'))
          .value;

  late final _$contactsAtom = Atom(
      name: 'EditTrustedContactsControllerBase.contacts', context: context);

  @override
  List<ContactEntity> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(List<ContactEntity> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$_maxTrustedContactsAtom = Atom(
      name: 'EditTrustedContactsControllerBase._maxTrustedContacts',
      context: context);

  @override
  int get _maxTrustedContacts {
    _$_maxTrustedContactsAtom.reportRead();
    return super._maxTrustedContacts;
  }

  @override
  set _maxTrustedContacts(int value) {
    _$_maxTrustedContactsAtom.reportWrite(value, super._maxTrustedContacts, () {
      super._maxTrustedContacts = value;
    });
  }

  late final _$_reactionAtom = Atom(
      name: 'EditTrustedContactsControllerBase._reaction', context: context);

  @override
  EditTrustedContactsReaction? get _reaction {
    _$_reactionAtom.reportRead();
    return super._reaction;
  }

  @override
  set _reaction(EditTrustedContactsReaction? value) {
    _$_reactionAtom.reportWrite(value, super._reaction, () {
      super._reaction = value;
    });
  }

  late final _$updateContactAsyncAction = AsyncAction(
      'EditTrustedContactsControllerBase.updateContact',
      context: context);

  @override
  Future<void> updateContact(ContactEntity contact) {
    return _$updateContactAsyncAction.run(() => super.updateContact(contact));
  }

  late final _$removeContactAsyncAction = AsyncAction(
      'EditTrustedContactsControllerBase.removeContact',
      context: context);

  @override
  Future<void> removeContact(ContactEntity contact) {
    return _$removeContactAsyncAction.run(() => super.removeContact(contact));
  }

  late final _$EditTrustedContactsControllerBaseActionController =
      ActionController(
          name: 'EditTrustedContactsControllerBase', context: context);

  @override
  void onUpdateContactPressed(ContactEntity contact) {
    final _$actionInfo =
        _$EditTrustedContactsControllerBaseActionController.startAction(
            name: 'EditTrustedContactsControllerBase.onUpdateContactPressed');
    try {
      return super.onUpdateContactPressed(contact);
    } finally {
      _$EditTrustedContactsControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void onRemoveContactPressed(ContactEntity contact) {
    final _$actionInfo =
        _$EditTrustedContactsControllerBaseActionController.startAction(
            name: 'EditTrustedContactsControllerBase.onRemoveContactPressed');
    try {
      return super.onRemoveContactPressed(contact);
    } finally {
      _$EditTrustedContactsControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
contacts: ${contacts},
state: ${state}
    ''';
  }
}
