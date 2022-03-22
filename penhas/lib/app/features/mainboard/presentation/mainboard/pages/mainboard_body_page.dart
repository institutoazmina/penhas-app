import 'package:flutter/material.dart';
import 'package:penhas/app/features/chat/presentation/chat_main_module.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_page.dart';
import 'package:penhas/app/features/feed/presentation/feed_module.dart';
import 'package:penhas/app/features/help_center/presentation/help_center_module.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/features/support_center/presentation/support_center_module.dart';

class MainboardBodyPage extends StatelessWidget {
  const MainboardBodyPage({
    Key? key,
    required this.pages,
    required this.pageController,
  }) : super(key: key);

  final List<MainboardState> pages;
  final PageController pageController;

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
      compose: () => const ComposeTweetPage(),
      supportPoint: () => SupportCenterModule(),
      helpCenter: () => HelpCenterModule(),
    );
  }
}
