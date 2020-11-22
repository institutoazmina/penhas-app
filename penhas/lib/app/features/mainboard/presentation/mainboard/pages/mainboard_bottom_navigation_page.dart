import 'package:flutter/material.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'mainboard_button_page.dart';

class MainboardBottomNavigationPage extends StatelessWidget {
  final MainboardState currentPage;
  final List<MainboardState> pages;
  final void Function(MainboardState) onSelect;

  const MainboardBottomNavigationPage({
    Key key,
    @required this.currentPage,
    @required this.pages,
    @required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomColor = currentPage.maybeWhen(
      helpCenter: () => DesignSystemColors.helpCenterButtonBar,
      orElse: () => DesignSystemColors.white,
    );

    return BottomAppBar(
      elevation: 20.0,
      color: bottomColor,
      child: Container(
        height: 56,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildButtond(),
        ),
      ),
    );
  }

  List<Widget> _buildButtond() {
    return pages
        .map(
          (e) => (e == MainboardState.helpCenter())
              ? Container(width: 64)
              : MainboarButtonPage(
                  currentPage: e,
                  pageSelected: currentPage,
                  onSelect: (v) => this.onSelect(v),
                ),
        )
        .toList();
  }
}
