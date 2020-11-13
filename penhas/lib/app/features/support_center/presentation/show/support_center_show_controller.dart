import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_show_state.dart';

part 'support_center_show_controller.g.dart';

class SupportCenterShowController = _SupportCenterShowControllerBase
    with _$SupportCenterShowController;

abstract class _SupportCenterShowControllerBase with Store {
  @observable
  SupportCenterShowState state = SupportCenterShowState.initial();
}
