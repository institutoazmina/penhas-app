import 'package:flutter/material.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_rate_description.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SupportCenterRate extends StatelessWidget {
  const SupportCenterRate({
    required Key key,
    required this.detail,
    required this.onRated,
  }) : super(key: key);

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
            child: SmoothStarRating(
                allowHalfRating: false,
                onRated: onRated,
                starCount: 5,
                rating: detail.ratedByClient!.toDouble(),
                size: 40.0,
                isReadOnly: false,
                color: DesignSystemColors.pumpkinOrange,
                borderColor: DesignSystemColors.pumpkinOrange,
                spacing: 0.0),
          )
        ],
      ),
    );
  }
}

extension _TextStyle on SupportCenterRate {
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
