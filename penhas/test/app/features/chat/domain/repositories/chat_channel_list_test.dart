import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_available_model.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  IApiProvider apiProvider;
  IChatChannelRepository sut;

  setUp(() {
    apiProvider = MockApiProvider();
    sut = ChatChannelRepository(apiProvider: apiProvider);
  });

  group('ChatChannel', () {
    test('should list empty open channel', () async {
      // arrange
      final jsonFile = "chat/chat_list_channel_empty.json";
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = right(ChatChannelAvailableModel.fromJson(jsonData));
      when(
        apiProvider.get(
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      final matcher = await sut.listChannel();
      // assert
      expect(actual, matcher);
    });
    test('should list open channel', () async {
      // arrange
      final jsonFile = "chat/chat_list_channel.json";
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = right(ChatChannelAvailableModel.fromJson(jsonData));
      when(
        apiProvider.get(
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      final matcher = await sut.listChannel();
      // assert
      expect(actual, matcher);
    });
  });
}
