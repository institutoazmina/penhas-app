// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';
import 'package:penhas/app/features/support_center/data/models/geolocation_model.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_place_detail_model.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

// class MockSupportCenterPlaceEntity extends Mock
// implements SupportCenterPlaceEntity {}

class FakeSupportCenterPlaceEntity extends Fake
    implements SupportCenterPlaceEntity {
  @override
  String get id => '1';
}

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
    group('suggestion', () {
      test('returns AlertModel on success', () async {
        // arrange
        final jsonFile = 'support_center/alert_model_response.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = right(AlertModel.fromJson(jsonData));
        when(() => apiProvider.post(
              path: any(named: 'path'),
              body: any(named: 'body'),
            )).thenAnswer((_) => JsonUtil.getString(from: jsonFile));

        // act
        final result = await sut.suggestion(
          name: 'John',
          email: 'john@example.com',
          address: '123 Street',
          category: 'Category',
          observation: 'Observation',
          cep: '12345',
          coverage: 'Coverage',
          complement: 'Complement',
          neighborhood: 'Neighborhood',
          city: 'City',
          uf: 'UF',
          number: 'Number',
          hour: 'Hour',
          ddd1: 'DDD1',
          phone1: 'Phone1',
          ddd2: 'DDD2',
          phone2: 'Phone2',
          is24h: 'Is24h',
          hasWhatsapp: 'HasWhatsapp',
        );

        // assert
        verify(() => apiProvider.post(
              path: '/me/sugerir-pontos-de-apoio-completo',
              body:
                  'nome=John&categoria=Category&nome_logradouro=123%20Street&observacao=Observation&cep=12345&abrangencia=Coverage&complemento=Complement&bairro=Neighborhood&municipio=City&uf=UF&email=john%40example.com&numero=Number&horario=Hour&ddd1=DDD1&telefone1=Phone1&ddd2=DDD2&telefone2=Phone2&is24h=Is24h&hasWhatsapp=HasWhatsapp',
            )).called(1);
        expect(result, equals(actual));
      });
      test(
        'map Exception to a Failure',
        () async {
          // arrange
          final actual = left(ServerFailure());
          when(() => apiProvider.post(
                path: any(named: 'path'),
                body: any(named: 'body'),
              )).thenThrow(Exception());
          // act
          final matcher = await sut.suggestion(
            name: 'John',
            email: 'john@example.com',
            address: '123 Street',
            category: 'Category',
            observation: 'Observation',
            cep: '12345',
            coverage: 'Coverage',
            complement: 'Complement',
            neighborhood: 'Neighborhood',
            city: 'City',
            uf: 'UF',
            number: 'Number',
            hour: 'Hour',
            ddd1: 'DDD1',
            phone1: 'Phone1',
            ddd2: 'DDD2',
            phone2: 'Phone2',
            is24h: 'Is24h',
            hasWhatsapp: 'HasWhatsapp',
          );
          // assert
          expect(actual, matcher);
        },
      );
    });

    group('detail', () {
      test('returns SupportCenterPlaceDetailEntity on success', () async {
        // arrange
        final jsonFile = 'support_center/support_center_place_detail.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final place = FakeSupportCenterPlaceEntity();
        final actual = right(SupportCenterPlaceDetailModel.fromJson(jsonData));
        when(() => apiProvider.get(path: any(named: 'path')))
            .thenAnswer((_) => JsonUtil.getString(from: jsonFile));
        final matcher = await sut.detail(place);
        // assert
        verify(() => apiProvider.get(path: 'me/pontos-de-apoio/${place.id}'))
            .called(1);
        expect(matcher, equals(actual));
      });
    });
  });
}
