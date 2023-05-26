import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/managers/modules_sevices.dart';
import '../../../chat/domain/usecases/chat_toggle_feature.dart';
import '../../../feed/domain/usecases/escape_manual_toggle.dart';
import '../../../feed/domain/usecases/feed_toggle_feature.dart';
import '../../../feed/domain/usecases/tweet_toggle_feature.dart';
import '../../../help_center/domain/usecases/security_mode_action_feature.dart';
import '../../../support_center/domain/usecases/support_center_toggle_feature.dart';
import 'mainboard_state.dart';

part 'mainboard_store.g.dart';

class MainboardStore extends _MainboardStoreBase with _$MainboardStore {
  MainboardStore({
    required IAppModulesServices modulesServices,
    required MainboardState initialPage,
    PageController? pageController,
  }) : super(modulesServices, initialPage, pageController ?? PageController());
}

abstract class _MainboardStoreBase with Store {
  _MainboardStoreBase(
    this._modulesServices,
    this._initialPage,
    this._pageController,
  );

  final IAppModulesServices _modulesServices;
  final MainboardState _initialPage;
  final PageController _pageController;
  late final Future setupProgress = setup();

  late final PageController pageController = _buildPageCtrl();

  @observable
  ObservableList<MainboardState> pages =
      List<MainboardState>.empty().asObservable();

  @observable
  MainboardState selectedPage = const MainboardState.feed();

  PageController _buildPageCtrl() {
    setupProgress.then((value) => null); // initialize when ctrl is attached
    return _pageController;
  }

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
    final List<MainboardState> authorizedPages = [];

    if (await FeedToggleFeature(modulesServices: _modulesServices).isEnabled) {
      authorizedPages.add(const MainboardState.feed());
    }

    if (await EscapeManualToggleFeature(modulesServices: _modulesServices)
        .isEnabled) {
      authorizedPages.add(const MainboardState.escapeManual());
    } else if (await TweetToggleFeature(modulesServices: _modulesServices)
        .isEnabled) {
      authorizedPages.add(const MainboardState.compose());
    }

    if (await SecurityModeActionFeature(modulesServices: _modulesServices)
        .isEnabled) {
      authorizedPages.add(const MainboardState.helpCenter());
    }

    if (await ChatSupportToggleFeature(modulesServices: _modulesServices)
        .isEnabled) {
      authorizedPages.add(const MainboardState.chat());
    }

    if (await SupportCenterToggleFeature(modulesServices: _modulesServices)
        .isEnabled) {
      authorizedPages.add(const MainboardState.supportPoint());
    }

    pages = authorizedPages.asObservable();
    selectedPage = _initialPage;
    pageController.jumpToPage(pages.indexOf(_initialPage));
  }
}
