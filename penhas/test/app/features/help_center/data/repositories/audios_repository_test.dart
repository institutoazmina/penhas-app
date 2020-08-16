import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/help_center/data/models/audio_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/audios_repository.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  IAudiosRepository sut;
  IApiProvider apiProvider;
  IApiServerConfigure apiServerConfigure;
  String serverEndpoint;
  String apiKey;

  setUpAll(
    () {
      apiProvider = MockApiProvider();
      apiServerConfigure = MockApiServerConfigure();
      apiKey = 'my_really.long.JWT';
      serverEndpoint = 'api.anyserver.io';

      sut = AudiosRepository(
        apiProvider: apiProvider,
        serverConfiguration: apiServerConfigure,
      );

      when(apiServerConfigure.baseUri)
          .thenAnswer((_) => Uri.https(serverEndpoint, '/'));
      when(apiServerConfigure.apiToken).thenAnswer((_) => Future.value(apiKey));
    },
  );

  group('Audios', () {
    test('should fetch available audio when available on server', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: 'audios/audios_fetch.json');
      when(
        apiProvider.get(
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: 'audios/audios_fetch.json'));

      final baseUri = Uri.https(
        serverEndpoint,
        '/me/audios/',
        {'api_key': apiKey},
      );
      final actual = AudioModel.fromJson(jsonData, baseUri);
      // act
      // unwrap do Either pq ele não se dá bem com o Collection nativo,
      // eu teria que alterar para um List dele, mas me recurso a fazer isto
      // só para o teste, já que na códgio terá outras implicações.
      final matcher = await sut.fetch().then((v) => v.getOrElse(() => null));
      // assert
      expect(actual, matcher);
    });
  });
}
