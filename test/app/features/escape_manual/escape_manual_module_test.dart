import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/escape_manual/escape_manual_module.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_controller.dart';

void main() {
  setUp(() {
    initModules(
      [
        AppModule(),
        EscapeManualModule(),
      ],
      replaceBinds: [
        Bind<IApiProvider>((i) => ApiProviderMock()),
      ],
    );
  });

  group(
    EscapeManualModule,
    () {
      test(
        'should have EscapeManualController instance',
        () {
          // act
          final controller = Modular.get<EscapeManualController>();

          // assert
          expect(controller, isNotNull);
        },
      );
    },
  );
}

class ApiProviderMock extends Mock implements IApiProvider {}
