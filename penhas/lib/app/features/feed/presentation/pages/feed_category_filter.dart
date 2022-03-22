import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class FeedCategoryFilter extends StatelessWidget {
  const FeedCategoryFilter({
    Key? key,
    required this.reloadFeed,
  }) : super(key: key);

  final void Function() reloadFeed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      width: 140.0,
      child: RaisedButton(
        elevation: 0.0,
        onPressed: () async {
          Modular.to.pushNamed('/mainboard/category').then((reload) {
            if (reload == true) {
              reloadFeed();
            }
          });
        },
        color: DesignSystemColors.white,
        shape: kButtonShapeOutlinePurple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text('Categorias', style: kTextStyleFeedCategoryButtonLabel),
            Icon(
              Icons.arrow_drop_down,
              color: DesignSystemColors.ligthPurple,
              size: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
