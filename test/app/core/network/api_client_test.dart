import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';

class MockFile extends Mock implements File {}

class MockClient extends Mock implements http.Client {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  late MockFile mockFile;
  late http.Client apiClient;
  late INetworkInfo networkInfo;
  late IApiServerConfigure serverConfiguration;
  final baseUri = Uri.parse('https://api.example.com/api');

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockFile = MockFile();
    apiClient = MockClient();
    networkInfo = MockNetworkInfo();
    serverConfiguration = MockApiServerConfigure();

    when(() => serverConfiguration.baseUri).thenReturn(baseUri);
    when(() => serverConfiguration.apiToken)
        .thenAnswer((_) async => 'my_strong_token');
    when(() => serverConfiguration.userAgent)
        .thenAnswer((_) async => 'Custom/User/Agent');
  });

  group(ApiProvider, () {
    test('must configure uri and header correct', () async {
      // arrange
      const String path = 'some_path';
      final headers = <String, String>{'key1': 'value1'};
      final parameters = <String, String>{'param1': 'value1'};
      final response = http.Response('{"key": "value"}', 200);
      final expectUri = baseUri.replace(
        path: path,
        queryParameters: parameters,
      );
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);
      when(() => apiClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => response);

      final sut = ApiProvider(
        serverConfiguration: serverConfiguration,
        networkInfo: networkInfo,
        apiClient: apiClient,
      );
      // act
      await sut.get(path: path, headers: headers, parameters: parameters);
      final captured = verify(() => apiClient.get(captureAny(),
          headers: captureAny(named: 'headers'))).captured;
      // assert
      expect(
        captured.first,
        expectUri,
        reason: 'Concatenate path successfully',
      );

      // Verify request header builder
      final capturedHeader = captured[1] as Map<String, String>;
      expect(
        capturedHeader,
        containsPair('X-Api-Key', 'my_strong_token'),
        reason: 'Session session token',
      );
      expect(
        capturedHeader,
        containsPair('User-Agent', 'Custom/User/Agent'),
        reason: 'Custom user agent',
      );
      expect(
        capturedHeader,
        containsPair(
            'Content-Type', 'application/x-www-form-urlencoded; charset=utf-8'),
      );
      expect(
        capturedHeader,
        containsPair('key1', 'value1'),
        reason: 'Custom property',
      );
    });
    test('map correct exception from http code', () async {
      final errors = {
        401: throwsA(isA<ApiProviderSessionError>()),
        404: throwsA(isA<ApiProviderException>()),
        501: throwsA(isA<NetworkServerException>()),
      };
      errors.forEach((httpCode, expected) {
        // arrange
        const String path = 'some_path';
        final localApiClient = MockClient();
        final response = http.Response('{"key": "value"}', httpCode);
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);

        when(() => localApiClient.get(
              any(),
              headers: any(named: 'headers'),
            )).thenAnswer((_) async => response);

        final sut = ApiProvider(
          serverConfiguration: serverConfiguration,
          networkInfo: networkInfo,
          apiClient: localApiClient,
        );
        // act
        expect(
          () async => await sut.get(path: path),
          expected,
        );
      });
    });
    test('propagates crash from http.Client', () async {
      // arrange
      const String path = 'some_path';
      final localApiClient = MockClient();
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);

      when(() => localApiClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenThrow(Exception());

      final sut = ApiProvider(
        serverConfiguration: serverConfiguration,
        networkInfo: networkInfo,
        apiClient: localApiClient,
      );
      // act
      expect(
        () async => await sut.get(path: path),
        throwsA(isA<Exception>()),
      );
    });

    group('get', () {
      test(
        'return the response body',
        () async {
          // arrange
          const String path = 'some_path';
          final headers = <String, String>{'key1': 'value1'};
          final parameters = <String, String>{'param1': 'value1'};
          const expected = '{"key": "value"}';
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);
          when(() => apiClient.get(
                any(),
                headers: any(named: 'headers'),
              )).thenAnswer((_) async => http.Response(expected, 200));

          final sut = ApiProvider(
            serverConfiguration: serverConfiguration,
            networkInfo: networkInfo,
            apiClient: apiClient,
          );
          // act
          final actual = await sut.get(
            path: path,
            headers: headers,
            parameters: parameters,
          );
          // assert
          expect(actual, expected);
        },
      );
    });

    group('post', () {
      test('return response', () async {
        // arrange
        const String path = 'some_path';
        final headers = <String, String>{'key1': 'value1'};
        final parameters = <String, String>{'param1': 'value1'};
        const expected = '{"key": "value"}';
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        when(() => apiClient.post(
              any(),
              headers: any(named: 'headers'),
            )).thenAnswer((_) async => http.Response(expected, 200));

        final sut = ApiProvider(
          serverConfiguration: serverConfiguration,
          networkInfo: networkInfo,
          apiClient: apiClient,
        );
        // act
        final actual = await sut.post(
          path: path,
          headers: headers,
          parameters: parameters,
        );
        // assert
        expect(actual, expected);
      });
    });

    group('delete', () {
      test('return response', () async {
        // arrange
        const String path = 'some_path';
        final parameters = <String, String>{'param1': 'value1'};
        const expected = '{}';
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        when(() => apiClient.delete(
              any(),
              headers: any(named: 'headers'),
            )).thenAnswer((_) async => http.Response(expected, 200));

        final sut = ApiProvider(
          serverConfiguration: serverConfiguration,
          networkInfo: networkInfo,
          apiClient: apiClient,
        );
        // act
        final actual = await sut.delete(
          path: path,
          parameters: parameters,
        );
        // assert
        expect(actual, expected);
      });
    });

    group('download', () {
      const path = 'https://api.example.com/file.png';
      const fileContent = 'Example file content';
      test('downloads a file from a URL', () async {
        // arrange
        when(() => apiClient.get(any(), headers: any(named: 'headers')))
            .thenAnswer((_) async => http.Response(fileContent, 200));

        when(() => mockFile.writeAsBytesSync(any()))
            .thenAnswer((_) async => Future.value());

        final sut = ApiProvider(
          serverConfiguration: serverConfiguration,
          networkInfo: networkInfo,
          apiClient: apiClient,
        );
        // action
        final result = await sut.download(
          path: path,
          file: mockFile,
        );
        // assert
        expect(result, '{"message": "Ok"}');
        verify(() => mockFile.writeAsBytesSync(utf8.encode(fileContent)))
            .called(1);
      });
    });
  });
}
