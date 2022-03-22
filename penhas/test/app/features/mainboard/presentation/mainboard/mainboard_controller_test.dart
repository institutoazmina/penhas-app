import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/network/network_info.dart';

import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_module.dart';

import '../../../../../utils/aditional_bind_module.dart';
import '../../../../../utils/helper.mocks.dart';

void main() {
  initModules([
    AditionalBindModule(
      binds: [
        Bind.singleton<INetworkInfo>((i) => MockINetworkInfo()),
      ],
    ),
    MainboardModule(),
  ]);
  // MainboardController mainboard;
  //
  setUp(() {
    //     mainboard = MainboardModule.to.get<MainboardController>();
  });

  group('MainboardController Test', () {
    //   test("First Test", () {
    //     expect(mainboard, isInstanceOf<MainboardController>());
    //   });

    //   test("Set Value", () {
    //     expect(mainboard.value, equals(0));
    //     mainboard.increment();
    //     expect(mainboard.value, equals(1));
    //   });
  });
}
