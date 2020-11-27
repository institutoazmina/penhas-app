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
    List<MainboardState> autorizedPages = List<MainboardState>();

    if (await FeedToggleFeature(modulesServices: _modulesServices).isEnabled) {
      autorizedPages.add(MainboardState.feed());
    }

    if (await TweetToggleFeature(modulesServices: _modulesServices).isEnabled) {
      autorizedPages.add(MainboardState.compose());
    }

    if (await SecurityModeActionFeature(modulesServices: _modulesServices)
        .isEnabled) {
      autorizedPages.add(MainboardState.helpCenter());
    }

    if (await ChatSupportToggleFeature(modulesServices: _modulesServices)
        .isEnabled) {
      autorizedPages.add(MainboardState.chat());
    }

    if (await SupportCenterToggleFeature(modulesServices: _modulesServices)
        .isEnabled) {
      autorizedPages.add(MainboardState.supportPoint());
    }

    pages = autorizedPages.asObservable();
  }
}