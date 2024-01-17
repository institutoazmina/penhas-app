import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/contact.dart';

part 'edit_trusted_contacts_state.freezed.dart';

@freezed
class EditTrustedContactsState with _$EditTrustedContactsState {
  const factory EditTrustedContactsState.loaded(List<ContactEntity> contacts) =
      _LoadedState;
}

@freezed
class EditTrustedContactsReaction with _$EditTrustedContactsReaction {
  const factory EditTrustedContactsReaction.requestContactInfo(
    ContactEntity contact,
  ) = _RequestContactInfo;

  const factory EditTrustedContactsReaction.askForDeleteConfirmation(
    ContactEntity contact,
  ) = _AskForDeleteConfirmation;
}

class ContactPlaceholder extends ContactEntity {
  const ContactPlaceholder(int id)
      : super(
          id: id,
          name: 'Contato $id',
          phone: '(00) 0000-0000',
        );
}
