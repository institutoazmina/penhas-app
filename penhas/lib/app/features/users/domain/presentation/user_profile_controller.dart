import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';

part 'user_profile_controller.g.dart';

class UserProfileController extends _UserProfileControllerBase
    with _$UserProfileController {
  UserProfileController({
    @required UserDetailProfileEntity person,
  }) : super(person);
}

abstract class _UserProfileControllerBase with Store {
  final UserDetailProfileEntity _person;

  _UserProfileControllerBase(this._person) {
    _init();
  }

  void _init() {
    person = _person;
  }

  @observable
  UserDetailProfileEntity person = UserDetailProfileEntity(
      skills: null,
      activity: null,
      avatar: null,
      clientId: null,
      miniBio: null,
      nickname: null);
}
