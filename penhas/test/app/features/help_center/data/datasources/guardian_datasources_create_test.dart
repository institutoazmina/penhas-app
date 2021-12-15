import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late final MockHttpClient apiClient = MockHttpClient();
  late final MockIApiServerConfigure serverConfigure = MockIApiServerConfigure();
  late IGuardianDataSource dataSource;
  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');
  const String SESSSION_TOKEN = 'my_really.long.JWT';

  setUp(() {
    dataSource = GuardianDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfigure,
    );

    // MockApiServerConfigure configuration
    when(serverConfigure.baseUri).thenAnswer((_) => serverEndpoint);
    when(serverConfigure.apiToken)
        .thenAnswer((_) => Future.value(SESSSION_TOKEN));
    when(serverConfigure.userAgent)
        .thenAnswer((_) => Future.value('iOS 11.4/Simulator/1.0.0'));
  });

  Future<Map<String, String>> _setUpHttpHeader() async {
    final userAgent = await serverConfigure.userAgent;
    return {
      'X-Api-Key': SESSSION_TOKEN,
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    };
  }

  Uri _setuHttpRequest(String path, Map<String, String?> queryParameters) {
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }

  PostExpectation<Future<http.Response>> _mockPostRequest() {
    return when(apiClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    ),);
  }

  void _setUpMockPostHttpClientSuccess200(String? bodyContent) {
    _mockPostRequest().thenAnswer(
      (_) async => http.Response(
        bodyContent!,
        200,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
      ),
    );
  }

  group(
    'GuardianDataSource',
    () {
      String? bodyContent;
      GuardianContactEntity? guardian;

      setUp(() {
        bodyContent = JsonUtil.getStringSync(
            from: 'help_center/guardian_create_successful.json',);
        guardian = GuardianContactEntity.createRequest(
          name: 'Maria',
          mobile: '1191910101',
        );
      });

      group('create()', () {
        test(
          'should perform a POST with X-API-Key',
          () async {
            // arrange
            const endPointPath = '/me/guardioes';
            final headers = await _setUpHttpHeader();
            final request = _setuHttpRequest(endPointPath, {
              'nome': guardian!.name,
              'celular': guardian!.mobile,
            });
            _setUpMockPostHttpClientSuccess200(bodyContent);
            // act
            await dataSource.create(guardian);
            // assert
            verify(apiClient.post(request, headers: headers));
          },
        );
        test(
          'should get a valid ValidField for a successful request',
          () async {
            // arrange
            _setUpMockPostHttpClientSuccess200(bodyContent);
            final jsonData = await JsonUtil.getJson(
                from: 'help_center/guardian_create_successful.json',);
            final expected = AlertModel.fromJson(jsonData);
            // act
            final received = await dataSource.create(guardian);
            // assert
            expect(received, expected);
          },
        );
      });
    },
  );
}
