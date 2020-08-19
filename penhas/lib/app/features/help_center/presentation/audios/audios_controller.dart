import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/audio_play_services.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/help_center/data/repositories/audios_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_play_tile_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/audio_tile_action.dart';
import 'package:penhas/app/features/help_center/domain/states/audios_state.dart';

part 'audios_controller.g.dart';

class AudiosController extends _AudiosControllerBase with _$AudiosController {
  AudiosController({
    @required IAudiosRepository audiosRepository,
    @required IAudioPlayServices audioPlayServices,
  }) : super(audiosRepository, audioPlayServices);
}

abstract class _AudiosControllerBase with Store, MapFailureMessage {
  final IAudioPlayServices _audioPlayer;
  final IAudiosRepository _audiosRepository;

  _AudiosControllerBase(this._audiosRepository, this._audioPlayer);

  @observable
  ObservableFuture<Either<Failure, List<AudioEntity>>> _fetchProgress;

  @observable
  ObservableFuture<Either<Failure, ValidField>> _updateProgress;

  @observable
  String errorMessage = '';

  @observable
  AudiosState currentState = AudiosState.initial();

  @observable
  AudioTileAction actionSheetState = AudioTileAction.initial();

  @computed
  PageProgressState get loadState {
    if (_fetchProgress == null ||
        _fetchProgress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _fetchProgress.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @computed
  PageProgressState get updateState {
    if (_updateProgress == null ||
        _updateProgress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _updateProgress.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  Future<void> loadPage() async {
    setErrorMessage('');
    _fetchProgress = ObservableFuture(_audiosRepository.fetch());

    final response = await _fetchProgress;

    response.fold(
      (failure) => handleLoadPageError(failure),
      (session) => handleLoadSession(session),
    );
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

extension _AudiosControllerBasePrivate on _AudiosControllerBase {
  void setErrorMessage(String message) => errorMessage = message;

  void handleLoadSession(List<AudioEntity> session) {
    final audios = session.map((e) => buildTile(e)).toList();
    currentState = AudiosState.loaded(audios);
  }

  void handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure);
    currentState = AudiosState.error(message);
  }

  Future<void> requestAudio(AudioEntity audio) async {
    setErrorMessage('');

    bool isRequestRequired = !audio.canPlay && !audio.isRequested;
    if (isRequestRequired) {
      _updateProgress =
          ObservableFuture(_audiosRepository.requestAccess(audio));
    }

    if (audio.canPlay) {
      _updateProgress = ObservableFuture(_audioPlayer.start(audio));
    }

    final response = await _updateProgress;
    response.fold(
      (failure) => setErrorMessage(mapFailureMessage(failure)),
      (session) => actionSheetState = AudioTileAction.notice(session.message),
    );
  }

  AudioPlayTileEntity buildTile(AudioEntity audio) {
    String description = "";
    bool requireRequestDownloadAudio =
        (!audio.canPlay && !audio.isRequested && !audio.isRequestGranted);
    bool requestGrantedAndCanPlay =
        (audio.canPlay && audio.isRequested && audio.isRequestGranted);
    bool waitingAutorization =
        (!audio.canPlay && audio.isRequested && !audio.isRequestGranted);

    if (requireRequestDownloadAudio) {
      description = 'Toque no botão de play para solicitar o audio';
    } else if (requestGrantedAndCanPlay) {
      description = 'Audio liberado, toque no play para ouvir';
    } else if (waitingAutorization) {
      description = 'Aguardando autorização para realizar o download do audio';
    } else if (audio.canPlay) {
      description = 'Toque no botão de play para inicar o audio';
    }

    return AudioPlayTileEntity(
      audio: audio,
      description: description,
      onPlayAudio: (audio) async => requestAudio(audio),
      onActionSheet: (audio) => print('ola mundo cruel'),
    );
  }
}
