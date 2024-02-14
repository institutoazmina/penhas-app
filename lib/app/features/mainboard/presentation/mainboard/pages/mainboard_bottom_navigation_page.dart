import 'package:flutter/material.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../domain/states/mainboard_state.dart';
import 'mainboard_button_page.dart';

class MainboardBottomNavigationPage extends StatelessWidget {
  const MainboardBottomNavigationPage({
    Key? key,
    required this.pages,
    required this.currentPage,
    required this.onSelect,
  }) : super(key: key);

  final MainboardState currentPage;
  final List<MainboardState> pages;
  final void Function(MainboardState) onSelect;

  @override
  Widget build(BuildContext context) {
    final bottomColor = currentPage.maybeWhen(
      helpCenter: () => DesignSystemColors.helpCenterButtonBar,
      orElse: () => DesignSystemColors.white,
    );

    return SizedOverflowBox(
      size: const Size.fromHeight(kBottomNavigationBarHeight),
      child: BottomAppBar(
        elevation: 20.0,
        color: bottomColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: _buildButtons(),
        ),
      ),
    );
  }

  List<Widget> _buildButtons() {
    return pages
        .map(
          (page) => page.maybeWhen(
            helpCenter: () => _HelpCenterPlaceholder(
              page: page,
              selectedPage: currentPage,
            ),
            orElse: () => MainboarButtonPage(
              page: page,
              selectedPage: currentPage,
              onSelect: onSelect,
            ),
          ),
        )
        .toList();
  }
}

class _HelpCenterPlaceholder extends StatelessWidget {
  const _HelpCenterPlaceholder({
    Key? key,
    required this.page,
    required this.selectedPage,
  }) : super(key: key);

  final MainboardState page;
  final MainboardState selectedPage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = selectedPage.maybeWhen(
      helpCenter: () => DesignSystemColors.white,
      orElse: () => DesignSystemColors.buttonBarIconColor,
    );

    return Container(
      width: 64,
      height: kBottomNavigationBarHeight,
      alignment: AlignmentDirectional.bottomCenter,
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        page.label,
        textAlign: TextAlign.center,
        style: theme.textTheme.caption?.copyWith(
          fontSize: 12,
          color: textColor,
        ),
      ),
    );
  }
}
