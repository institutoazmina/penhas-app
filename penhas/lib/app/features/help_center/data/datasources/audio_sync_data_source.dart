/*
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/network/api_client.dart';

abstract class IAudioSyncDataSource {}


class AudioSyncDataSource implements IAudioSyncDataSource {
  final IApiProvider _apiClient;

  AudioSyncDataSource({
    @required IApiProvider apiClient,
    @required serverConfiguration,
  }) : this._apiClient = apiClient;

  Future<void> upload(AudioData audio) async {

    _apiClient.upload(
      path: '/me/audios',
      fields: fields,
      file: fileData,
    );
  }
}


*/
