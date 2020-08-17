import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/help_center/data/repositories/audios_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/audios_state.dart';

part 'audios_controller.g.dart';

class AudiosController extends _AudiosControllerBase with _$AudiosController {
  AudiosController({@required IAudiosRepository audiosRepository})
      : super(audiosRepository);
}

abstract class _AudiosControllerBase with Store, MapFailureMessage {
  final IAudiosRepository _audiosRepository;

  _AudiosControllerBase(this._audiosRepository);

  @observable
  ObservableFuture<Either<Failure, List<AudioEntity>>> _fetchProgress;

  @observable
  ObservableFuture<Either<Failure, ValidField>> _updateProgress;

  @observable
  String errorMessage = '';

  @observable
  AudiosState currentState = AudiosState.initial();

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

  @action
  Future<void> requestAudio(AudioEntity audio) async {
    setErrorMessage('');

    final fileName = ['play', audio.id].join('_');

    final path = await getApplicationDocumentsDirectory()
        .then((dir) => join(dir.path, fileName));
    File(path).createSync(recursive: true);
    File file = File(path);

    _updateProgress =
        ObservableFuture(_audiosRepository.requestAudio(audio, file));

    final response = await _updateProgress;
    response.fold(
      (failure) => handleLoadPageError(failure),
      (session) => handleAudioSession(audio, file),
    );
  }

  // Future<void> _onEditPressed(
  //   GuardianContactEntity contact,
  //   String name,
  // ) async {
  //   _setErrorMessage('');
  //   if (contact == null || name == null) {
  //     return;
  //   }

  //   final newContact = contact.copyWith(name: name);

  //   _updateProgress = ObservableFuture(_guardianRepository.update(newContact));
  //   final response = await _updateProgress;

  //   response.fold(
  //     (failure) => _setErrorMessage(mapFailureMessage(failure)),
  //     (session) async => loadPage(),
  //   );
  // }

  // Future<void> _onDeletePressed(GuardianContactEntity contact) async {
  //   _setErrorMessage('');
  //   if (contact == null) return;

  //   _updateProgress = ObservableFuture(_guardianRepository.delete(contact));
  //   final response = await _updateProgress;

  //   response.fold(
  //     (failure) => _setErrorMessage(mapFailureMessage(failure)),
  //     (session) async => loadPage(),
  //   );
  // }

  // Future<void> _onResendPressed(GuardianContactEntity contact) async {
  //   _setErrorMessage('');
  //   if (contact == null) return;

  //   _updateProgress = ObservableFuture(_guardianRepository.create(contact));
  //   final response = await _updateProgress;

  //   response.fold(
  //     (failure) => _setErrorMessage(mapFailureMessage(failure)),
  //     (session) async => loadPage(),
  //   );
  // }

  // Future<void> _onRegisterGuadian() async {
  //   Modular.to.pushNamed('/mainboard/helpcenter/newGuardian').then(
  //     (value) {
  //       // Se o new_guardian inserir um usuário, aparecerá um popup
  //       // com uma mensagem. Ao selecionar o 'Fechar' retornará
  //       // um boolean == true, que vou utilizar aqui para fazer
  //       // reload da pagina
  //       if (value != null && value is bool && value == true) {
  //         loadPage();
  //       }
  //     },
  //   );
  // }
}

extension _AudiosControllerBasePrivate on _AudiosControllerBase {
  void setErrorMessage(String message) => errorMessage = message;

  void handleLoadSession(List<AudioEntity> session) {
    currentState = AudiosState.loaded(session);
  }

  void handleAudioSession(AudioEntity audio, File file) {
    // playAudio = AudiosState.play(audio, file);
  }

  void handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure);
    currentState = AudiosState.error(message);
  }
}
