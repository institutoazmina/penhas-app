import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../domain/states/mainboard_state.dart';

class MainboarButtonPage extends StatelessWidget {
  const MainboarButtonPage({
    super.key,
    required this.page,
    required this.selectedPage,
    required this.onSelect,
  });

  final MainboardState page;
  final MainboardState selectedPage;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor = selectedPage.maybeWhen(
      helpCenter: () => DesignSystemColors.white,
      orElse: () => DesignSystemColors.buttonBarIconColor,
    );

    return Expanded(
      child: InkResponse(
        onTap: onSelect,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: kBottomNavigationBarHeight,
            minWidth: 80,
            maxWidth: 168,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _BottomBarIcon(
                  current: page,
                  selected: selectedPage,
                ),
                const SizedBox(height: 2),
                Text(
                  page.label,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    color: textColor,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomBarIcon extends StatelessWidget {
  const _BottomBarIcon({
    required this.current,
    required this.selected,
  });

  final MainboardState current;
  final MainboardState selected;

  @override
  Widget build(BuildContext context) {
    String asset;
    const String rootPath = 'assets/images/svg/bottom_bar';

    if (current != selected) {
      asset = current.when(
        chat: () => '$rootPath/chat.svg',
        feed: () => '$rootPath/feed.svg',
        escapeManual: () => '$rootPath/escape_manual.svg',
        compose: () => '$rootPath/compose_tweet.svg',
        supportPoint: () => '$rootPath/support_point.svg',
        helpCenter: () => '$rootPath/emergency_controll.svg',
      );
    } else {
      asset = current.when(
        chat: () => '$rootPath/chat_selected.svg',
        feed: () => '$rootPath/feed_selected.svg',
        escapeManual: () => '$rootPath/escape_manual_selected.svg',
        compose: () => '$rootPath/compose_tweet_selected.svg',
        supportPoint: () => '$rootPath/support_point_selected.svg',
        helpCenter: () => '$rootPath/emergency_controll.svg',
      );
    }

    final assetColor = selected.maybeWhen(
      helpCenter: () => DesignSystemColors.white,
      orElse: () => DesignSystemColors.buttonBarIconColor,
    );

    return SizedBox.square(
      dimension: 24,
      child: SvgPicture.asset(
        asset,
        colorFilter: ColorFilter.mode(assetColor, BlendMode.srcIn),
        fit: BoxFit.contain,
        excludeFromSemantics: true,
      ),
    );
  }
}

extension MainboardStateExtension on MainboardState {
  String get label => when(
        feed: () => 'Início',
        compose: () => 'Publicar',
        escapeManual: () => 'Manual de Fuga',
        helpCenter: () => 'Socorro',
        chat: () => 'Chat',
        supportPoint: () => 'Pontos de Apoio',
      );
}
