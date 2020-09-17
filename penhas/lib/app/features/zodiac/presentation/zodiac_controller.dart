import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
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

  _ZodiacControllerBase(this._userProfileStore) {
    _init();
  }

  void _init() async {
    final zodiac = Zodiac();
    final _userProfile = await _userProfileStore.retreive();
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
    Modular.to.pushReplacementNamed('/authentication/sign_in_stealth');
  }

  @action
  void stealthAction() {
    print('stealthAction');
  }
}
