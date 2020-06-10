import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/states/mainboard_state.dart';
part 'mainboard_store.g.dart';

class MainboardStore = _MainboardStoreBase with _$MainboardStore;

abstract class _MainboardStoreBase with Store {
  final List<MainboardState> pages = [
    MainboardState.feed(),
    MainboardState.compose(),
    MainboardState.chat(),
    MainboardState.supportPoint()
  ];

  final PageController pageController = PageController(initialPage: 0);

  @observable
  MainboardState selectedPage = MainboardState.feed();

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
