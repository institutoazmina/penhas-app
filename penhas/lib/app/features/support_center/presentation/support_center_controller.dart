import 'dart:ffi';

import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

part 'support_center_controller.g.dart';

class SupportCenterController extends _SupportCenterControllerBase
    with _$SupportCenterController {
  SupportCenterController();
}

abstract class _SupportCenterControllerBase with Store {
  @action
  Future<void> onFilterAction() async {
    print("Ola mundo!");
  }

  @action
  Future<void> onKeywordsAction(String keywords) async {
    print(keywords);
  }
}
