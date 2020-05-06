import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';

part 'sign_up_three_controller.g.dart';

class SignUpThreeController extends _SignUpThreeControllerBase
    with _$SignUpThreeController {
  SignUpThreeController(IUserRegisterRepository repository) : super(repository);
}

abstract class _SignUpThreeControllerBase with Store {
  final IUserRegisterRepository repository;

  _SignUpThreeControllerBase(this.repository);

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
