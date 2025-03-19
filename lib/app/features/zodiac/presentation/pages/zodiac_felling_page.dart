import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/tags/tags.dart';
import '../../domain/entities/izodiac.dart';

class ZodiacFellingPage extends StatelessWidget {
  const ZodiacFellingPage({
    required this.sign,
    super.key,
  });

  final IZodiac sign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            'Hoje estou me sentido:',
            style: kTextStyleZodiacFellingTitle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Tags(
            spacing: 8.0,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            itemCount: sign.feeling.length,
            itemBuilder: (int index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: const BoxDecoration(
                  color: DesignSystemColors.easterPurple,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  sign.feeling[index],
                  style: kTextStyleZodiacFelling,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
