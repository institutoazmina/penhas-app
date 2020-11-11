import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

import '../../../../../utils/json_util.dart';

class MockLocationServices extends Mock implements ILocationServices {}

class MockSupportCenterRepository extends Mock
    implements ISupportCenterRepository {}

void main() {
  ISupportCenterRepository supportCenterRepository;
  ILocationServices locationServices;
  SupportCenterUseCase sut;

  setUp(() {
    supportCenterRepository = MockSupportCenterRepository();
    locationServices = MockLocationServices();

    sut = SupportCenterUseCase(
      locationService: locationServices,
      supportCenterRepository: supportCenterRepository,
    );
  });

  group('SupportCenterUsecase', () {
    group('fetch', () {
      test('should get GPSFailure for invalid gps information', () async {
        // arrange
        final fetchRequest = SupportCenterFetchRequest();
        final gpsFailure =
            "Não foi possível encontrar sua localização através do CEP 01203-777, tente novamente mais tarde ou ative a localização";
        final actual = left(
          GpsFailure(gpsFailure),
        );
        when(supportCenterRepository.fetch(any)).thenAnswer((_) async => left(
              GpsFailure(gpsFailure),
            ));
        // act
        final matcher = await sut.fetch(fetchRequest);
        // assert
        expect(actual, matcher);
      });
    });
  });
}
