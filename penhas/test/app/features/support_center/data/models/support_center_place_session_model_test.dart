import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_place_session_model.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';

void main() {
  String supportCenterSessionFile;

  setUp(() {
    supportCenterSessionFile =
        "support_center/support_center_list_of_place.json";
  });

  group('SupportCenterPlaceSessionModel', () {
    test('should a subclass of SupportCenterPlaceSessionEntity', () async {
      // act
      final model = SupportCenterPlaceSessionModel();
      // assert
      expect(model, isA<SupportCenterPlaceSessionEntity>());
    });
  });
}
