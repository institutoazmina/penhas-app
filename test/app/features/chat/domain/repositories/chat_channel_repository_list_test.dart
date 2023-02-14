import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_available_model.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';

import '../../../../../utils/json_util.dart';

void main() {
  late IApiProvider apiProvider;
  late IChatChannelRepository sut;

  setUp(() {
    apiProvider = MockApiProvider();
    sut = ChatChannelRepository(apiProvider: apiProvider);
  });

  group(ChatChannelRepository, () {
    test(
      'should list empty open channel',
      () async {
        // arrange
        const jsonFile = 'chat/chat_list_channel_empty.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = right(ChatChannelAvailableModel.fromJson(jsonData));
        when(
          () => apiProvider.get(
            path: any(named: 'path'),
            headers: any(named: 'headers'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
        // act
        final matcher = await sut.listChannel();
        // assert
        expect(actual, matcher);
      },
    );
    test(
      'should list open channel',
      () async {
        // arrange
        const jsonFile = 'chat/chat_list_channel.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = right(ChatChannelAvailableModel.fromJson(jsonData));
        when(
          () => apiProvider.get(
            path: any(named: 'path'),
            headers: any(named: 'headers'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
        // act
        final matcher = await sut.listChannel();
        // assert
        expect(actual, matcher);
      },
    );
  });
}

class MockApiProvider extends Mock implements IApiProvider {}
