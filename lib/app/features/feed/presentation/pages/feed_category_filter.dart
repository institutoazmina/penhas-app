import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';

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
      child: PenhasButton.roundedOutlined(
        onPressed: () async {
          Modular.to.pushNamed('/mainboard/category').then((reload) {
            if (reload == true) {
              reloadFeed();
            }
          });
        },
        child: Row(
          children: const <Widget>[
            Icon(
              Icons.arrow_drop_down,
              color: DesignSystemColors.ligthPurple,
              size: 30,
            ),
            Text('Categorias', style: kTextStyleFeedCategoryButtonLabel),
          ],
        ),
      ),
    );
  }
}
