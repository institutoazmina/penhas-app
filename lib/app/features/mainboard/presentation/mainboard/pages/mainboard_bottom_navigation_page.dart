import 'package:flutter/material.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../domain/states/mainboard_state.dart';
import 'mainboard_button_page.dart';

class MainboardBottomNavigationPage extends StatelessWidget {
  const MainboardBottomNavigationPage({
    super.key,
    required this.pages,
    required this.currentPage,
    required this.onSelect,
  });

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
      shape: const CircularNotchedRectangle(),
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
    super.key,
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

    return page.maybeWhen(
      helpCenter: () => SizedBox(
        width: 60,
        child: Center(
          child: Text(
            page.label,
            maxLines: 2,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 12,
              color: textColor,
            ),
          ),
        ),
      ),
      orElse: () => MainboarButtonPage(
        page: page,
        selectedPage: selectedPage,
        onSelect: onSelect,
      ),
    );
  }
}
