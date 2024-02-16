import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../domain/states/mainboard_state.dart';

class MainboarButtonPage extends StatelessWidget {
  const MainboarButtonPage({
    Key? key,
    required this.page,
    required this.selectedPage,
    required this.onSelect,
  }) : super(key: key);

  final MainboardState page;
  final MainboardState selectedPage;
  final ValueChanged<MainboardState> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor = selectedPage.maybeWhen(
      helpCenter: () => DesignSystemColors.white,
      orElse: () => DesignSystemColors.buttonBarIconColor,
    );

    return Expanded(
      child: InkResponse(
        onTap: () => onSelect(page),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBottomBarIcon(
                page,
                selectedPage,
              ),
              const SizedBox(height: 2),
              Text(
                page.label,
                textAlign: TextAlign.center,
                softWrap: true,
                style: theme.textTheme.caption?.copyWith(
                  fontSize: 12,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBarIcon(MainboardState current, MainboardState selected) {
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

    return SvgPicture.asset(
      asset,
      color: assetColor,
      width: 24,
      height: 24,
      fit: BoxFit.contain,
      excludeFromSemantics: true,
    );
  }
}

extension MainboardStateExtension on MainboardState {
  String get label => when(
        feed: () => 'Ínicio',
        compose: () => 'Publicar',
        escapeManual: () => 'Manual de Fuga',
        helpCenter: () => 'Socorro',
        chat: () => 'Chat',
        supportPoint: () => 'Pontos de Apoio',
      );
}
