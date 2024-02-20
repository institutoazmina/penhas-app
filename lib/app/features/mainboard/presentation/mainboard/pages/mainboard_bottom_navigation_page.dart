import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final ValueChanged<MainboardState> onSelect;

  @override
  Widget build(BuildContext context) {
    final bottomColor = currentPage.maybeWhen(
      helpCenter: () => DesignSystemColors.helpCenterButtonBar,
      orElse: () => DesignSystemColors.white,
    );

    return BottomAppBar(
      notchMargin: 0,
      elevation: 20.0,
      color: bottomColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: pages
              .map(
                (page) => MainboardNavigationButton(
                  page: page,
                  selectedPage: currentPage,
                  onSelect: () => onSelect(page),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class MainboardNavigationButton extends StatelessWidget {
  const MainboardNavigationButton({
    required this.page,
    required this.selectedPage,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  final MainboardState page;
  final MainboardState selectedPage;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return page.maybeWhen(
      helpCenter: () => HelpCenterButtonPage(
        page: page,
        selectedPage: selectedPage,
        onSelect: onSelect,
      ),
      orElse: () => MainboarButtonPage(
        page: page,
        selectedPage: selectedPage,
        onSelect: onSelect,
      ),
    );
  }
}

class HelpCenterButtonPage extends StatelessWidget {
  const HelpCenterButtonPage({
    Key? key,
    required this.page,
    required this.selectedPage,
    required this.onSelect,
  }) : super(key: key);

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

    return SizedOverflowBox(
      size: const Size(64, kBottomNavigationBarHeight),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: 60,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: DesignSystemColors.ligthPurple,
                  onPressed: onSelect,
                  child: SvgPicture.asset(
                    'assets/images/svg/bottom_bar/emergency_controll.svg',
                    color: Colors.white,
                    semanticsLabel: page.label,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              page.label,
              maxLines: 2,
              style: theme.textTheme.caption?.copyWith(
                fontSize: 12,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
