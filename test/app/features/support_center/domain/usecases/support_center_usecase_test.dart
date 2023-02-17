import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

import '../../../../../utils/json_util.dart';

class MockSupportCenterRepository extends Mock
    implements ISupportCenterRepository {}

class MockLocationServices extends Mock implements ILocationServices {}

void main() {
  late SupportCenterUseCase sut;
  late ILocationServices locationServices;
  late ISupportCenterRepository supportCenterRepository;

  setUp(() {
    locationServices = MockLocationServices();
    supportCenterRepository = MockSupportCenterRepository();

    sut = SupportCenterUseCase(
      locationService: locationServices,
      supportCenterRepository: supportCenterRepository,
    );
  });

  group(SupportCenterUseCase, () {
    group('metadata', () {
      test('hit repository for first access', () async {
        // arrange
        const jsonFile = 'support_center/support_center_meta_data.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);

        when(() => supportCenterRepository.metadata()).thenAnswer(
          (_) async => right(
            SupportCenterMetadataModel.fromJson(jsonData),
          ),
        );
        // act
        await sut.metadata();
        // assert
        verify(() => supportCenterRepository.metadata()).called(1);
      });

      test('avoid hit repository twice', () async {
        const jsonFile = 'support_center/support_center_meta_data.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);

        when(() => supportCenterRepository.metadata()).thenAnswer(
          (_) async => right(SupportCenterMetadataModel.fromJson(jsonData)),
        );
        await sut.metadata();
        // act
        await sut.metadata();
        // assert
        verify(() => supportCenterRepository.metadata()).called(1);
      });
    });
  });
}
