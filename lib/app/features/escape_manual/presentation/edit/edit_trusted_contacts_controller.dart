import 'dart:async';

import 'package:mobx/mobx.dart';

import '../../domain/entity/escape_manual.dart';
import '../../domain/escape_manual_toggle.dart';
import 'edit_trusted_contacts_state.dart';

part 'edit_trusted_contacts_controller.g.dart';

typedef OnEditTrustedContactsReaction = void Function(
  EditTrustedContactsReaction? reaction,
);

class EditTrustedContactsController = _EditTrustedContactsControllerBase
    with _$EditTrustedContactsController;

abstract class _EditTrustedContactsControllerBase with Store {
  _EditTrustedContactsControllerBase({
    required List<ContactEntity>? contacts,
    required EscapeManualToggleFeature escapeManualToggleFeature,
  })  : contacts = contacts ?? <ContactEntity>[],
        _escapeManualToggleFeature = escapeManualToggleFeature {
    _loadMaxTrustedContacts();
  }

  final EscapeManualToggleFeature _escapeManualToggleFeature;

  @observable
  List<ContactEntity> contacts;

  @observable
  int _maxTrustedContacts = 0;

  @computed
  EditTrustedContactsState get state => _state();

  @observable
  EditTrustedContactsReaction? _reaction;

  @action
  void onUpdateContactPressed(ContactEntity contact) {
    contact = contact is ContactPlaceholder
        ? contact.copyWith(name: '', phone: '')
        : contact;
    _reaction = EditTrustedContactsReaction.requestContactInfo(contact);
  }

  @action
  void onRemoveContactPressed(ContactEntity contact) {
    if (contact is ContactPlaceholder) return;
    _reaction = EditTrustedContactsReaction.askForDeleteConfirmation(contact);
  }

  @action
  Future<void> updateContact(ContactEntity contact) async {
    contacts = [
      contact,
      ...contacts.where((e) => e.id != contact.id),
    ];
  }

  @action
  Future<void> removeContact(ContactEntity contact) async {
    contacts = contacts.where((e) => e.id != contact.id).toList();
  }

  ReactionDisposer onReaction(OnEditTrustedContactsReaction fn) =>
      reaction<EditTrustedContactsReaction?>(
        (_) => _reaction,
        fn,
        equals: (_, __) => false,
      );

  void _loadMaxTrustedContacts() async {
    _maxTrustedContacts = await _escapeManualToggleFeature.maxTrustedContacts;
  }

  EditTrustedContactsState _state() {
    final contacts = _contactsWithPlaceholder();
    return EditTrustedContactsState.loaded(contacts);
  }

  List<ContactEntity> _contactsWithPlaceholder() {
    return List.generate(
      _maxTrustedContacts,
      (index) => contacts.firstWhere(
        (el) => el.id == index + 1,
        orElse: () => ContactPlaceholder(index + 1),
      ),
    );
  }
}
