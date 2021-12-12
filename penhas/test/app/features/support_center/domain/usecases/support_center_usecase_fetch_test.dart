import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

import '../../../../../utils/helper.mocks.dart';

void main() {
  ISupportCenterRepository? supportCenterRepository;
  ILocationServices? locationServices;
  late SupportCenterUseCase sut;

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
        const fetchRequest = SupportCenterFetchRequest();
        const gpsFailure =
            'Não foi possível encontrar sua localização através do CEP 01203-777, tente novamente mais tarde ou ative a localização';
        final actual = left(
          GpsFailure(gpsFailure),
        );
        when(supportCenterRepository!.fetch(any)).thenAnswer((_) async => left(
              GpsFailure(gpsFailure),
            ));
        when(locationServices!.currentLocation()).thenAnswer((_) async => right(
            UserLocationEntity(accuracy: 0, latitude: 0.0, longitude: 0.0)));
        when(locationServices!.isPermissionGranted())
            .thenAnswer((_) async => true);
        // act
        final matcher = await sut.fetch(fetchRequest);
        // assert
        expect(actual, matcher);
      });
    });
  });
}
