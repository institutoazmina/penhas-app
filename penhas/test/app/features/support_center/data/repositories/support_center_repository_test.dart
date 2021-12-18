import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/support_center/data/models/geolocation_model.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_place_session_model.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/shared/logger/log.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late final MockIApiProvider apiProvider = MockIApiProvider();
  late final ISupportCenterRepository sut =
      SupportCenterRepository(apiProvider: apiProvider);
  const SupportCenterFetchRequest fetchRequest = SupportCenterFetchRequest();

  group('SupportCenterRepository', () {
    test('metadata should return valid objects from server', () async {
      // arrange
      const jsonFile = 'support_center/support_center_meta_data.json';
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = right(SupportCenterMetadataModel.fromJson(jsonData));
      when(
        apiProvider.get(
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      final matcher = await sut.metadata();
      // assert
      expect(actual, matcher);
    });
    group('fetch', () {
      test('should get GpsFailure for invalid gps information', () async {
        // arrange
        const jsonFile = 'support_center/support_center_no_gps.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = left(GpsFailure(jsonData['message'] as String?));

        when(
          apiProvider.get(
            path: anyNamed('path'),
            headers: anyNamed('headers'),
            parameters: anyNamed('parameters'),
          ),
        ).thenThrow(ApiProviderException(bodyContent: jsonData));
        // act
        final matcher = await sut.fetch(fetchRequest);
        // assert
        expect(actual, matcher);
      });

      test('should get a valid session from successful return', () async {
        // arrange
        const jsonFile = 'support_center/support_center_list_of_place.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = right(SupportCenterPlaceSessionModel.fromJson(jsonData));
        when(
          apiProvider.get(
            path: anyNamed('path'),
            headers: anyNamed('headers'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
        // act
        final matcher = await sut.fetch(fetchRequest);
        // assert
        expect(actual, matcher);
      });
    });
    group('mapGeoFromCep', () {
      test('should get AddressFailure for invalid address information',
          () async {
        // arrange
        const jsonFile = 'support_center/support_center_geocode_error.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = left(AddressFailure(jsonData['message'] as String?));

        when(
          apiProvider.get(
            path: anyNamed('path'),
            headers: anyNamed('headers'),
            parameters: anyNamed('parameters'),
          ),
        ).thenThrow(ApiProviderException(bodyContent: jsonData));
        // act
        final matcher = await sut.mapGeoFromCep('12345123');
        // assert
        expect(actual, matcher);
      });
      test('should get GeolocationEntity for valid information', () async {
        // arrange
        const jsonFile = 'support_center/support_center_geocode.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = right(GeoLocationModel.fromJson(jsonData));

        when(
          apiProvider.get(
            path: anyNamed('path'),
            headers: anyNamed('headers'),
            parameters: anyNamed('parameters'),
          ),
        ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
        // act
        final matcher = await sut.mapGeoFromCep('12345123');
        // assert
        expect(actual, matcher);
      });
    });
  });
}
