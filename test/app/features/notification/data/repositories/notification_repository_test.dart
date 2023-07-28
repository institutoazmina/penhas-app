// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/notification/data/models/notification_session_model.dart';
import 'package:penhas/app/features/notification/data/repositories/notification_repository.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  late String jsonFile;
  late NotificationRepository sut;
  late MockApiProvider mockApiProvider;

  setUp(() {
    jsonFile = 'notification/notification_session.json';
    mockApiProvider = MockApiProvider();
    sut = NotificationRepository(apiProvider: mockApiProvider);
  });

  group(NotificationRepository, () {
    group(
      'unread()',
      () {
        test(
          'returns valid field on successful call',
          () async {
            // arrange
            final jsonData = await JsonUtil.getString(from: jsonFile);
            final actual = right(ValidField(message: '0'));

            when(() => mockApiProvider.get(path: any(named: 'path')))
                .thenAnswer((_) async => jsonData);
            // act
            final matcher = await sut.unread();
            // assert
            verify(() => mockApiProvider.get(path: '/me/unread-notif-count'))
                .called(1);
            expect(actual, matcher);
          },
        );
        test(
          'map crash to ServerFailure on unsuccessful call',
          () async {
            // arrange
            final actual = left(ServerFailure());
            when(() => mockApiProvider.get(path: any(named: 'path')))
                .thenThrow(Exception());
            // act
            final matcher = await sut.unread();
            // assert
            verify(() => mockApiProvider.get(path: '/me/unread-notif-count'))
                .called(1);
            expect(actual, matcher);
          },
        );
      },
    );

    group('notifications()', () {
      test(
        'returns notification session model on successful',
        () async {
          // arrange
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final actual = right(NotificationSessionModel.fromJson(jsonData));

          when(() => mockApiProvider.get(
                path: any(named: 'path'),
                parameters: any(named: 'parameters'),
              )).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
          // act
          final matcher = await sut.notifications();
          // assert
          verify(() => mockApiProvider.get(
              path: '/me/notifications',
              parameters: any(named: 'parameters'))).called(1);
          expect(actual, matcher);
        },
      );
      test('map crash to ServerFailure on unsuccessful call', () async {
        // arrange
        final actual = left(ServerFailure());
        when(() => mockApiProvider.get(
              path: any(named: 'path'),
              parameters: any(named: 'parameters'),
            )).thenThrow(Exception());
        // act
        final matcher = await sut.notifications();
        // assert
        verify(() => mockApiProvider.get(
            path: '/me/notifications',
            parameters: any(named: 'parameters'))).called(1);
        expect(actual, matcher);
      });
    });
  });
}
