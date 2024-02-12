import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/storage/cache_storage.dart';
import 'package:penhas/app/core/storage/object_store.dart';
import 'package:penhas/app/core/types/json.dart';
import 'package:penhas/app/features/escape_manual/data/datastore/escape_manual_cache_store.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_remote.dart';

import '../../../../../utils/json_util.dart';
import '../model/escape_manual_fixtures.dart';

void main() {
  late IObjectStore<JsonObject> sut;

  late ICacheStorage mockCacheStorage;

  final cacheKey = 'escape_manual_cache';

  setUp(() {
    mockCacheStorage = _MockLocalStorage();

    sut = EscapeManualCacheStore(storage: mockCacheStorage);
  });

  group(EscapeManualCacheStore, () {
    test(
      'retrieve should return storage.get value deserialized',
      () async {
        // arrange
        final expected = escapeManualRemoteModelFixture;
        final cached = JsonUtil.getStringSync(
          from: 'escape_manual/escape_manual_response.json',
        );
        when(() => mockCacheStorage.getString(any()))
            .thenAnswer((_) async => cached);

        // act
        final actual = await sut.retrieve().then(
              (value) => value != null
                  ? EscapeManualRemoteModel.fromJson(value)
                  : null,
            );

        // assert
        expect(actual, equals(expected));
        verify(() => mockCacheStorage.getString(cacheKey)).called(1);
        verifyNoMoreInteractions(mockCacheStorage);
      },
    );

    test(
      'save should call storage.put with serialized data',
      () async {
        // arrange
        final expectedSavedData =
            jsonEncode(updatedEscapeManualRemoteModelFixture);

        when(() => mockCacheStorage.putString(any(), any()))
            .thenAnswer((_) => Future.value());

        // act
        await sut.save(updatedEscapeManualRemoteModelFixture.asJsonObject);

        // assert
        final verificationResult = verify(
          () => mockCacheStorage.putString(cacheKey, captureAny()),
        );
        verificationResult.called(1);
        expect(verificationResult.captured.first, equals(expectedSavedData));
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
