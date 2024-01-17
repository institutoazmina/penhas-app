import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/storage/object_store.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/escape_manual/data/datasource/impl/escape_manual_remote_datasource.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_remote.dart';

import '../../../../../../utils/json_util.dart';
import '../../model/escape_manual_fixtures.dart';

void main() {
  late IEscapeManualRemoteDatasource sut;

  late IApiProvider mockApiProvider;
  late IObjectStore<EscapeManualRemoteModel> mockCacheStorage;

  setUpAll(() {
    registerFallbackValue(_FakeEscapeManualRemoteModel());
  });

  setUp(() {
    mockApiProvider = _MockApiProvider();
    mockCacheStorage = _MockEscapeManualStorage();

    sut = EscapeManualRemoteDatasource(
      apiProvider: mockApiProvider,
      cacheStorage: mockCacheStorage,
    );
  });

  group(EscapeManualRemoteDatasource, () {
    group('start', () {
      test(
        'should call apiProvider post',
        () async {
          // arrange
          final response = JsonUtil.getStringSync(
            from: 'escape_manual/quiz_session_response.json',
          );
          when(
            () => mockApiProvider.post(
              path: any(named: 'path'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) async => response);

          // act
          await sut.start('MF1234');

          // assert
          verify(
            () => mockApiProvider.post(
              path: '/me/quiz',
              parameters: {'session_id': 'MF1234'},
            ),
          ).called(1);
          verifyNoMoreInteractions(mockApiProvider);
        },
      );

      test(
        'should return apiProvider post',
        () async {
          // arrange
          final response = JsonUtil.getStringSync(
            from: 'escape_manual/quiz_session_response.json',
          );
          const expectedQuiz = QuizSessionModel(sessionId: 'session_id');
          when(
            () => mockApiProvider.post(
              path: any(named: 'path'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) async => response);

          // act
          final result = await sut.start('MF1234');

          // assert
          expect(result, expectedQuiz);
        },
      );

      test(
        'should throws a exception when apiProvider post throws',
        () async {
          // arrange
          when(
            () => mockApiProvider.post(
              path: any(named: 'path'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(Exception());

          // act // assert
          expectLater(
            () async => sut.start('MF1234'),
            throwsA(isA<Exception>()),
          );
        },
      );
    });

    group('fetch', () {
      setUp(() {
        when(() => mockCacheStorage.save(any()))
            .thenAnswer((_) async => Future.value());
      });

      group('given empty cache', () {
        setUp(() {
          when(() => mockCacheStorage.retrieve()).thenAnswer((_) async => null);
        });

        test(
          'should call apiProvider get',
          () async {
            // arrange
            final response = JsonUtil.getStringSync(
              from: 'escape_manual/escape_manual_response.json',
            );
            when(
              () => mockApiProvider.get(
                path: any(named: 'path'),
                parameters: any(named: 'parameters'),
              ),
            ).thenAnswer((_) async => response);

            // act
            await sut.fetch();

            // assert
            verify(
              () => mockApiProvider.get(
                path: '/me/tarefas',
                parameters: {
                  'modificado_apos': '0',
                },
              ),
            ).called(1);
            verifyNoMoreInteractions(mockApiProvider);
          },
        );

        test(
          'should call cacheStorage',
          () async {
            // arrange
            final response = JsonUtil.getStringSync(
              from: 'escape_manual/escape_manual_response.json',
            );
            final expectedCachedData =
                EscapeManualRemoteModel.fromJson(jsonDecode(response));
            when(
              () => mockApiProvider.get(
                path: any(named: 'path'),
                parameters: any(named: 'parameters'),
              ),
            ).thenAnswer((_) async => response);

            // act
            await sut.fetch();

            // assert
            verify(() => mockCacheStorage.save(expectedCachedData)).called(1);
            verify(() => mockCacheStorage.retrieve()).called(1);

            verifyNoMoreInteractions(mockCacheStorage);
          },
        );

        test(
          'should return apiProvider get',
          () async {
            // arrange
            final response = JsonUtil.getStringSync(
              from: 'escape_manual/escape_manual_response.json',
            );
            final expectedEscapeManual = escapeManualRemoteModelFixture;

            when(
              () => mockApiProvider.get(
                path: any(named: 'path'),
                parameters: any(named: 'parameters'),
              ),
            ).thenAnswer((_) async => response);

            // act
            final result = await sut.fetch();

            // assert
            expect(result, equals(expectedEscapeManual));
          },
        );

        test(
          'should throws a failure when apiProvider get throws',
          () async {
            // arrange
            when(
              () => mockApiProvider.get(
                path: any(named: 'path'),
                parameters: any(named: 'parameters'),
              ),
            ).thenThrow(Exception());

            // act // assert
            expectLater(
              sut.fetch,
              throwsA(isA<Exception>()),
            );
          },
        );
      });

      group('given not empty cache', () {
        test(
          'should call apiProvider get',
          () async {
            // arrange
            final response = JsonUtil.getStringSync(
              from: 'escape_manual/escape_manual_response.json',
            );
            final cachedData =
                EscapeManualRemoteModel.fromJson(jsonDecode(response));
            const expectedLastModifiedAt = 1699916213;

            when(() => mockCacheStorage.retrieve())
                .thenAnswer((_) async => cachedData);
            when(
              () => mockApiProvider.get(
                path: any(named: 'path'),
                parameters: any(named: 'parameters'),
              ),
            ).thenAnswer((_) async => response);

            // act
            await sut.fetch();

            // assert
            verify(
              () => mockApiProvider.get(
                path: '/me/tarefas',
                parameters: {
                  'modificado_apos': '$expectedLastModifiedAt',
                },
              ),
            ).called(1);
            verifyNoMoreInteractions(mockApiProvider);
          },
        );

        test(
          'should return updated cache',
          () async {
            // arrange
            final response = JsonUtil.getStringSync(
              from: 'escape_manual/escape_manual_latest_response.json',
            );

            final expectedEscapeManual = updatedEscapeManualRemoteModelFixture;

            when(() => mockCacheStorage.retrieve())
                .thenAnswer((_) async => escapeManualRemoteModelFixture);

            when(
              () => mockApiProvider.get(
                path: any(named: 'path'),
                parameters: any(named: 'parameters'),
              ),
            ).thenAnswer((_) async => response);

            // act
            final result = await sut.fetch();

            // assert
            expect(result, equals(expectedEscapeManual));
          },
        );

        test(
          'should save updated cache',
          () async {
            // arrange
            final response = JsonUtil.getStringSync(
              from: 'escape_manual/escape_manual_latest_response.json',
            );

            final expectedEscapeManual = updatedEscapeManualRemoteModelFixture;

            when(() => mockCacheStorage.retrieve())
                .thenAnswer((_) async => escapeManualRemoteModelFixture);

            when(
              () => mockApiProvider.get(
                path: any(named: 'path'),
                parameters: any(named: 'parameters'),
              ),
            ).thenAnswer((_) async => response);

            // act
            await sut.fetch();

            // assert
            verify(() => mockCacheStorage.save(expectedEscapeManual)).called(1);
          },
        );

        test(
          'should return cached data when apiProvider get throws',
          () async {
            // arrange
            final expectedEscapeManual = escapeManualRemoteModelFixture;
            when(() => mockCacheStorage.retrieve())
                .thenAnswer((_) async => escapeManualRemoteModelFixture);
            when(
              () => mockApiProvider.get(
                path: any(named: 'path'),
                parameters: any(named: 'parameters'),
              ),
            ).thenThrow(Exception());

            // act
            final result = await sut.fetch();

            // assert
            expect(result, equals(expectedEscapeManual));
          },
        );
      });
    });
  });
}

class _MockApiProvider extends Mock implements IApiProvider {}

class _MockEscapeManualStorage extends Mock
    implements IObjectStore<EscapeManualRemoteModel> {}

class _FakeEscapeManualRemoteModel extends Fake
    implements EscapeManualRemoteModel {}
