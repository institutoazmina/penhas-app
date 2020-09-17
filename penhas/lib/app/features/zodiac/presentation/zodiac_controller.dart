import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/zodiac/domain/entities/izodiac.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_aquarius.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/zodiac.dart';

part 'zodiac_controller.g.dart';

class ZodiacController extends _ZodiacControllerBase with _$ZodiacController {
  ZodiacController({
    @required IUserProfileStore userProfileStore,
  }) : super(userProfileStore);
}

abstract class _ZodiacControllerBase with Store {
  final IUserProfileStore _userProfileStore;
  UserProfileEntity _userProfile;

  _ZodiacControllerBase(this._userProfileStore) {
    _init();
  }

  void _init() async {
    _userProfile = await _userProfileStore.retreive();
    final Zodiac zodiac = Zodiac();
    sign = zodiac.sign(_userProfile.birthdate);
    signList =
        zodiac.pickEigthRandonSign(_userProfile.birthdate).asObservable();
  }

  @observable
  IZodiac sign = ZodiacSignAquarius();

  @observable
  ObservableList<IZodiac> signList = ObservableList<IZodiac>();

  @action
  void forwardStealthLogin() {
    print('forwardStealthLogin');
  }

  void stealthAction() {
    print('stealthAction');
  }
}
