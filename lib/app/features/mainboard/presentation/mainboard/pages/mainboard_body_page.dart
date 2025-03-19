import 'package:flutter/material.dart';

import '../../../../chat/presentation/chat_main_module.dart';
import '../../../../escape_manual/escape_manual_module.dart';
import '../../../../feed/presentation/compose_tweet/compose_tweet_controller.dart';
import '../../../../feed/presentation/compose_tweet/compose_tweet_page.dart';
import '../../../../feed/presentation/feed_module.dart';
import '../../../../help_center/presentation/help_center_module.dart';
import '../../../../support_center/presentation/support_center_module.dart';
import '../../../domain/states/mainboard_state.dart';

class MainboardBodyPage extends StatelessWidget {
  const MainboardBodyPage({
    super.key,
    required this.pages,
    required this.pageController,
    required this.composeTweetController,
  });

  final List<MainboardState> pages;
  final PageController pageController;
  final ComposeTweetController composeTweetController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: pages.map((e) => _buildPage(e)).toList(),
    );
  }

  Widget _buildPage(MainboardState state) {
    return state.when(
      chat: () => ChatMainModule(),
      feed: () => FeedModule(),
      escapeManual: () => EscapeManualModule(),
      compose: () => ComposeTweetPage(
        composeTweetController: composeTweetController,
      ),
      supportPoint: () => SupportCenterModule(),
      helpCenter: () => HelpCenterModule(),
    );
  }
}
