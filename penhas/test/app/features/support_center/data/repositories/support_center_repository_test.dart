import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/support_center/data/models/geolocation_model.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  IApiProvider apiProvider;
  ISupportCenterRepository sut;

  setUp(() {
    apiProvider = MockApiProvider();
    sut = SupportCenterRepository(apiProvider: apiProvider);
  });

  group('SupportCenterRepository', () {
    test('metadata should return valid objects from server', () async {
      // arrange
      final jsonFile = "support_center/support_center_meta_data.json";
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
        final jsonFile = "support_center/support_center_no_gps.json";
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = left(GpsFailure(jsonData["message"] as String));

        when(
          apiProvider.get(
            path: anyNamed('path'),
            headers: anyNamed('headers'),
            parameters: anyNamed('parameters'),
          ),
        ).thenThrow(ApiProviderException(bodyContent: jsonData));
        // act
        final matcher = await sut.fetch();
        // assert
        expect(actual, matcher);
      });
    });
    group('mapGeoFromCep', () {
      test('should get AddressFailure for invalid address information',
          () async {
        // arrange
        final jsonFile = "support_center/support_center_geocode_error.json";
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = left(AddressFailure(jsonData["message"] as String));

        when(
          apiProvider.get(
            path: anyNamed('path'),
            headers: anyNamed('headers'),
            parameters: anyNamed('parameters'),
          ),
        ).thenThrow(ApiProviderException(bodyContent: jsonData));
        // act
        final matcher = await sut.mapGeoFromCep("12345123");
        // assert
        expect(actual, matcher);
      });
      test('should get GeolocationEntity for valid information', () async {
        // arrange
        final jsonFile = "support_center/support_center_geocode.json";
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
        final matcher = await sut.mapGeoFromCep("12345123");
        // assert
        expect(actual, matcher);
      });
    });
  });
}
