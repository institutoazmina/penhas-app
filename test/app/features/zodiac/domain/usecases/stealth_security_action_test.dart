import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/stealth_security_action.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';


class MockAudioServices extends Mock implements IAudioRecordServices {}
class MockLocationServices extends Mock implements ILocationServices {}
class MockGuardianRepository extends Mock implements IGuardianRepository {}
class MockFeatureToggle extends Mock implements SecurityModeActionFeature{}
void main() {
  late ILocationServices locationServices;
  late IAudioRecordServices audioRecordServices;
  late IGuardianRepository guardianRepository;
  late SecurityModeActionFeature featureToggle;

  group(StealthSecurityAction, () {
    late StealthSecurityAction sut;
    
    locationServices = MockLocationServices();
    audioRecordServices = MockAudioServices();
    guardianRepository = MockGuardianRepository();
    featureToggle = MockFeatureToggle();

    setUp(() {
      sut = StealthSecurityAction(
          locationService: locationServices,
          audioServices: audioRecordServices, 
          guardianRepository: guardianRepository,
          featureToogle: featureToggle);
    });

     test('should record user message', () {
          // arrange
          
          // act
          
          // assert
          
        });

      test('should send sms to guardian', () {

          // arrange

          // act

          // assert
      });
  });
}
