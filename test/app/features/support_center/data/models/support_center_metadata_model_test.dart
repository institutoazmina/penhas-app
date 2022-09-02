import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/filters/data/models/filter_tag_model.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  String? supportCenterMetadataFile;

  setUp(() {
    supportCenterMetadataFile = 'support_center/support_center_meta_data.json';
  });

  group('SupportCenterMetadataModel', () {
    test('should a subclass of SupportCenterMetadataEntity', () async {
      // act
      const model = SupportCenterMetadataModel(
        categories: null,
        projects: null,
      );
      expect(model, isA<SupportCenterMetadataEntity>());
    });
    test(
      'should return a valid list of SupportCenterMetadataEntity from a valid Json',
      () async {
        // arrange
        final jsonData =
            await JsonUtil.getJson(from: supportCenterMetadataFile);
        const actual = SupportCenterMetadataModel(
          categories: [
            FilterTagModel(
              id: '8',
              label: 'Casa da Mulher Brasileira',
              isSelected: false,
            ),
            FilterTagModel(
              id: '1',
              label: 'Centros de Atendimento',
              isSelected: false,
            ),
            FilterTagModel(
              id: '6',
              label: 'Centros de atendimento à mulher',
              isSelected: false,
            ),
          ],
          projects: [
            FilterTagModel(id: '3', label: 'MAMU', isSelected: false),
            FilterTagModel(id: '2', label: 'Mapa Delegacia', isSelected: false),
            FilterTagModel(id: '1', label: 'Penhas', isSelected: false),
          ],
        );
        // act
        final matcher = SupportCenterMetadataModel.fromJson(jsonData);
        // assert
        expect(actual, matcher);
      },
    );
  });
}
