import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

import '../../../../../utils/json_util.dart';

class MockSupportCenterRepository extends Mock
    implements ISupportCenterRepository {}

void main() {
  ISupportCenterRepository supportCenterRepository;
  SupportCenterUseCase sut;

  setUp(() {
    supportCenterRepository = MockSupportCenterRepository();
    sut =
        SupportCenterUseCase(supportCenterRepository: supportCenterRepository);
  });

  group('SupportCenterUsecase', () {
    group('metadata', () {
      test('should hit repository for first access', () async {
        // arrange
        final jsonFile = "support_center/support_center_meta_data.json";
        final jsonData = await JsonUtil.getJson(from: jsonFile);

        when(supportCenterRepository.metadata()).thenAnswer(
          (_) async => right(
            SupportCenterMetadataModel.fromJson(jsonData),
          ),
        );
        // act
        await sut.metadata();
        // assert
        verify(supportCenterRepository.metadata());
      });

      test('should avoid hit repository twice', () async {
        final jsonFile = "support_center/support_center_meta_data.json";
        final jsonData = await JsonUtil.getJson(from: jsonFile);

        when(supportCenterRepository.metadata()).thenAnswer(
          (_) async => right(
            SupportCenterMetadataModel.fromJson(jsonData),
          ),
        );
        await sut.metadata();
        // act
        await sut.metadata();
        // assert
        verify(supportCenterRepository.metadata()).called(1);
      });
    });
  });
}
