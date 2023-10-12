import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/storage/cache_storage.dart';
import 'package:penhas/app/core/storage/object_store.dart';
import 'package:penhas/app/features/escape_manual/data/datastore/escape_manual_cache_storage.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_remote.dart';

import '../../../../../utils/json_util.dart';
import '../model/escape_manual_fixtures.dart';

void main() {
  late IObjectStore<EscapeManualRemoteModel> sut;

  late ICacheStorage mockCacheStorage;

  final cacheKey = 'escape_manual_cache';

  setUp(() {
    mockCacheStorage = _MockLocalStorage();

    sut = EscapeManualCacheStorage(storage: mockCacheStorage);
  });

  group(EscapeManualCacheStorage, () {
    test(
      'get should call storage.get',
      () async {
        // arrange
        when(() => mockCacheStorage.getString(any()))
            .thenAnswer((_) async => null);

        // act
        await sut.retrieve();

        // assert
        verify(
          () => mockCacheStorage.getString(cacheKey),
        ).called(1);
        verifyNoMoreInteractions(mockCacheStorage);
      },
    );

    test(
      'save should call storage.get',
      () async {
        // arrange
        when(() => mockCacheStorage.getString(any()))
            .thenAnswer((_) async => null);
        when(() => mockCacheStorage.putString(any(), any()))
            .thenAnswer((_) async {});

        // act
        await sut.save(escapeManualRemoteModelFixture);

        // assert
        verify(() => mockCacheStorage.getString(cacheKey)).called(1);
      },
    );

    test(
      'save should call storage.put',
      () async {
        // arrange
        when(() => mockCacheStorage.getString(any()))
            .thenAnswer((_) async => null);
        when(() => mockCacheStorage.putString(any(), any()))
            .thenAnswer((_) async {});

        // act
        await sut.save(escapeManualRemoteModelFixture);

        // assert
        verify(() => mockCacheStorage.putString(cacheKey, any())).called(1);
      },
    );

    test(
      'save should call storage.put with updated data',
      () async {
        // arrange
        final cached = JsonUtil.getStringSync(
          from: 'escape_manual/escape_manual_response.json',
        );
        final expectedSavedData =
            jsonEncode(updatedEscapeManualRemoteModelFixture);

        when(() => mockCacheStorage.getString(any()))
            .thenAnswer((_) async => cached);
        when(() => mockCacheStorage.putString(any(), any()))
            .thenAnswer((_) async {});

        // act
        await sut.save(latestEscapeManualRemoteModelFixture);

        // assert
        final verificationResult = verify(
          () => mockCacheStorage.putString(cacheKey, captureAny()),
        );
        verificationResult.called(1);
        expect(verificationResult.captured.first, equals(expectedSavedData));
      },
    );

    test(
      'save should return updated data',
      () async {
        // arrange
        final cached = JsonUtil.getStringSync(
          from: 'escape_manual/escape_manual_response.json',
        );
        final expectedSavedData = updatedEscapeManualRemoteModelFixture;

        when(() => mockCacheStorage.getString(any()))
            .thenAnswer((_) async => cached);
        when(() => mockCacheStorage.putString(any(), any()))
            .thenAnswer((_) async {});

        // act
        final result = await sut.save(latestEscapeManualRemoteModelFixture);

        // assert
        expect(result, equals(expectedSavedData));
      },
    );

    test(
      'delete should call storage.delete',
      () async {
        // arrange
        when(() => mockCacheStorage.remove(any())).thenAnswer((_) async {});

        // act
        await sut.delete();

        // assert
        verify(() => mockCacheStorage.remove(cacheKey)).called(1);
      },
    );
  });
}

class _MockLocalStorage extends Mock implements ICacheStorage {}
