import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

class MockSupportCenterRepository extends Mock
    implements ISupportCenterRepository {}

class MockLocationServices extends Mock implements ILocationServices {}

void main() {
  late SupportCenterUseCase sut;
  late ISupportCenterRepository supportCenterRepository;
  late ILocationServices locationServices;

  setUp(() {
    locationServices = MockLocationServices();
    supportCenterRepository = MockSupportCenterRepository();
    sut = SupportCenterUseCase(
      locationService: locationServices,
      supportCenterRepository: supportCenterRepository,
    );
  });

  group(SupportCenterUseCase, () {
    group('fetch', () {
      test('get GPSFailure for invalid gps information', () async {
        // arrange
        final fetchRequest = SupportCenterFetchRequest();
        final gpsFailure =
            'Não foi possível encontrar sua localização através do CEP 01203-777, tente novamente mais tarde ou ative a localização';
        final actual = left(
          GpsFailure(gpsFailure),
        );
        when(() => supportCenterRepository.fetch(any())).thenAnswer(
          (_) async => left(GpsFailure(gpsFailure)),
        );
        when(() => locationServices.currentLocation()).thenAnswer(
          (_) async => right(const UserLocationEntity()),
        );
        when(() => locationServices.isPermissionGranted())
            .thenAnswer((_) async => true);
        // act
        final matcher = await sut.fetch(fetchRequest);
        // assert
        expect(actual, matcher);
      });
    });
  });
}
