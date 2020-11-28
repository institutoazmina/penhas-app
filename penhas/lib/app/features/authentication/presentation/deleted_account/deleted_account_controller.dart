import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';
part 'deleted_account_controller.g.dart';

class DeletedAccountController extends _DeletedAccountControllerBase
    with _$DeletedAccountController {
  DeletedAccountController({@required IUserProfileRepository profileRepository})
      : super(profileRepository);
}

abstract class _DeletedAccountControllerBase with Store {
  final IUserProfileRepository _profileRepository;

  _DeletedAccountControllerBase(this._profileRepository);

  @action
  Future<void> reactive() async {
    // _profileRepository.
  }
}
