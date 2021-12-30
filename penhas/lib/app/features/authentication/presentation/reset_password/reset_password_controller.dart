import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';

part 'reset_password_controller.g.dart';

class ResetPasswordController extends _ResetPasswordControllerBase
    with _$ResetPasswordController {
  ResetPasswordController(IResetPasswordRepository repository)
      : super(repository);
}

abstract class _ResetPasswordControllerBase with Store, MapFailureMessage {
  _ResetPasswordControllerBase(this.repository);

  final IResetPasswordRepository repository;
  final UserRegisterFormFieldModel _userRegisterModel =
      UserRegisterFormFieldModel();

  @observable
  ObservableFuture<Either<Failure, ResetPasswordResponseEntity>>? _progress;

  @observable
  String? errorMessage = '';

  @observable
  String warningEmail = '';

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
  void setEmail(String address) {
    _userRegisterModel.emailAddress = EmailAddress(address);

    warningEmail =
        address.isEmpty ? '' : _userRegisterModel.validateEmailAddress;
  }

  @action
  Future<void> nextStepPressed() async {
    errorMessage = '';
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      repository.request(emailAddress: _userRegisterModel.emailAddress),
    );

    final Either<Failure, ResetPasswordResponseEntity> response =
        await _progress!;
    response.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (session) => _forwardToStep2(session),
    );
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.validateEmailAddress.isNotEmpty) {
      isValid = false;
      warningEmail = _userRegisterModel.validateEmailAddress;
    }

    return isValid;
  }

  void _forwardToStep2(ResetPasswordResponseEntity entity) {
    Modular.to.pushNamed(
      '/authentication/reset_password/step2',
      arguments: _userRegisterModel,
    );
  }
}
