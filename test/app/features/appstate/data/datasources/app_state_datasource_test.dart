import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:penhas/app/features/appstate/domain/entities/update_user_profile_entity.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  late String bodyContent;
  late Uri serverEndpoint;
  late http.Client apiClient;
  late IApiServerConfigure serverConfiguration;
  late IAppStateDataSource sut;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    apiClient = MockHttpClient();
    serverConfiguration = MockApiServerConfigure();
    serverEndpoint = Uri.https('api.anyserver.io', '/');

    sut = AppStateDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfiguration,
    );

    bodyContent =
        JsonUtil.getStringSync(from: 'profile/about_with_quiz_session.json');

    when(() => serverConfiguration.userAgent)
        .thenAnswer((_) async => 'iOS 11.4/Simulator/1.0.0');
    when(() => serverConfiguration.apiToken)
        .thenAnswer((_) async => 'my.very.strong');
    when(() => serverConfiguration.baseUri).thenReturn(serverEndpoint);
  });

  Future<Map<String, String>> _setUpCheckHttpHeader() async {
    final userAgent = await serverConfiguration.userAgent;
    return {
      'User-Agent': userAgent,
      'Content-Type': 'application/json; charset=utf-8',
      'X-Api-Key': 'my.very.strong',
    };
  }

  Future<Map<String, String>> _setUpUpdateHttpHeader() async {
    final userAgent = await serverConfiguration.userAgent;
    return {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
      'X-Api-Key': 'my.very.strong',
    };
  }

  Uri _setupHttpRequest() {
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: '/me',
    );
  }

  void _setUpCheckSuccessResponse() {
    when(() => apiClient.get(any(), headers: any(named: 'headers'))).thenAnswer(
      (_) async => http.Response(
        bodyContent,
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
  }

  void _setUpUpdateSuccessResponse() {
    when(() => apiClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer(
      (_) async => http.Response(
        bodyContent,
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
  }

  void _setUpCheckFailureResponse({required int code}) {
    when(() => apiClient.get(any(), headers: any(named: 'headers'))).thenAnswer(
      (_) async => http.Response(
        '{"status": $code, "error":"Some error message"}',
        code,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
  }

  void _setUpUpdateFailureResponse({required int code}) {
    when(() => apiClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer(
      (_) async => http.Response(
        '{"status": $code, "error":"Some error message"}',
        code,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
  }

  group(AppStateDataSource, () {
    group('check()', () {
      test(
        'perform a GET with X-API-Key and application/json header ',
        () async {
          // arrange
          final headers = await _setUpCheckHttpHeader();
          final stateUri = _setupHttpRequest();
          _setUpCheckSuccessResponse();
          // act
          await sut.check();
          // assert
          verify(() => apiClient.get(stateUri, headers: headers)).called(1);
        },
      );

      test('get ApiProviderSessionError for invalid session', () {
        // arrange
        final sessionHttpCodeError = [401, 403];
        for (final httpCode in sessionHttpCodeError) {
          _setUpCheckFailureResponse(code: httpCode);
          // act
          expect(
            () async => await sut.check(),
            throwsA(isA<ApiProviderSessionError>()),
          );
        }
      });

      test('get ApiProviderException for http code error not mapped', () {
        // arrange
        _setUpCheckFailureResponse(code: 503);
        // act
        expect(
          () async => await sut.check(),
          throwsA(isA<ApiProviderException>()),
        );
      });
    });

    group('update()', () {
      test(
        'perform a PUT with X-API-Key and application/x-www-form-urlencoded; charset=utf-8',
        () async {
          // arrange
          final headers = await _setUpUpdateHttpHeader();
          final stateUri = _setupHttpRequest();
          final profile = UpdateUserProfileEntity(
            nickName: 'foo',
            email: 'foo@foo.com',
            newPassword: 'strong_password',
            oldPassword: 'old-password',
            race: 'foo',
            skills: ['asd', 'zxc'],
            minibio: 'minha mini bio',
          );
          _setUpUpdateSuccessResponse();
          // act
          await sut.update(profile);
          // assert
          verify(
            () => apiClient.put(
              stateUri,
              headers: headers,
              body:
                  'apelido=foo&minibio=minha%20mini%20bio&raca=foo&skills=asd%2Czxc&senha_atual=old-password&senha=strong_password&email=foo%40foo.com',
              encoding: null,
            ),
          ).called(1);
        },
      );

      test('get ApiProviderSessionError for invalid session', () async {
        // arrange
        final sessionHttpCodeError = [401, 403];
        final profile = UpdateUserProfileEntity();
        for (final httpCode in sessionHttpCodeError) {
          _setUpUpdateFailureResponse(code: httpCode);
          // act
          expect(
            () async => await sut.update(profile),
            throwsA(isA<ApiProviderSessionError>()),
          );
        }
      });

      test('get ApiProviderException for invalid session', () async {
        // arrange
        final profile = UpdateUserProfileEntity();
        _setUpUpdateFailureResponse(code: 503);
        // act
        expect(
          () async => await sut.update(profile),
          throwsA(isA<ApiProviderException>()),
        );
      });
    });
  });
}
