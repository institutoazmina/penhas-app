import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late MockISupportCenterRepository supportCenterRepository =
      MockISupportCenterRepository();
  late MockILocationServices locationServices = MockILocationServices();
  late SupportCenterUseCase sut;

  setUp(() {
    sut = SupportCenterUseCase(
      locationService: locationServices,
      supportCenterRepository: supportCenterRepository,
    );
  });

  group('SupportCenterUsecase', () {
    group('metadata', () {
      test('should hit repository for first access', () async {
        // arrange
        const jsonFile = 'support_center/support_center_meta_data.json';
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
        const jsonFile = 'support_center/support_center_meta_data.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);

        when(supportCenterRepository.metadata()).thenAnswer(
          (_) => Future.value(
            right(SupportCenterMetadataModel.fromJson(jsonData)),
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
