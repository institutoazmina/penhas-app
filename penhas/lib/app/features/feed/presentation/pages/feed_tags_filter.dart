import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class FeedTagsFilter extends StatelessWidget {
  const FeedTagsFilter({
    required Key key,
    required this.reloadFeed,
  }) : super(key: key);

  final void Function() reloadFeed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      width: 160.0,
      child: RaisedButton(
        elevation: 0.0,
        onPressed: () async {
          Modular.to.pushNamed('/mainboard/tags').then(
            (reload) {
              if (reload as bool? ?? false) {
                reloadFeed();
              }
            },
          );
        },
        color: DesignSystemColors.white,
        shape: kButtonShapeOutlinePurple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Icon(
              Icons.filter_list,
              color: DesignSystemColors.ligthPurple,
              size: 22.0,
            ),
            Text('Filtros por temas', style: kTextStyleFeedCategoryButtonLabel),
          ],
        ),
      ),
    );
  }
}
