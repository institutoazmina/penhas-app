import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';
import 'package:penhas/app/features/help_center/data/models/guardian_session_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';

import '../../../../../utils/json_util.dart';

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockGuardianDataSource extends Mock implements IGuardianDataSource {}

void main() {
  late IGuardianRepository sut;
  late IGuardianDataSource dataSource;
  late INetworkInfo networkInfo;

  setUp(() {
    networkInfo = MockNetworkInfo();
    dataSource = MockGuardianDataSource();
    sut = GuardianRepository(
      dataSource: dataSource,
      networkInfo: networkInfo,
    );

    when(() => networkInfo.isConnected).thenAnswer((_) => Future.value(true));
  });

  group(
    GuardianRepository,
    () {
      test(
        'get a empty list if there is no guardian',
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
          when(() => dataSource.fetch()).thenAnswer((_) async => sessionModel);
          final expected = right(emptySession);
          // act
          final actual = await sut.fetch();
          // assert
          expect(actual, expected);
        },
      );
      test(
        'get a list of guardians',
        () async {
          // arrange
          final jsonSession =
              await JsonUtil.getJson(from: 'help_center/guardian_list.json');
          final sessionModel = GuardianSessionModel.fromJson(jsonSession);
          when(() => dataSource.fetch()).thenAnswer((_) async => sessionModel);
          final expected = right(sessionModel);
          // act
          final actual = await sut.fetch();
          // assert
          expect(actual, expected);
        },
      );
      test(
        'get ok message for a valid guardian inserted',
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
          when(() => dataSource.create(guardian))
              .thenAnswer((_) async => response);
          // act
          final actual = await sut.create(guardian);
          // assert
          expect(actual, expected);
        },
      );
      test(
        'get invalid message for a invalid number',
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
          when(() => dataSource.create(guardian))
              .thenThrow(ApiProviderException(bodyContent: bodyContent));
          // act
          final actual = await sut.create(guardian);
          // assert
          expect(actual, expected);
        },
      );
      test(
        'update guardian name',
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
          when(() => dataSource.update(guardian))
              .thenAnswer((_) async => response);
          // act
          final actual = await sut.update(guardian);
          // assert
          expect(actual, expected);
        },
      );
      test(
        'remove one of my guardian',
        () async {
          // arrange
          const guardian = GuardianContactEntity(
            id: 1,
            mobile: '(11) 91910101',
            name: 'Maria (PenhaS)',
            status: 'pending',
          );
          final expected = right(const ValidField());
          when(() => dataSource.delete(guardian))
              .thenAnswer((_) async => const ValidField());
          // act
          final actual = await sut.delete(guardian);
          // assert
          expect(actual, expected);
        },
      );

      group('alert', () {
        test(
          'get a valid message for valid request',
          () async {
            // arrange
            const location = UserLocationEntity(latitude: 1.0, longitude: -1.0);
            final expected = right(
              const AlertModel(
                title: 'Alerta enviado!',
                message: 'Alerta disparado com sucesso para 1 guardião.',
              ),
            );
            when(() => dataSource.alert(location)).thenAnswer(
              (_) async => const AlertModel(
                title: 'Alerta enviado!',
                message: 'Alerta disparado com sucesso para 1 guardião.',
              ),
            );
            // act
            final actual = await sut.alert(location);
            // assert
            expect(actual, expected);
          },
        );
      });
    },
  );
}
