import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/help_center/data/repositories/audio_sync_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  late IAudioSyncRepository sut;
  late IApiProvider apiProvider;

  setUp(() {
    apiProvider = MockApiProvider();
    sut = AudioSyncRepository(apiProvider: apiProvider);
  });

  setUpAll(() {
    registerFallbackValue(MultipartFile.fromString('field', 'value'));
    registerFallbackValue(File('test/assets/audio/silence.aac'));
  });

  group(AudioSyncRepository, () {
    group('upload', () {
      test(
        'get ValidField for a valid upload',
        () async {
          // arrange
          final expected = right(
            const ValidField(message: 'Áudio recebido com sucesso!'),
          );
          final audio = AudioData(
            sequence: '1',
            createdAt: '1',
            eventId: '15dba431-b9c9-4983-af75-9f08c3070c15',
            media: File('test/assets/audio/silence.aac'),
          );
          const bodyMessage =
              '{"message":"Áudio recebido com sucesso!","success":1,"data":{"id":1234}}';
          when(
            () => apiProvider.upload(
              path: any(named: 'path'),
              file: any(named: 'file'),
              fields: any(named: 'fields'),
            ),
          ).thenAnswer((_) async => bodyMessage);
          // act
          final received = await sut.upload(audio);
          // assert
          expect(expected, received);
        },
      );
      test(
        'return Failure when get Exception',
        () async {
          // arrange
          when(
            () => apiProvider.upload(
              path: any(named: 'path'),
              file: any(named: 'file'),
              fields: any(named: 'fields'),
            ),
          ).thenThrow(ApiProviderSessionError());
          final audio = AudioData(
            createdAt: '1',
            sequence: '1',
            eventId: '15dba431-b9c9-4983-af75-9f08c3070c15',
            media: File('test/assets/audio/silence.aac'),
          );

          final expected = left(ServerSideSessionFailed());
          // act
          final received = await sut.upload(audio);
          // assert
          expect(expected, received);
        },
      );
    });

    group('download', () {
      test(
        'get ValidField for a valid download',
        () async {
          // arrange
          final expected = right(
            const ValidField(),
          );
          final audio = AudioEntity(
            id: '123',
            audioDuration: '1s',
            createdAt: DateTime(2021, 1, 1),
            canPlay: true,
            isRequested: true,
            isRequestGranted: true,
          );
          final media = File('test/assets/audio/silence.aac');
          const bodyMessage =
              '{"message":"Áudio recebido com sucesso!","success":1,"data":{"id":1234}}';
          when(
            () => apiProvider.download(
              path: any(named: 'path'),
              file: any(named: 'file'),
              fields: any(named: 'fields'),
            ),
          ).thenAnswer((_) async => bodyMessage);
          // act
          final received = await sut.download(audio, media);
          // assert
          expect(expected, received);
        },
      );
      test('return Failure whe get Exception', () async {
        // arrange
        final audio = AudioEntity(
          id: '123',
          audioDuration: '1s',
          createdAt: DateTime(2021, 1, 1),
          canPlay: true,
          isRequested: true,
          isRequestGranted: true,
        );
        final media = File('test/assets/audio/silence.aac');
        when(
          () => apiProvider.download(
            path: any(named: 'path'),
            file: any(named: 'file'),
            fields: any(named: 'fields'),
          ),
        ).thenThrow(ApiProviderSessionError());
        final expected = left(ServerSideSessionFailed());
        // act
        final received = await sut.download(audio, media);
        // assert
        expect(expected, received);
      });
    });
  });
}
