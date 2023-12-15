// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_trusted_contacts_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditTrustedContactsController
    on _EditTrustedContactsControllerBase, Store {
  Computed<EditTrustedContactsState>? _$stateComputed;

  @override
  EditTrustedContactsState get state =>
      (_$stateComputed ??= Computed<EditTrustedContactsState>(() => super.state,
              name: '_EditTrustedContactsControllerBase.state'))
          .value;

  final _$contactsAtom =
      Atom(name: '_EditTrustedContactsControllerBase.contacts');

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

  final _$_maxTrustedContactsAtom =
      Atom(name: '_EditTrustedContactsControllerBase._maxTrustedContacts');

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

  final _$_reactionAtom =
      Atom(name: '_EditTrustedContactsControllerBase._reaction');

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

  final _$updateContactAsyncAction =
      AsyncAction('_EditTrustedContactsControllerBase.updateContact');

  @override
  Future<void> updateContact(ContactEntity contact) {
    return _$updateContactAsyncAction.run(() => super.updateContact(contact));
  }

  final _$removeContactAsyncAction =
      AsyncAction('_EditTrustedContactsControllerBase.removeContact');

  @override
  Future<void> removeContact(ContactEntity contact) {
    return _$removeContactAsyncAction.run(() => super.removeContact(contact));
  }

  final _$_EditTrustedContactsControllerBaseActionController =
      ActionController(name: '_EditTrustedContactsControllerBase');

  @override
  void onUpdateContactPressed(ContactEntity contact) {
    final _$actionInfo =
        _$_EditTrustedContactsControllerBaseActionController.startAction(
            name: '_EditTrustedContactsControllerBase.onUpdateContactPressed');
    try {
      return super.onUpdateContactPressed(contact);
    } finally {
      _$_EditTrustedContactsControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void onRemoveContactPressed(ContactEntity contact) {
    final _$actionInfo =
        _$_EditTrustedContactsControllerBaseActionController.startAction(
            name: '_EditTrustedContactsControllerBase.onRemoveContactPressed');
    try {
      return super.onRemoveContactPressed(contact);
    } finally {
      _$_EditTrustedContactsControllerBaseActionController
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
