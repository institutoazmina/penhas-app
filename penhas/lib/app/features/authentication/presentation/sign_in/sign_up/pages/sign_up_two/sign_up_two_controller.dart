import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';

part 'sign_up_two_controller.g.dart';

class MenuItemModel {
  final String? display;
  final String value;

  MenuItemModel(this.display, this.value);

  final String? display;
  final String value;
}

class SignUpTwoController extends _SignUpTwoControllerBase
    with _$SignUpTwoController {
  SignUpTwoController(IUserRegisterRepository repository,
      UserRegisterFormFieldModel? userFormFielModel)
      : super(repository, userFormFielModel);

  static List<MenuItemModel> genreDataSource() {
    return Genre.values
        .map(
          (v) => MenuItemModel(_mapGenreToLabel(v), '${v.index}'),
        )
        .toList();
  }

  static List<MenuItemModel> raceDataSource() {
    return HumanRace.values
        .map(
          (v) => MenuItemModel(v.label, '${v.index}'),
        )
        .toList();
  }

  static String? _mapGenreToLabel(Genre genre) {
    String? label;
    switch (genre) {
      case Genre.female:
        label = 'Feminino';
        break;
      case Genre.male:
        label = 'Masculino';
        break;
      case Genre.transBoy:
        label = 'Homen Trans';
        break;
      case Genre.transGirl:
        label = 'Mulher Trans';
        break;
      case Genre.others:
        label = 'Outro';
        break;
    }

    return label;
  }
}

abstract class _SignUpTwoControllerBase with Store, MapFailureMessage {
  _SignUpTwoControllerBase(this.repository, this._userRegisterModel);

  final IUserRegisterRepository repository;
  final UserRegisterFormFieldModel? _userRegisterModel;

  final String genreMessageErro = 'Gênero é requirido';
  final String raceMessageErro = 'Raça é requerida';

  @observable
  ObservableFuture<Either<Failure, ValidField>>? _progress;

  @observable
  String warningNickname = '';

  @observable
  String warningSocialName = '';

  @observable
  String warningGenre = '';

  @observable
  String warningRace = '';

  @observable
  String currentGenre = '';

  @observable
  String currentRace = '';

  @observable
  String errorMessage = '';

  @observable
  bool hasSocialNameField = false;

  @computed
  PageProgressState get currentState {
    if (_progress == null || _progress!.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _progress!.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  void setNickname(String name) {
    _userRegisterModel!.nickname = Nickname(name);

    warningNickname =
        name.isEmpty ? '' : _userRegisterModel!.validateNickname;
  }

  @action
  void setSocialName(String name) {
    _userRegisterModel!.socialName = Fullname(name);

    warningSocialName =
        name.isEmpty ? '' : _userRegisterModel!.validateSocialName;
  }

  @action
  void setGenre(String label) {
    _userRegisterModel!.genre = Genre.values[int.parse(label)];
    currentGenre = label;
    warningGenre = '';

    if (_userRegisterModel!.genre == null ||
        _userRegisterModel!.genre == Genre.female ||
        _userRegisterModel!.genre == Genre.male) {
      hasSocialNameField = false;
    } else {
      hasSocialNameField = true;
    }
  }

  @action
  void setRace(String label) {
    _userRegisterModel!.race = HumanRace.values[int.parse(label)];
    currentRace = label;
    warningRace = '';
  }

  @action
  Future<void> nextStepPressed() async {
    errorMessage = '';
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      repository.checkField(
        birthday: _userRegisterModel!.birthday,
        cpf: _userRegisterModel!.cpf,
        fullname: _userRegisterModel!.fullname,
        cep: _userRegisterModel!.cep,
        nickName: _userRegisterModel!.nickname,
        genre: _userRegisterModel!.genre,
        race: _userRegisterModel!.race,
      ),
    );

    final Either<Failure, ValidField> response = await _progress!;
    response.fold(
      (failure) => mapFailureMessage(failure),
      (session) => _forwardToStep3(),
    );
  }

  void _forwardToStep3() {
    Modular.to.pushNamed('/authentication/signup/step3',
        arguments: _userRegisterModel!,);
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel!.validateNickname.isNotEmpty) {
      isValid = false;
      warningNickname = _userRegisterModel!.validateNickname;
    }

    if (_userRegisterModel!.genre == null) {
      isValid = false;
      warningGenre = genreMessageErro;
    }

    if (_userRegisterModel!.race == null) {
      isValid = false;
      warningRace = raceMessageErro;
    }

    return isValid;
  }
}
