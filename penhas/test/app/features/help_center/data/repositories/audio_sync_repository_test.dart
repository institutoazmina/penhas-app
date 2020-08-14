import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/help_center/data/repositories/audio_sync_repository.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  IAudioSyncRepository sut;
  IApiProvider apiProvider;

  setUp(() {
    apiProvider = MockApiProvider();
    sut = AudioSyncRepository(apiProvider: apiProvider);
  });

  group('AudioSyncRepository', () {
    test('should get ValidField for a valid upload', () async {
      // arrange
      final expected = right(
        ValidField(message: "Áudio recebido com sucesso!"),
      );
      final audio = AudioData(
        createdAt: 1,
        eventId: '15dba431-b9c9-4983-af75-9f08c3070c15',
        media: File('test/assets/audio/silence.aac'),
      );
      final bodyMessage =
          '{"message":"Áudio recebido com sucesso!","success":1,"data":{"id":1234}}';
      when(apiProvider.upload(
              path: anyNamed('path'),
              file: anyNamed('file'),
              fields: anyNamed('fields')))
          .thenAnswer((_) async => bodyMessage);
      // act
      final received = await sut.upload(audio);
      // assert
      expect(received, expected);
    });
    test('should return Failure when get Exception', () async {
      // arrange
      when(apiProvider.upload(
              path: anyNamed('path'),
              file: anyNamed('file'),
              fields: anyNamed('fields')))
          .thenThrow(ApiProviderSessionExpection());
      final audio = AudioData(
        createdAt: 1,
        eventId: '15dba431-b9c9-4983-af75-9f08c3070c15',
        media: File('test/assets/audio/silence.aac'),
      );

      final expected = left(ServerSideSessionFailed());
      // act
      final received = await sut.upload(audio);
      // assert
      expect(received, expected);
    });
  });
}

/*
      when(dataSource.check()).thenThrow(ApiProviderSessionExpection());

      // act
      final received = await sut.check();
      // assert
      expect(received, expected);
    */
