import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  IApiProvider apiProvider;
  ISupportCenterRepository sut;

  setUp(() {
    apiProvider = MockApiProvider();
    sut = SupportCenterRepository(apiProvider: apiProvider);
  });

  group('SupportCenterRepository', () {
    test('metadata should return valid objects from server', () async {
      // arrange
      final supportCenterMetadataFile =
          "support_center/support_center_meta_data.json";
      final jsonData = await JsonUtil.getJson(from: supportCenterMetadataFile);
      final actual = right(SupportCenterMetadataModel.fromJson(jsonData));
      when(
        apiProvider.get(
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: supportCenterMetadataFile));
      // act
      final matcher = await sut.metadata();
      // assert
      expect(actual, matcher);
    });
  });
}
