import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_available_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_open_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_session_model.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_request.dart';
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
    group('listChannel()', () {
      test(
        'with empty channel list do not crash',
        () async {
          // arrange
          const jsonFile = 'chat/chat_list_channel_empty.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final expected = right(ChatChannelAvailableModel.fromJson(jsonData));
          when(
            () => apiProvider.get(
              path: '/me/chats',
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
          // act
          final actual = await sut.listChannel();
          // assert
          expect(actual, expected);
        },
      );
      test(
        'return ChatChannelAvailableEntity when the call is successful',
        () async {
          // arrange
          const jsonFile = 'chat/chat_list_channel.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final expected = right(ChatChannelAvailableModel.fromJson(jsonData));
          when(
            () => apiProvider.get(
              path: any(named: 'path'),
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
          // act
          final actual = await sut.listChannel();
          // assert
          expect(actual, expected);
        },
      );

      test(
        'return a failure when the call fails',
        () async {
          // arrange
          when(
            () => apiProvider.get(
              path: any(named: 'path'),
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(InternetConnectionException());
          // act
          final actual = await sut.listChannel();
          // assert
          expect(actual, equals(left(InternetConnectionFailure())));
        },
      );
    });

    group('openChannel()', () {
      const clientId = 'client_id';
      test(
        'return ChatChannelOpenEntity on success',
        () async {
          // arrange
          const jsonFile = 'chat/chat_open_channel.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final expected = right(ChatChannelOpenModel.fromJson(jsonData));
          when(
            () => apiProvider.post(
              path: '/me/chats-session',
              headers: any(named: 'headers'),
              parameters: {'prefetch': '1', 'cliente_id': clientId},
            ),
          ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
          // act
          final actual = await sut.openChannel(clientId);
          // assert
          expect(actual, expected);
        },
      );

      test(
        'return failure on api error',
        () async {
          // arrange
          when(() => apiProvider.post(
                path: '/me/chats-session',
                parameters: {'prefetch': '1', 'cliente_id': clientId},
              )).thenThrow(NetworkServerException());
          // act
          final actual = await sut.openChannel(clientId);
          // assert
          expect(actual, left(ServerFailure()));
        },
      );
    });

    group('getMessages()', () {
      test(
        'get empty messages without crash app',
        () async {
          // arrange
          const jsonFile = 'chat/chat_read_channel_empty.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final expected = right(ChatChannelSessionModel.fromJson(jsonData));
          when(
            () => apiProvider.get(
              path: '/me/chats-messages',
              headers: any(named: 'headers'),
              parameters: {
                'chat_auth': 'my_strong_token',
                'pagination': null,
                'rows': '20'
              },
            ),
          ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
          // act
          final actual = await sut.getMessages(ChatChannelRequest(
            token: 'my_strong_token',
            rows: 20,
          ));
          // assert
          expect(actual, expected);
        },
      );

      test(
        'return a ChatChannelSessionEntity on successful',
        () async {
          // arrange
          const jsonFile = 'chat/chat_read_channel.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final expected = right(ChatChannelSessionModel.fromJson(jsonData));
          when(
            () => apiProvider.get(
              path: '/me/chats-messages',
              headers: any(named: 'headers'),
              parameters: {
                'chat_auth': 'my_strong_token',
                'pagination': null,
                'rows': '20'
              },
            ),
          ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));

          // act
          final actual = await sut.getMessages(ChatChannelRequest(
            token: 'my_strong_token',
            rows: 20,
          ));

          // assert
          expect(actual, expected);
        },
      );

      test(
        'return a Failure when the call is unsuccessful',
        () async {
          // arrange
          when(
            () => apiProvider.get(
              path: any(named: 'path'),
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(InternetConnectionException());
          // act
          final actual = await sut.getMessages(ChatChannelRequest(
            token: 'my_strong_token',
            rows: 20,
          ));
          // assert
          expect(actual, equals(left(InternetConnectionFailure())));
        },
      );
    });
  });
}

class MockApiProvider extends Mock implements IApiProvider {}
