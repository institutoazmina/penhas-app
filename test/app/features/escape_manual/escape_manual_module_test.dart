import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/escape_manual/escape_manual_module.dart';
import 'package:penhas/app/features/escape_manual/presentation/edit/edit_trusted_contacts_page.dart';
import 'package:penhas/app/features/escape_manual/presentation/escape_manual_page.dart';
import 'package:penhas/app/shared/navigation/app_navigator.dart';
import 'package:penhas/app/shared/navigation/app_route.dart';

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

    testWidgets(
      'should show EditTrustedContactsPage when navigate to /edit/trusted_contacts',
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

        // act
        AppNavigator.push(AppRoute('/edit/trusted_contacts'));
        await tester.pumpAndSettle();

        // assert
        expect(find.byType(EditTrustedContactsPage), findsOneWidget);
      },
    );
  });
}

class _MockApiProvider extends Mock implements IApiProvider {}

class _MockLocalStorage extends Mock implements ILocalStorage {}
