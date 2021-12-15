import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_place_detail_model.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  String? supportCenterJsonFile;

  setUp(() {
    supportCenterJsonFile = 'support_center/support_center_place_detail.json';
  });

  group('SupportCenterPlaceDetailModel', () {
    test('should a subclass of SupportCenterMetadataEntity', () async {
      // act
      const model = SupportCenterPlaceDetailModel(
        place: null,
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
        const actual = SupportCenterPlaceDetailModel(
            maximumRate: 5,
            ratedByClient: 0,
            place: SupportCenterPlaceEntity(
              id: "2566",
              rate: "n/a",
              ratedByClient: 0,
              distance: null,
              latitude: -23.482957,
              longitude: -46.730177,
              name: '9º Delegacia de Polícia de Defesa da Mulher - Oeste',
              uf: 'SP',
              category: SupportCenterPlaceCategoryEntity(
                id: 5,
                name: 'Delegacias da mulher',
                color: '#F982B4',
              ),
              fullStreet:
                  'Avenida Menotti Laudísio, 286 - Pirituba, São Paulo -  SP, 02945000',
              htmlContent:
                  '<p style="color: #0a115f"></p><br/><p style="color: #0a115f"><b>Endereço</b></p><p style="color: #818181;">Avenida Menotti Laudísio, 286 -Pirituba -São Paulo, SP, 02945000 </p>',
              typeOfPlace: 'Público',
            ),);
        // act
        final matcher = SupportCenterPlaceDetailModel.fromJson(jsonData);
        // assert
        expect(actual, matcher);
      },
    );
  });
}
