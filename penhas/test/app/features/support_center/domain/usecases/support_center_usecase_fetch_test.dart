import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

import '../../../../../utils/json_util.dart';

class MockSupportCenterRepository extends Mock
    implements ISupportCenterRepository {}

void main() {
  ISupportCenterRepository supportCenterRepository;
  SupportCenterUseCase sut;

  setUp(() {
    supportCenterRepository = MockSupportCenterRepository();
    sut =
        SupportCenterUseCase(supportCenterRepository: supportCenterRepository);
  });

  group('SupportCenterUsecase', () {
    group('fetch', () {
      test('should get GPSFailure for invalid gps information', () async {
        // arrange
        final gpsFailure =
            "Não foi possível encontrar sua localização através do CEP 01203-777, tente novamente mais tarde ou ative a localização";
        final actual = left(
          GpsFailure(gpsFailure),
        );
        when(supportCenterRepository.fetch()).thenAnswer((_) async => left(
              GpsFailure(gpsFailure),
            ));
        // act
        final matcher = await sut.fetch();
        // assert
        expect(actual, matcher);
      });
    });
  });
}
