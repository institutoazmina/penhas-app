import 'package:flutter/material.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class SupportCenterRateDescription extends StatelessWidget {
  const SupportCenterRateDescription({
    Key? key,
    required this.detail,
  }) : super(key: key);

  final SupportCenterPlaceDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    final bool hasRate = detail.place!.rate!.contains('n/a');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: hasRate ? _withoutRate() : _withRate(),
    );
  }

  Widget _withoutRate() {
    return RichText(
      text: TextSpan(
        text: 'Este local não tem avaliação',
        style: rateDescriptionTextStyle,
      ),
    );
  }

  Widget _withRate() {
    return RichText(
      text: TextSpan(
        text: 'Este local tem ',
        style: rateDescriptionTextStyle,
        children: [
          const WidgetSpan(
            child: Icon(
              Icons.star,
              color: DesignSystemColors.pumpkinOrange,
            ),
          ),
          TextSpan(
            text: detail.place!.rate,
            style: rateValueTextStyle,
          )
        ],
      ),
    );
  }
}

extension _TextStyle on SupportCenterRateDescription {
  TextStyle get rateDescriptionTextStyle => const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontFamily: 'Lato',
        letterSpacing: 0.45,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      );
  TextStyle get rateValueTextStyle => const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontFamily: 'Lato',
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      );
}
