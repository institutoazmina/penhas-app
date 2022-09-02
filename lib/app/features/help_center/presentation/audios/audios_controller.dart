import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/audio_play_services.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/help_center/data/repositories/audios_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_play_tile_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/audio_playing.dart';
import 'package:penhas/app/features/help_center/domain/states/audio_tile_action.dart';
import 'package:penhas/app/features/help_center/domain/states/audios_state.dart';

part 'audios_controller.g.dart';

class AudiosController extends _AudiosControllerBase with _$AudiosController {
  AudiosController({
    required IAudiosRepository audiosRepository,
    required IAudioPlayServices audioPlayServices,
  }) : super(audiosRepository, audioPlayServices);
}

abstract class _AudiosControllerBase with Store, MapFailureMessage {
  _AudiosControllerBase(this._audiosRepository, this._audioPlayer);

  final IAudioPlayServices _audioPlayer;
  final IAudiosRepository _audiosRepository;

  @observable
  ObservableFuture<Either<Failure, List<AudioEntity>?>>? _fetchProgress;

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

    final Either<Failure, List<AudioEntity>?> response = await _fetchProgress!;

    response.fold(
      (failure) => handleLoadPageError(failure),
      (session) => handleLoadSession(session!),
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

  void dispose() {
    _audioPlayer.dispose();
  }
}

extension _AudiosControllerBasePrivate on _AudiosControllerBase {
  void handleLoadSession(List<AudioEntity> session) {
    final audios = session.map((e) => buildTile(e)).toList();
    currentState = AudiosState.loaded(audios);
  }

  void handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure)!;
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
}
