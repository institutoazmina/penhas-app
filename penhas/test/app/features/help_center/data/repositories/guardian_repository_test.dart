import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';
import 'package:penhas/app/features/help_center/data/models/guardian_session_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';
import 'package:penhas/app/shared/logger/log.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late final MockIGuardianDataSource dataSource = MockIGuardianDataSource();
  late final MockINetworkInfo networkInfo = MockINetworkInfo();
  late final IGuardianRepository sut = GuardianRepository(
    dataSource: dataSource,
    networkInfo: networkInfo,
  );

  setUp(() {
    when(networkInfo.isConnected).thenAnswer((_) => Future.value(true));
  });

  group(
    'GuardianRepository',
    () {
      test(
        'should get a empty list if there is no guardian',
        () async {
          // arrange
          final jsonSession = await JsonUtil.getJson(
            from: 'help_center/guardian_empty_list.json',
          );
          final sessionModel = GuardianSessionModel.fromJson(jsonSession);
          const emptySession = GuardianSessionModel(
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
                  status: GuardianStatus.accepted,
                ),
                contacts: [],
              ),
              GuardianEntity(
                meta: GuardianSessionMeta(
                  canEdit: true,
                  canDelete: true,
                  canResend: false,
                  deleteWarning: '',
                  description: 'Guardiões que ainda não aceitaram seu convite.',
                  header: 'Pendentes',
                  status: GuardianStatus.pending,
                ),
                contacts: [],
              ),
            ],
          );
          when(dataSource.fetch()).thenAnswer((_) async => sessionModel);
          final expected = right(emptySession);
          // act
          final receceived = await sut.fetch();
          // assert
          expect(receceived, expected);
        },
      );
      test(
        'should get a list of guardians',
        () async {
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
        },
      );
      test(
        'should get ok message for a valid guardian inserted',
        () async {
          // arrange
          final jsonSession = await JsonUtil.getJson(
            from: 'help_center/guardian_create_successful.json',
          );
          final guardian = GuardianContactEntity.createRequest(
            name: 'Maria',
            mobile: '1191910101',
          );
          final response = AlertModel.fromJson(jsonSession);
          final expected = right(response);
          when(dataSource.create(any)).thenAnswer((_) async => response);
          // act
          final received = await sut.create(guardian);
          // assert
          expect(received, expected);
        },
      );
      test(
        'should get invalid message for a invalid number',
        () async {
          // arrange
          final bodyContent = await JsonUtil.getJson(
            from: 'help_center/guardian_bad_celular_number.json',
          );
          final guardian = GuardianContactEntity.createRequest(
            name: 'Maria',
            mobile: '91910101',
          );
          final expected = left(
            ServerSideFormFieldValidationFailure(
              error: bodyContent['error'] as String?,
              field: bodyContent['field'] as String?,
              message: bodyContent['message'] as String?,
              reason: bodyContent['reason'] as String?,
            ),
          );
          when(dataSource.create(any))
              .thenThrow(ApiProviderException(bodyContent: bodyContent));
          // act
          final received = await sut.create(guardian);
          // assert
          expect(received, expected);
        },
      );
      test(
        'should update guardian name',
        () async {
          // arrange
          final jsonSession = await JsonUtil.getJson(
            from: 'help_center/guardian_update_name.json',
          );
          const guardian = GuardianContactEntity(
            id: 1,
            mobile: '(11) 91910101',
            name: 'Renato Lindão',
            status: 'pending',
          );

          final response = ValidField.fromJson(jsonSession);
          final expected = right(response);
          when(dataSource.update(any)).thenAnswer((_) async => response);
          // act
          final received = await sut.update(guardian);
          // assert
          expect(received, expected);
        },
      );
      test(
        'should remove one of my guardian',
        () async {
          // arrange
          const guardian = GuardianContactEntity(
            id: 1,
            mobile: '(11) 91910101',
            name: 'Maria (PenhaS)',
            status: 'pending',
          );
          final expected = right(const ValidField());
          when(dataSource.delete(any))
              .thenAnswer((_) async => const ValidField());
          // act
          final received = await sut.delete(guardian);
          // assert
          expect(received, expected);
        },
      );

      group('alert', () {
        test(
          'should get a valid message for valid request',
          () async {
            // arrange
            const location = UserLocationEntity(latitude: 1.0, longitude: -1.0);
            final expected = right(
              const AlertModel(
                title: 'Alerta enviado!',
                message: 'Alerta disparado com sucesso para 1 guardião.',
              ),
            );
            when(dataSource.alert(any)).thenAnswer(
              (_) async => const AlertModel(
                title: 'Alerta enviado!',
                message: 'Alerta disparado com sucesso para 1 guardião.',
              ),
            );
            // act
            final received = await sut.alert(location);
            // assert
            expect(received, expected);
          },
        );
      });
    },
  );
}
