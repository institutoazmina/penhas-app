import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class MainboarButtonPage extends StatelessWidget {
  final MainboardState currentPage;
  final MainboardState? pageSelected;
  final void Function(MainboardState) onSelect;

  const MainboarButtonPage({
    required Key key,
    required this.onSelect,
    required this.currentPage,
    required this.pageSelected,
  }) : super(key: key);

  final MainboardState currentPage;
  final MainboardState? pageSelected;
  final void Function(MainboardState) onSelect;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () => onSelect(currentPage),
        child: _buildBottomBarIcon(
          this.currentPage,
          this.pageSelected!,
        ),
      ),
    );
  }

  Widget _buildBottomBarIcon(MainboardState current, MainboardState selected) {
    String asset;
    const String rootPath = 'assets/images/svg/bottom_bar';

    asset = current.when(
      chat: () => '$rootPath/chat.svg',
      feed: () => '$rootPath/feed.svg',
      compose: () => '$rootPath/compose_tweet.svg',
      supportPoint: () => '$rootPath/support_point.svg',
      helpCenter: () => '$rootPath/emergency_controll.svg',
    );

    if (current == selected) {
      asset = current.when(
        chat: () => '$rootPath/chat_selected.svg',
        feed: () => '$rootPath/feed_selected.svg',
        compose: () => '$rootPath/compose_tweet_selected.svg',
        supportPoint: () => '$rootPath/support_point_selected.svg',
        helpCenter: () => '$rootPath/emergency_controll.svg',
      );
    }

    final assetColor = selected.maybeWhen(
        helpCenter: () => DesignSystemColors.white,
        orElse: () => DesignSystemColors.buttonBarIconColor,);

    return SvgPicture.asset(asset, color: assetColor);
  }
}
