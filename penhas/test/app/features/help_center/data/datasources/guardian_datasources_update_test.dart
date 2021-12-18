import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/features/help_center/data/datasources/guardian_data_source.dart';
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

  PostExpectation<Future<http.Response>> _mockPutRequest() {
    return when(apiClient.put(
      any,
      headers: anyNamed('headers'),
    ),);
  }

  void _setUpMockPutHttpClientSuccess200(String? bodyContent) {
    _mockPutRequest().thenAnswer(
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
            from: 'help_center/guardian_update_name.json',);
        guardian = const GuardianContactEntity(
          id: 1,
          name: 'Maria',
          mobile: '1191910101',
          status: 'pending',
        );
      });
      group('create()', () {
        test(
          'should perform a PUT with X-API-Key',
          () async {
            // arrange
            final endPointPath = '/me/guardioes/${guardian!.id}';
            final headers = await _setUpHttpHeader();
            final request = _setuHttpRequest(endPointPath, {
              'nome': guardian!.name,
            });
            _setUpMockPutHttpClientSuccess200(bodyContent);
            // act
            await dataSource.update(guardian);
            // assert
            verify(apiClient.put(request, headers: headers));
          },
        );
        test(
          'should get a valid ValidField for a successful request',
          () async {
            // arrange
            _setUpMockPutHttpClientSuccess200(bodyContent);
            final jsonData = await JsonUtil.getJson(
                from: 'help_center/guardian_update_name.json',);
            final expected = ValidField.fromJson(jsonData);
            // act
            final received = await dataSource.update(guardian);
            // assert
            expect(expected, received);
          },
        );
      });
    },
  );
}
