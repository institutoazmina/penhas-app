import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:penhas/app/features/zodiac/domain/entities/izodiac.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class ZodiacFellingPage extends StatelessWidget {
  final IZodiac sign;
  const ZodiacFellingPage({
    @required this.sign,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Hoje estou me sentido:',
            style: kTextStyleZodiacFellingTitle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Tags(
            spacing: 8.0,
            symmetry: false,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            itemCount: sign.feeling.length,
            itemBuilder: (int index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
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
