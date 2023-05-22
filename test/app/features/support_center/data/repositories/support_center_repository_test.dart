// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/support_center/data/models/geolocation_model.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  late IApiProvider apiProvider;
  late ISupportCenterRepository sut;
  late SupportCenterFetchRequest fetchRequest;

  setUpAll(
    () {
      apiProvider = MockApiProvider();

      sut = SupportCenterRepository(apiProvider: apiProvider);
      fetchRequest = SupportCenterFetchRequest();
    },
  );

  group(SupportCenterRepository, () {
    group('metadata', () {
      test(
        'return valid objects from server',
        () async {
          // arrange
          const jsonFile = 'support_center/support_center_meta_data.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final actual = right(SupportCenterMetadataModel.fromJson(jsonData));
          when(
            () => apiProvider.get(
              path: any(named: 'path'),
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
          // act
          final matcher = await sut.metadata();
          // assert
          expect(actual, matcher);
        },
      );
      test(
        'map Exception to a Failure',
        () async {
          // arrange
          final actual = left(ServerFailure());
          when(
            () => apiProvider.get(
              path: any(named: 'path'),
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(Exception());
          // act
          final matcher = await sut.metadata();
          // assert
          expect(actual, matcher);
        },
      );
    });
    group('fetch', () {
      test(
        'get GpsFailure for invalid gps information',
        () async {
          // arrange
          const jsonFile = 'support_center/support_center_no_gps.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final actual = left(GpsFailure(jsonData['message'] as String?));

          when(
            () => apiProvider.get(
              path: any(named: 'path'),
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(ApiProviderException(bodyContent: jsonData));
          // act
          final matcher = await sut.fetch(fetchRequest);
          // assert
          expect(actual, matcher);
        },
      );

      test(
        'check the default parameters for a empty SupportCenterFetchRequest class',
        () async {
          // arrange
          const jsonFile = 'support_center/support_center_list_of_place.json';
          final defaultParameters = <String, String?>{
            'keywords': null,
            'next_page': null,
            'projeto': 'Penhas',
            'full_list': '1'
          };
          when(
            () => apiProvider.get(
              path: any(named: 'path'),
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
          // act
          await sut.fetch(fetchRequest);
          // assert
          verify(() => apiProvider.get(
              path: 'me/pontos-de-apoio',
              headers: any(named: 'headers'),
              parameters: defaultParameters));
        },
      );

      test(
        'build request with SupportCenterFetchRequest parameters',
        () async {
          // arrange
          const jsonFile = 'support_center/support_center_list_of_place.json';
          final defaultParameters = <String, String?>{
            'latitude': '42.4242',
            'longitude': '-42.4242',
            'categorias': 'a,b',
            'keywords': 'keyword',
            'next_page': '2',
            'projeto': 'Penhas',
            'full_list': '1'
          };
          when(
            () => apiProvider.get(
              path: any(named: 'path'),
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
          // act
          await sut.fetch(SupportCenterFetchRequest(
            userLocation: UserLocationEntity(
              latitude: 42.4242,
              longitude: -42.4242,
            ),
            // locationToken: 'token',
            categories: ['a', 'b'],
            keywords: 'keyword',
            nextPage: '2',
          ));
          // assert
          verify(() => apiProvider.get(
              path: 'me/pontos-de-apoio',
              headers: any(named: 'headers'),
              parameters: defaultParameters));
        },
      );
      test('build request with request parameters', () {});
    });
    group('mapGeoFromCep', () {
      test(
        'should get AddressFailure for invalid address information',
        () async {
          // arrange
          const jsonFile = 'support_center/support_center_geocode_error.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final actual = left(AddressFailure(jsonData['message'] as String?));

          when(
            () => apiProvider.get(
              path: any(named: 'path'),
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(ApiProviderException(bodyContent: jsonData));
          // act
          final matcher = await sut.mapGeoFromCep('12345123');
          // assert
          expect(actual, matcher);
        },
      );
      test(
        'should get GeolocationEntity for valid information',
        () async {
          // arrange
          const jsonFile = 'support_center/support_center_geocode.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final actual = right(GeoLocationModel.fromJson(jsonData));

          when(
            () => apiProvider.get(
              path: any(named: 'path'),
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
          // act
          final matcher = await sut.mapGeoFromCep('12345123');
          // assert
          expect(actual, matcher);
        },
      );
    });
  });
}
