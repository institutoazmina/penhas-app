import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';

part 'audio_record_controller.g.dart';

class AudioRecordController extends _AudioRecordController
    with _$AudioRecordController {}

abstract class _AudioRecordController with Store, MapFailureMessage {}
