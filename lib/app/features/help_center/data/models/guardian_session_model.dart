import '../../domain/entities/guardian_session_entity.dart';

class GuardianSessionModel extends GuardianSessionEntity {
  const GuardianSessionModel({
    required List<GuardianEntity> guards,
    required int remainingInvites,
    required int maximumInvites,
  }) : super(
          remainingInvites: remainingInvites,
          guards: guards,
          maximumInvites: maximumInvites,
        );

  factory GuardianSessionModel.fromJson(Map<String, dynamic> jsonData) {
    final int remainingInvites = jsonData['remaing_invites'] ?? 0;
    final int maximumInvites = jsonData['invites_max'] ?? 0;
    final List<dynamic> guardsData = jsonData['guards'];
    final List<GuardianEntity> guards =
        guardsData.map((e) => _GuardianModel.fromJson(e)).nonNulls.toList();

    return GuardianSessionModel(
      guards: guards,
      remainingInvites: remainingInvites,
      maximumInvites: maximumInvites,
    );
  }
}

class _GuardianModel {
  static GuardianEntity fromJson(Map<String, dynamic> jsonData) {
    final Map<String, dynamic> metaData = jsonData['meta'];
    final List<dynamic> contactsData = jsonData['rows'];

    final meta = GuardianSessionMeta(
      canEdit: metaData['can_edit'] == 1,
      canDelete: metaData['can_delete'] == 1,
      canResend: metaData['can_resend'] == 1,
      deleteWarning: metaData['delete_warning'],
      description: metaData['description'],
      header: metaData['header'],
      status: metaData['layout'] == 'accepted'
          ? GuardianStatus.accepted
          : GuardianStatus.pending,
    );

    final List<GuardianContactEntity> contacts = contactsData
        .map((e) => _GuardianContactModel.fromJson(e))
        .nonNulls
        .toList();

    return GuardianEntity(meta: meta, contacts: contacts);
  }
}

class _GuardianContactModel {
  static GuardianContactEntity fromJson(Map<String, dynamic> jsonData) {
    final int parsed = jsonData['id'] ?? 0;
    return GuardianContactEntity(
      id: parsed,
      mobile: jsonData['celular'],
      name: jsonData['nome'],
      status: jsonData['subtexto'],
    );
  }
}
