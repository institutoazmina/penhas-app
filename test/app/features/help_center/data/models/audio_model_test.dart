import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/help_center/data/models/audio_model.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  setUp(() {});

  group('AudioModel', () {
    test('should return a valid list of AudioEntity from a valid Json',
        () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: 'audios/audios_fetch.json');
      final actual = [
        AudioEntity(
            id: 'c6711926-0ca8-47fd-bed3-5a803c422904',
            audioDuration: '0m55s',
            createdAt: DateTime.parse('2020-08-15T17:23:06Z').toLocal(),
            canPlay: true,
            isRequested: false,
            isRequestGranted: false,),
        AudioEntity(
            id: '6db0260b-9733-4610-9586-de5141d79c32',
            audioDuration: '2m18s',
            createdAt: DateTime.parse('2020-08-15T16:58:54Z').toLocal(),
            canPlay: false,
            isRequested: true,
            isRequestGranted: false,)
      ];
      // act
      final matcher = AudioModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
  });
}
