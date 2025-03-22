import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';

class FeedCategoryFilter extends StatelessWidget {
  const FeedCategoryFilter({
    super.key,
    required this.reloadFeed,
  });

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
        child: const Row(
          children: <Widget>[
            Icon(
              Icons.arrow_drop_down,
              color: DesignSystemColors.ligthPurple,
            ),
            Text('Categorias', style: kTextStyleFeedCategoryButtonLabel),
          ],
        ),
      ),
    );
  }
}
