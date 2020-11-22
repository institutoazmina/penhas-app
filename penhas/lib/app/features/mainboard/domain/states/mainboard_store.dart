import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';

part 'mainboard_store.g.dart';

class MainboardStore extends _MainboardStoreBase with _$MainboardStore {
  MainboardStore({
    @required IAppModulesServices modulesServices,
  }) : super(modulesServices);
}

abstract class _MainboardStoreBase with Store {
  final IAppModulesServices _modulesServices;

  _MainboardStoreBase(this._modulesServices) {
    setup();
  }

  final PageController pageController = PageController(initialPage: 0);

  @observable
  MainboardState selectedPage = MainboardState.feed();

  @observable
  ObservableList<MainboardState> pages = [MainboardState.feed()].asObservable();

  @action
  void changePage({@required MainboardState to}) {
    final index = pages.indexOf(to);

    if (index < 0) {
      return;
    }

    pageController.jumpToPage(index);
    selectedPage = to;
  }
}

extension _Methods on _MainboardStoreBase {
  Future<void> setup() async {
    pages = [
      MainboardState.feed(),
      MainboardState.compose(),
      MainboardState.chat(),
      MainboardState.supportPoint(),
      MainboardState.helpCenter(),
    ].asObservable();
  }
}
