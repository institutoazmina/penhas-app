// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

class MockSupportCenterRepository extends Mock
    implements ISupportCenterRepository {}

class MockLocationServices extends Mock implements ILocationServices {}

void main() {
  late SupportCenterUseCase sut;
  late ILocationServices locationServices;
  late ISupportCenterRepository supportCenterRepository;

  setUp(() {
    locationServices = MockLocationServices();
    supportCenterRepository = MockSupportCenterRepository();

    sut = SupportCenterUseCase(
      locationService: locationServices,
      supportCenterRepository: supportCenterRepository,
    );
  });

  group(SupportCenterUseCase, () {
    group('metadata', () {
      test('hit repository for first access', () async {
        // arrange
        final actual = right(_buildSupportMetadata());
        when(() => supportCenterRepository.metadata()).thenAnswer(
          (_) async => right(_buildSupportMetadata()),
        );
        // act
        final expected = await sut.metadata();
        // assert
        verify(() => supportCenterRepository.metadata()).called(1);
        expect(actual, expected);
      });

      test('avoid hit repository twice', () async {
        when(() => supportCenterRepository.metadata()).thenAnswer(
          (_) async => right(_buildSupportMetadata()),
        );
        await sut.metadata();
        // act
        await sut.metadata();
        // assert
        verify(() => supportCenterRepository.metadata()).called(1);
      });
    });

    group('fetch', () {
      test('fetches SupportCenterPlaceSessionEntity successfully', () async {
        // arrange
        final request = SupportCenterFetchRequest();
        final actual = right(_buildSupportPlace());

        when(() => locationServices.isPermissionGranted())
            .thenAnswer((_) async => true);
        when(() => locationServices.currentLocation()).thenAnswer((_) async =>
            right(UserLocationEntity(latitude: 1.0, longitude: 1.0)));
        when(() => supportCenterRepository.fetch(any()))
            .thenAnswer((_) async => right(_buildSupportPlace()));
        // act
        final matcher = await sut.fetch(request);
        // assert
        verify(() => locationServices.currentLocation()).called(1);
        verify(() => supportCenterRepository.fetch(any())).called(1);

        expect(actual, matcher);
      });
    });
  });
}

SupportCenterMetadataEntity _buildSupportMetadata() {
  return SupportCenterMetadataEntity(
    projects: [
      FilterTagEntity(id: '3', label: 'MAMU', isSelected: false),
      FilterTagEntity(id: '2', label: 'Mapa Delegacia', isSelected: false),
      FilterTagEntity(id: '1', label: 'Penhas', isSelected: false)
    ],
    categories: [
      FilterTagEntity(
          id: '8', label: 'Casa da Mulher Brasileira', isSelected: false),
      FilterTagEntity(
          id: '1', label: 'Centros de Atendimento', isSelected: false),
      FilterTagEntity(
          id: '6', label: 'Centros de atendimento à mulher', isSelected: false)
    ],
  );
}

SupportCenterPlaceSessionEntity _buildSupportPlace() {
  return SupportCenterPlaceSessionEntity(
    hasMore: false,
    latitude: 1.0,
    longitude: 1.0,
    maximumRate: 2,
    nextPage: '',
    places: [
      SupportCenterPlaceEntity(
        id: '1',
        rate: null,
        ratedByClient: 2,
        distance: null,
        latitude: 2.0,
        longitude: 2.0,
        name: 'Place Name',
        uf: 'UF',
        fullStreet: 'Full Street',
        category: SupportCenterPlaceCategoryEntity(
          color: '000000',
          id: 3,
          name: 'Categoria',
        ),
        typeOfPlace: null,
        htmlContent: null,
      )
    ],
  );
}
