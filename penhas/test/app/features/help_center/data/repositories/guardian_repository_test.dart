import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/help_center/data/models/guardian_session_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';

import '../../../../../utils/json_util.dart';

class MockGuardianDataSource extends Mock implements IGuardianDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  IGuardianRepository sut;
  IGuardianDataSource dataSource;
  INetworkInfo networkInfo;

  setUp(() {
    networkInfo = MockNetworkInfo();
    dataSource = MockGuardianDataSource();
    sut = GuardianRepository(
      dataSource: dataSource,
      networkInfo: networkInfo,
    );
  });

  group('GuardianRepository', () {
    test('should get a empty list if there is no guardian', () async {
      // arrange
      final jsonSession =
          await JsonUtil.getJson(from: 'help_center/guardian_empty_list.json');
      final sessionModel = GuardianSessionModel.fromJson(jsonSession);
      final emptySession = GuardianSessionModel(
        remainingInvites: 5,
        guards: [
          GuardianEntity(
              meta: GuardianSessionMeta(
                  canResend: false,
                  deleteWarning: '',
                  description: "Guardiões que recebem seus pedidos de socorro.",
                  header: "Guardiões",
                  status: GuardianStatus.accepted),
              contacts: []),
          GuardianEntity(
              meta: GuardianSessionMeta(
                  canResend: false,
                  deleteWarning: '',
                  description: "Guardiões que ainda não aceitaram seu convite.",
                  header: "Pendentes",
                  status: GuardianStatus.pending),
              contacts: []),
        ],
      );
      when(dataSource.fetch()).thenAnswer((_) async => sessionModel);
      final expected = right(emptySession);
      // act
      final receceived = await sut.fetch();
      // assert
      expect(receceived, expected);
    });
    test('should get a list of guardians', () async {
      // arrange
      final jsonSession =
          await JsonUtil.getJson(from: 'help_center/guardian_list.json');
      final sessionModel = GuardianSessionModel.fromJson(jsonSession);
      when(dataSource.fetch()).thenAnswer((_) async => sessionModel);
      final expected = right(sessionModel);
      // act
      final receceived = await sut.fetch();
      // assert
      expect(receceived, expected);
    });
    test('should get ok message for a valid guardian inserted', () async {
      // arrange
      // act
      // assert
      expect(1, 0);
    });
    test('should get invalid message for a invalid number', () async {
      // arrange
      // act
      // assert
      expect(1, 0);
    });
    test('should update guardian name', () async {
      // arrange
      // act
      // assert
      expect(1, 0);
    });
    test('should remove one of my guardian', () async {
      // arrange
      // act
      // assert
      expect(1, 0);
    });
  });
}
