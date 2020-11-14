import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_place_detail_model.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail.dart';

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
      expect(model, isA<SupportCenterPlaceDetail>());
    });
    // test(
    //   'should return a valid list of SupportCenterMetadataEntity from a valid Json',
    //   () async {
    //     // arrange
    //     final jsonData =
    //         await JsonUtil.getJson(from: supportCenterMetadataFile);
    //     final actual = SupportCenterMetadataModel(
    //       categories: [
    //         FilterTagModel(
    //           id: "8",
    //           label: "Casa da Mulher Brasileira",
    //           isSelected: false,
    //         ),
    //         FilterTagModel(
    //           id: "1",
    //           label: "Centros de Atendimento",
    //           isSelected: false,
    //         ),
    //         FilterTagModel(
    //           id: "6",
    //           label: "Centros de atendimento à mulher",
    //           isSelected: false,
    //         ),
    //       ],
    //       projects: [
    //         FilterTagModel(id: "3", label: "MAMU", isSelected: false),
    //         FilterTagModel(id: "2", label: "Mapa Delegacia", isSelected: false),
    //         FilterTagModel(id: "1", label: "Penhas", isSelected: false),
    //       ],
    //     );
    //     // act
    //     final matcher = SupportCenterMetadataModel.fromJson(jsonData);
    //     // assert
    //     expect(actual, matcher);
    //   },
    // );
  });
}
