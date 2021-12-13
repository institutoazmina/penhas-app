import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_toggle_feature.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_toggle_feature.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_toggle_feature.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_toggle_feature.dart';

part 'mainboard_store.g.dart';

class MainboardStore extends _MainboardStoreBase with _$MainboardStore {
  MainboardStore({
    required IAppModulesServices modulesServices,
    required MainboardState initialPage,
  }) : super(modulesServices, initialPage);
}

abstract class _MainboardStoreBase with Store {
  final IAppModulesServices _modulesServices;
  final MainboardState _initialPage;
  late Future setupProgress;

  _MainboardStoreBase(this._modulesServices, this._initialPage) {
    setupProgress = setup();
  }

  PageController pageController = PageController(initialPage: 0);

  @observable
  ObservableList<MainboardState> pages =
      List<MainboardState>.empty().asObservable();

  @observable
  MainboardState? selectedPage;

  @action
  Future changePage({required MainboardState to}) async {
    await setupProgress;
    final int index = pages.indexOf(to);

    if (index < 0) {
      return;
    }

    pageController.jumpToPage(index);
    selectedPage = to;
  }
}

extension _Methods on _MainboardStoreBase {
  Future<void> setup() async {
    List<MainboardState> authorizedPages = [];

    if (await FeedToggleFeature(modulesServices: _modulesServices).isEnabled) {
      authorizedPages.add(MainboardState.feed());
    }

    if (await TweetToggleFeature(modulesServices: _modulesServices).isEnabled) {
      authorizedPages.add(MainboardState.compose());
    }

    if (await SecurityModeActionFeature(modulesServices: _modulesServices)
        .isEnabled) {
      authorizedPages.add(MainboardState.helpCenter());
    }

    if (await ChatSupportToggleFeature(modulesServices: _modulesServices)
        .isEnabled) {
      authorizedPages.add(MainboardState.chat());
    }

    if (await SupportCenterToggleFeature(modulesServices: _modulesServices)
        .isEnabled) {
      authorizedPages.add(MainboardState.supportPoint());
    }

    pages = authorizedPages.asObservable();
    selectedPage = _initialPage;
    pageController = PageController(initialPage: pages.indexOf(_initialPage));
  }
}
