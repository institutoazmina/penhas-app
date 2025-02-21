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
    // Mock o request para 'sinalizar' o encoding corretamente
    // que será utilizado para decodificar o corpo da resposta
    // Sem esta etapa o Response não codifica corretamente o corpo
    // com emojis
    final request = Request('POST', Uri.parse('https://example.com/api/data'))
      ..headers['Content-Type'] = 'text/html; charset=utf-8';

    final response = Response(
      body,
      statusCode,
      headers: request.headers,
      request: request,
    );

    // mock the streamed response
    final streamedResponse = StreamedResponse(
      ByteStream.fromBytes(response.bodyBytes),
      response.statusCode,
      headers: response.headers,
      request: response.request,
      reasonPhrase: response.reasonPhrase,
    );

    when(() => httpClient.send(any()))
        .thenAnswer((_) async => streamedResponse);
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
