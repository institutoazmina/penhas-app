import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/update_user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/filters/domain/repositories/filter_skill_repository.dart';
import 'package:penhas/app/features/filters/states/filter_action_observer.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/features/main_menu/domain/states/profile_edit_state.dart';
import 'package:penhas/app/shared/logger/log.dart';

part 'profile_edit_controller.g.dart';

class ProfileEditController extends _ProfileEditControllerBase
    with _$ProfileEditController {
  ProfileEditController({
    required AppStateUseCase appStateUseCase,
    required IFilterSkillRepository skillRepository,
    required SecurityModeActionFeature securityModeActionFeature,
  }) : super(appStateUseCase, skillRepository, securityModeActionFeature);
}

abstract class _ProfileEditControllerBase with Store, MapFailureMessage {
  _ProfileEditControllerBase(
    this._appStateUseCase,
    this._skillRepository,
    this._securityModeActionFeature,
  ) {
    loadProfile();
  }

  final AppStateUseCase _appStateUseCase;
  final IFilterSkillRepository _skillRepository;
  final SecurityModeActionFeature _securityModeActionFeature;
  List<FilterTagEntity>? _tags = [];

  @observable
  ObservableFuture<Either<Failure, AppStateEntity>>? _progress;

  @observable
  ObservableList<FilterTagEntity?> profileSkill =
      ObservableList<FilterTagEntity>();

  @observable
  ProfileEditState state = const ProfileEditState.initial();

  @observable
  String? updateError = '';

  @computed
  PageProgressState get progressState {
    return monitorProgress(_progress);
  }

  @action
  Future<void> retry() async {
    loadProfile();
  }

  @action
  Future<void> editNickName(String name) async {
    updateError = '';
    final update = UpdateUserProfileEntity(nickName: name);
    updateProfile(update);
  }

  @action
  Future<void> editMinibio(String content) async {
    updateError = '';
    final update = UpdateUserProfileEntity(minibio: content);
    updateProfile(update);
  }

  @action
  Future<void> updateRace(String id) async {
    updateError = '';
    final update = UpdateUserProfileEntity(race: id);
    updateProfile(update);
  }

  @action
  Future<void> updatedEmail(String email, String password) async {
    updateError = '';
    final update = UpdateUserProfileEntity(email: email, oldPassword: password);
    updateProfile(update);
  }

  @action
  Future<void> updatePassword(String newPassword, String oldPassword) async {
    updateError = '';
    final update = UpdateUserProfileEntity(
      newPassword: newPassword,
      oldPassword: oldPassword,
    );
    updateProfile(update);
  }

  @action
  Future<void> editSkill() async {
    final tags = _tags!
        .map(
          (e) => e.copyWith(
            isSelected: isSeleted(e.id),
          ),
        )
        .toList();

    Modular.to
        .pushNamed('/mainboard/menu/profile_edit/skills', arguments: tags)
        .then((v) => v as FilterActionObserver?)
        .then((v) => handleFilterUpdate(v));
  }
}

extension _PrivateMethod on _ProfileEditControllerBase {
  Future<void> handleFilterUpdate(FilterActionObserver? v) async {
    if (v == null) return;
    final updatedSkill = v.when(
      reset: () => UpdateUserProfileEntity(skills: []),
      updated: (s) => UpdateUserProfileEntity(
        skills: s.map((e) => e.id).toList(),
      ),
    );

    updateProfile(updatedSkill);
  }

  Future<void> loadProfile() async {
    final resultSkill = await _skillRepository.skills();
    _tags = resultSkill.getOrElse(() => List.empty());

    final result = await _appStateUseCase.check();
    result.fold(
      (failure) => handleLoadPageError(failure),
      (session) => handleSession(session),
    );
  }

  Future<void> updateProfile(UpdateUserProfileEntity update) async {
    _progress = ObservableFuture(
      _appStateUseCase.update(update),
    );

    final Either<Failure, AppStateEntity> result = await _progress!;

    result.fold(
      (failure) => handleUpdateError(failure),
      (session) => handleSession(session),
    );
  }

  Future<void> handleSession(AppStateEntity session) async {
    _tags!.map((e) => null);
    final List<FilterTagEntity?> userSkills =
        session.userProfile!.skill.map((e) => selectSkill(e)).toList();
    userSkills.removeWhere((e) => e == null);
    profileSkill = userSkills.asObservable();

    final securityModeFeatureEnabled =
        await _securityModeActionFeature.isEnabled;

    state = ProfileEditState.loaded(
      session.userProfile!,
      securityModeFeatureEnabled: securityModeFeatureEnabled,
    );
  }

  void handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure)!;
    state = ProfileEditState.error(message);
  }

  void handleUpdateError(Failure failure) {
    updateError = mapFailureMessage(failure);
  }

  PageProgressState monitorProgress(ObservableFuture<Object>? observable) {
    if (observable == null || observable.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return observable.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  bool isSeleted(String id) {
    try {
      profileSkill.firstWhere((v) => v!.id == id);
      return true;
    } catch (e, stack) {
      logError(e, stack);
      return false;
    }
  }

  FilterTagEntity? selectSkill(String id) {
    try {
      final tag = _tags!.firstWhere((v) => v.id == id);
      return FilterTagEntity(
        id: tag.id,
        isSelected: true,
        label: tag.label,
      );
    } catch (e, stack) {
      logError(e, stack);
      return null;
    }
  }
}
