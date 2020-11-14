import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_place_detail_model.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  String supportCenterJsonFile;

  setUp(() {
    supportCenterJsonFile = "support_center/support_center_place_detail.json";
  });

  group('SupportCenterPlaceDetailModel', () {
    test('should a subclass of SupportCenterMetadataEntity', () async {
      // act
      final model = SupportCenterPlaceDetailModel(
        maximumRate: null,
        ratedByClient: null,
      );
      expect(model, isA<SupportCenterPlaceDetailEntity>());
    });
    test(
      'should return a valid SupportCenterMetadataEntity from a valid Json',
      () async {
        // arrange
        final jsonData = await JsonUtil.getJson(from: supportCenterJsonFile);
        final actual = SupportCenterPlaceDetailModel(
          maximumRate: 5,
          ratedByClient: 0,
        );
        // act
        final matcher = SupportCenterPlaceDetailModel.fromJson(jsonData);
        // assert
        expect(actual, matcher);
      },
    );
  });
}
