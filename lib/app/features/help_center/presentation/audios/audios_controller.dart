import 'dart:async';

import 'package:background_downloader/background_downloader.dart';
import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/managers/audio_play_services.dart';
import '../../../../core/managers/audio_sync_manager.dart';
import '../../../authentication/presentation/shared/map_failure_message.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../data/models/audio_model.dart';
import '../../data/repositories/audios_repository.dart';
import '../../domain/entities/audio_entity.dart';
import '../../domain/entities/audio_play_tile_entity.dart';
import '../../domain/states/audio_playing.dart';
import '../../domain/states/audio_tile_action.dart';
import '../../domain/states/audios_state.dart';

part 'audios_controller.g.dart';

class AudiosController extends _AudiosControllerBase with _$AudiosController {
  AudiosController({
    required IAudiosRepository audiosRepository,
    required IAudioPlayServices audioPlayServices,
    required IAudioSyncManager audioSyncManager,
  }) : super(audiosRepository, audioPlayServices, audioSyncManager);
}

abstract class _AudiosControllerBase with Store, MapFailureMessage {
  _AudiosControllerBase(
    this._audiosRepository,
    this._audioPlayer,
    this._audioSyncManager,
  );

  final IAudioPlayServices _audioPlayer;
  final IAudiosRepository _audiosRepository;
  final IAudioSyncManager _audioSyncManager;
  StreamSubscription<TaskUpdate>? _taskSubscription;

  @observable
  ObservableFuture<Either<Failure, AudioModel>>? _fetchProgress;

  @observable
  ObservableFuture<Either<Failure, ValidField>>? _updateProgress;

  @observable
  String? errorMessage = '';

  @observable
  AudiosState currentState = const AudiosState.initial();

  @observable
  AudioTileAction actionSheetState = const AudioTileAction.initial();

  @observable
  AudioPlaying playingAudioState = const AudioPlaying.none();

  @observable
  double pendingProgress = 0.0;

  @computed
  PageProgressState get loadState {
    if (_fetchProgress == null ||
        _fetchProgress!.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _fetchProgress!.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @computed
  PageProgressState get updateState {
    if (_updateProgress == null ||
        _updateProgress!.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _updateProgress!.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  Future<void> loadPage() async {
    errorMessage = '';
    _fetchProgress = ObservableFuture(_audiosRepository.fetch());

    final Either<Failure, AudioModel> response = await _fetchProgress!;

    response.fold(
      (failure) => handleLoadPageError(failure),
      (session) => handleLoadSession(session),
    );
  }

  @action
  Future<void> delete(AudioEntity audio) async {
    errorMessage = '';
    _updateProgress = ObservableFuture(_audiosRepository.delete(audio));

    final Either<Failure, ValidField> response = await _updateProgress!;
    response.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (session) async => loadPage(),
    );
  }

  void initUpdatesListener() {
    // Listen via the manager's broadcast re-emit — NOT FileDownloader().updates
    // directly (that single-subscription stream is already owned by
    // AudioSyncManager; a second .listen throws and aborts initState).
    _taskSubscription ??= _audioSyncManager.updates.listen((update) {
      if (update is TaskProgressUpdate) {
        pendingProgress = update.progress;
      }
      if (update is TaskStatusUpdate) {
        if (update.status == TaskStatus.complete ||
            update.status == TaskStatus.failed) {
          loadPage();
        }
      }
    });
  }

  void dispose() {
    _taskSubscription?.cancel();
    _audioPlayer.dispose();
  }
}

extension _AudiosControllerBasePrivate on _AudiosControllerBase {
  Future<void> handleLoadSession(AudioModel session) async {
    final List<AudioPlayTileEntity> audios =
        session.audioList.map((e) => buildTile(e)).toList();

    final pending = await _audioSyncManager.pendingUploads();
    final optimisticTiles = pending.map(buildPendingTile).toList();

    currentState = AudiosState.loaded(
      [...optimisticTiles, ...audios],
      session.message,
    );
  }

  void handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure);
    currentState = AudiosState.error(message);
  }

  Future<void> requestAudio(AudioEntity audio) async {
    errorMessage = '';

    final bool isRequestRequired = !audio.canPlay && !audio.isRequested;
    if (isRequestRequired) {
      final request = await _audiosRepository.requestAccess(audio);
      request.fold(
        (failure) => errorMessage = mapFailureMessage(failure),
        (session) =>
            actionSheetState = AudioTileAction.notice(session.message!),
      );
    } else if (audio.canPlay) {
      final playingAudio = await _audioPlayer.start(
        audio,
        onFinished: () => playingAudioState = const AudioPlaying.none(),
      );
      playingAudio.fold(
        (failure) => errorMessage = mapFailureMessage(failure),
        (r) => playingAudioState = AudioPlaying.playing(r),
      );
    }
  }

  AudioPlayTileEntity buildTile(AudioEntity audio) {
    String description = '';
    final bool requireRequestDownloadAudio =
        !audio.canPlay && !audio.isRequested && !audio.isRequestGranted;
    final bool requestGrantedAndCanPlay =
        audio.canPlay && audio.isRequested && audio.isRequestGranted;
    final bool waitingAutorization =
        !audio.canPlay && audio.isRequested && !audio.isRequestGranted;

    if (requireRequestDownloadAudio) {
      description = 'Toque no ícone para solicitar o audio';
    } else if (requestGrantedAndCanPlay) {
      description = 'Audio liberado, toque no play para ouvir';
    } else if (waitingAutorization) {
      description = 'Aguardando autorização para realizar o download do audio';
    } else if (audio.canPlay) {
      description = 'Toque no botão de play para iniciar o audio';
    }

    return AudioPlayTileEntity(
      audio: audio,
      description: description,
      onPlayAudio: (audio) async => requestAudio(audio),
      onActionSheet: (audio) async =>
          actionSheetState = AudioTileAction.actionSheet(audio),
    );
  }

  AudioPlayTileEntity buildPendingTile(Map<String, String> pending) {
    final progress = pending['progress'] ?? '0';
    final status = pending['status'];
    final uploadStatus = status == 'running'
        ? TileUploadStatus.uploading
        : TileUploadStatus.waitingNetwork;

    return AudioPlayTileEntity(
      audio: AudioEntity(
        id: pending['taskId'] ?? '',
        audioDuration: null,
        createdAt: DateTime.now(),
        canPlay: false,
        isRequested: false,
        isRequestGranted: false,
      ),
      description: status == 'running'
          ? 'Enviando áudio... $progress%'
          : 'Aguardando rede para enviar',
      onPlayAudio: (_) {},
      onActionSheet: (_) {},
      uploadStatus: uploadStatus,
      uploadProgress: double.tryParse(progress),
    );
  }
}
