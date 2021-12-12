import 'package:collection/collection.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';

class GuardianSessionModel extends GuardianSessioEntity {
  final int remainingInvites;
  final int maximumInvites;
  final List<GuardianEntity> guards;

  GuardianSessionModel({
    required this.guards,
    required this.remainingInvites,
    required this.maximumInvites,
  }) : super(
          remainingInvites: remainingInvites,
          guards: guards,
          maximumInvites: maximumInvites,
        );

  factory GuardianSessionModel.fromJson(Map<String, Object> jsonData) {
    final remainingInvites = (jsonData['remaing_invites'] as num).toInt() ?? 0;
    final maximumInvites = (jsonData['invites_max'] as num).toInt() ?? 0;
    final List<Object> guardsData = jsonData['guards'] as List<Object>;
    final List<GuardianEntity> guards = guardsData
        .map((e) => _GuardianModel.fromJson(e))
        .whereNotNull()
        .toList();

    return GuardianSessionModel(
      guards: guards,
      remainingInvites: remainingInvites,
      maximumInvites: maximumInvites,
    );
  }
}

class _GuardianModel {
  static GuardianEntity fromJson(Map<String, Object> jsonData) {
    final Map<String, Object> metaData = jsonData['meta'] as Map<String, Object>;
    final List<Object> contactsData = jsonData['rows'] as List<Object>;

    final meta = GuardianSessionMeta(
        canEdit: metaData['can_edit'] == 1,
        canDelete: metaData['can_delete'] == 1,
        canResend: metaData['can_resend'] == 1,
        deleteWarning: metaData['delete_warning'] as String?,
        description: metaData['description'] as String?,
        header: metaData['header'] as String?,
        status: metaData['layout'] == 'accepted'
            ? GuardianStatus.accepted
            : GuardianStatus.pending,);

    final List<GuardianContactEntity> contacts = contactsData
        .map((e) => _GuardianContactModel.fromJson(e))
        .whereNotNull()
        .toList();

    return GuardianEntity(meta: meta, contacts: contacts);
  }
}

class _GuardianContactModel {
  static GuardianContactEntity fromJson(Map<String, dynamic> jsonData) {
    final int parsed = jsonData['id'] ?? 0;
    return GuardianContactEntity(
      id: parsed,
      mobile: jsonData['celular'] as String?,
      name: jsonData['nome'] as String?,
      status: jsonData['subtexto'] as String?,
    );
  }
}
