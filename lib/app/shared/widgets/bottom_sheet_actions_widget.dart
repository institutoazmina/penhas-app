import 'package:flutter/material.dart';

class BottomSheetActionsContentWidget extends StatefulWidget {
  BottomSheetActionsContentWidget({
    super.key,
    required this.actions,
  }) {
    assert(actions.isNotEmpty);
  }

  final List<Widget> actions;

  @override
  State<BottomSheetActionsContentWidget> createState() =>
      _BottomSheetActionsContentWidgetState();
}

class _BottomSheetActionsContentWidgetState
    extends State<BottomSheetActionsContentWidget> {
  List<Widget> get actions => widget.actions;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 5),
        constraints: const BoxConstraints(minHeight: 150),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const _BottomSheetDivider(),
            ...actions,
          ],
        ),
      );
}

class _BottomSheetDivider extends StatelessWidget {
  const _BottomSheetDivider();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Container(
          width: constraints.maxWidth * .2,
          height: 5,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      );
}
