import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/presentation/sign_up/user_register_form_field_model.dart';

part 'sign_up_two_controller.g.dart';

const String WARNING_NICK_NAME = 'Apelido inválido para o sistema';
const String WARNING_GENRE = 'Gênero é requirido';
const String WARNING_RACE = 'Raça é requerida';
const WARNING_INVALID_FIELD_TO_CONTINUE =
    'Todos os campos precisam estar válidos antes de continguar.';
const String ERROR_SERVER_FAILURE =
    "O servidor está com problema neste momento, tente novamente.";
const String ERROR_INTERNET_CONNECTION_FAILURE =
    "O servidor está inacessível, o PenhaS está com acesso à Internet?";

class MenuItemModel {
  final String display;
  final String value;

  MenuItemModel(this.display, this.value);
}

class SignUpTwoController extends _SignUpTwoControllerBase
    with _$SignUpTwoController {
  SignUpTwoController(IUserRegisterRepository repository) : super(repository);

  static List<MenuItemModel> genreDataSource() {
    return Genre.values
        .map(
          (v) => MenuItemModel(_mapGenreToLabel(v), "${v.index}"),
        )
        .toList();
  }

  static List<MenuItemModel> raceDataSource() {
    return HumanRace.values
        .map(
          (v) => MenuItemModel(_mapRaceToLabel(v), "${v.index}"),
        )
        .toList();
  }

  static String _mapGenreToLabel(Genre genre) {
    String label;
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
        label = 'Indefinido';
        break;
    }

    return label;
  }

  static String _mapRaceToLabel(HumanRace race) {
    String label;
    switch (race) {
      case HumanRace.white:
        label = 'Branco';
        break;
      case HumanRace.brown:
        label = 'Pardo';
        break;
      case HumanRace.black:
        label = 'Preto';
        break;
      case HumanRace.indigenous:
        label = 'Índigena';
        break;
      case HumanRace.yellow:
        label = 'Amarelo';
        break;
      case HumanRace.notDeclared:
        label = 'Não declarar';
        break;
    }

    return label;
  }
}

abstract class _SignUpTwoControllerBase with Store {
  final IUserRegisterRepository repository;
  UserRegisterFormFieldModel _userRegisterModel = UserRegisterFormFieldModel();

  _SignUpTwoControllerBase(this.repository);

  @observable
  ObservableFuture<Either<Failure, ValidField>> _progress;

  @observable
  String warningNickname = '';

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

  @action
  void setNickname(String name) {
    _userRegisterModel.nickname = Nickname(name);

    warningNickname = _userRegisterModel.nickname.value.fold(
      (failure) => name.length == 0 ? '' : WARNING_NICK_NAME,
      (_) => '',
    );
  }

  @action
  void setGenre(String label) {
    _userRegisterModel.genre = Genre.values[int.parse(label)];
    currentGenre = label;
    warningGenre = '';
  }

  @action
  void setRace(String label) {
    _userRegisterModel.race = HumanRace.values[int.parse(label)];
    currentRace = label;
    warningRace = '';
  }

  @action
  Future<void> nextStepPressed() async {
    _setErrorMessage('');
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      repository.checkField(
        birthday: _userRegisterModel.birthday,
        cpf: _userRegisterModel.cpf,
        fullname: _userRegisterModel.fullname,
        cep: _userRegisterModel.cep,
        nickName: _userRegisterModel.nickname,
        genre: _userRegisterModel.genre,
        race: _userRegisterModel.race,
      ),
    );

    final response = await _progress;
    response.fold(
      // (failure) => _mapFailureToMessage(failure),
      (failure) => _forwardToStep3(),
      (session) => UnimplementedError(),
    );
  }

  void _forwardToStep3() {
    Modular.to.pushNamed('/authentication/signup/step3');
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.nickname == null ||
        !_userRegisterModel.nickname.isValid) {
      isValid = false;
      warningNickname = WARNING_NICK_NAME;
    }

    if (_userRegisterModel.genre == null) {
      isValid = false;
      warningGenre = WARNING_GENRE;
    }

    if (_userRegisterModel.race == null) {
      isValid = false;
      warningRace = WARNING_RACE;
    }

    return isValid;
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case InternetConnectionFailure:
        _setErrorMessage(ERROR_INTERNET_CONNECTION_FAILURE);
        break;
      case ServerFailure:
        _setErrorMessage(ERROR_SERVER_FAILURE);
        break;
      case ServerSideFormFieldValidationFailure:
        _mapFailureToFields(failure);
        break;
      default:
        throw UnsupportedError;
    }
  }

  _mapFailureToFields(ServerSideFormFieldValidationFailure failure) {
    _setErrorMessage(failure.message);
  }
}
