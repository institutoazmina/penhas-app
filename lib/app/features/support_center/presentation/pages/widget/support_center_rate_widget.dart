import 'package:flutter/material.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../domain/entities/support_center_place_detail_entity.dart';
import '../support_center_rate_description.dart';
import 'smooth_star_rating_widget.dart';

class SupportCenterRateWidget extends StatelessWidget {
  const SupportCenterRateWidget({
    super.key,
    required this.detail,
    required this.onRated,
  });

  final SupportCenterPlaceDetailEntity detail;
  final void Function(double) onRated;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignSystemColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      height: 280,
      child: Column(
        children: [
          Text('Avaliações', style: rateTitleTextStyle),
          SupportCenterRateDescription(detail: detail),
          Text(
            'Avalie esse ponto de apoio para ajudar mulheres em situações de violência.',
            style: rateActionDescription,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SmoothStarRatingWidget(
              allowHalfRating: false,
              onRatingChanged: onRated,
              rating: detail.ratedByClient!.toDouble(),
              size: 40.0,
              color: DesignSystemColors.pumpkinOrange,
              borderColor: DesignSystemColors.pumpkinOrange,
            ),
          )
        ],
      ),
    );
  }
}

extension _TextStyle on SupportCenterRateWidget {
  TextStyle get rateTitleTextStyle => const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontFamily: 'Lato',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      );
  TextStyle get rateActionDescription => const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontFamily: 'Lato',
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.45,
      );
}
