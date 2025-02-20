import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';

class ApiProviderMock {
  static late IApiProvider apiProvider;
  static late MockHttpClient httpClient;
  static late MockApiServerConfigure serverConfigure;

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    httpClient = MockHttpClient();
    serverConfigure = MockApiServerConfigure();

    apiProvider = ApiProvider(
      serverConfiguration: serverConfigure,
      apiClient: httpClient,
    );
  }

  static void _initFallbacks() {
    registerFallbackValue(Uri());
    registerFallbackValue(BaseRequestFake());
  }

  static void apiClientResponse(String body, int statusCode) {
    final stream = Stream.value(body.codeUnits);
    when(() => httpClient.send(any())).thenAnswer(
      (_) async => StreamedResponse(
        stream,
        statusCode,
      ),
    );
  }

  static Map<String, String> apiClientCapturedRequest() {
    final captured =
        verify(() => ApiProviderMock.httpClient.send(captureAny())).captured;
    final request = captured.first as Request;
    final Map<String, String> requestDetails = {
      'method': request.method,
      'path': request.url.path,
      'queryParameters': request.url.queryParameters.toString(),
      'body': request.body,
    };

    return requestDetails;
  }
}

class BaseRequestFake extends Fake implements BaseRequest {}

class MockHttpClient extends Mock implements Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}
