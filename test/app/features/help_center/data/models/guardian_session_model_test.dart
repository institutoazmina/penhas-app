import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/help_center/data/models/guardian_session_model.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  GuardianSessionModel sessionModel;
  setUp(() {});

  group('GuardianSessionModel', () {
    test('should be a subclass of GuardianSessioEntity', () async {
      // arrange
      sessionModel = const GuardianSessionModel(
        guards: [],
        remainingInvites: 0,
        maximumInvites: 0,
      );
      // assert
      expect(sessionModel, isA<GuardianSessioEntity>());
    });

    test('should return a valid model with a valid JSON', () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'help_center/guardian_list.json');
      const expected = GuardianSessionModel(
        remainingInvites: 5,
        maximumInvites: 5,
        guards: [
          GuardianEntity(
            meta: GuardianSessionMeta(
                canEdit: true,
                canDelete: true,
                canResend: false,
                deleteWarning: '',
                description: 'Guardiões que recebem seus pedidos de socorro.',
                header: 'Guardiões',
                status: GuardianStatus.accepted,),
            contacts: [
              GuardianContactEntity(
                id: 172,
                mobile: '+1 484-291-8467',
                name: 'test nome',
                status: 'Convite enviado há pouco tempo',
              )
            ],
          ),
          GuardianEntity(
            meta: GuardianSessionMeta(
                canEdit: true,
                canDelete: true,
                canResend: false,
                deleteWarning: '',
                description: 'Guardiões que ainda não aceitaram seu convite.',
                header: 'Pendentes',
                status: GuardianStatus.pending,),
            contacts: [],
          )
        ],
      );
      // act
      final received = GuardianSessionModel.fromJson(jsonData);
      // assert
      expect(received, expected);
    });
  });
}
