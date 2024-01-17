import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/escape_manual/escape_manual_module.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_page.dart';

import '../../../utils/module_testing.dart';

void main() {
  group(EscapeManualModule, () {
    testWidgets(
      'should start with EscapeManualPage widget',
      (tester) async {
        // arrange
        await tester.pumpWidget(
          buildTestableApp(
            home: EscapeManualModule(),
            overrides: [
              Bind<IApiProvider>((i) => _MockApiProvider()),
              Bind<ILocalStorage>((i) => _MockLocalStorage()),
            ],
          ),
        );
        await tester.pump();

        // assert
        expect(find.byType(EscapeManualPage), findsOneWidget);
      },
    );
  });
}

class _MockApiProvider extends Mock implements IApiProvider {}

class _MockLocalStorage extends Mock implements ILocalStorage {}
