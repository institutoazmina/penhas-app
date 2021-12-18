import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_place_session_model.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  String? supportCenterSessionFile;

  setUp(() {
    supportCenterSessionFile =
        'support_center/support_center_list_of_place.json';
  });

  group('SupportCenterPlaceSessionModel', () {
    test('should a subclass of SupportCenterPlaceSessionEntity', () async {
      // act
      const model = SupportCenterPlaceSessionModel(
        null,
        null,
        null,
        null,
        null,
        null,
      );
      // assert
      expect(model, isA<SupportCenterPlaceSessionEntity>());
    });
    test(
        'should return a valid SupportCenterPlaceSessionEntity object from a valid json',
        () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: supportCenterSessionFile);
      const actual = SupportCenterPlaceSessionModel(
        5,
        -23.52901,
        -46.6504,
        false,
        null,
        [
          SupportCenterPlaceEntity(
            id: '2676',
            rate: 'n/a',
            ratedByClient: 0,
            distance: '4',
            latitude: -23.557338,
            longitude: -46.625331,
            name: '1ª Delegacia de Defesa da Mulher - São Paulo',
            uf: 'SP',
            category: SupportCenterPlaceCategoryEntity(
              id: 5,
              name: 'Delegacias da mulher',
              color: '#F982B4',
            ),
            fullStreet: null,
            htmlContent: null,
            typeOfPlace: null,
          )
        ],
      );
      // act
      final matcher = SupportCenterPlaceSessionModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
  });
}
