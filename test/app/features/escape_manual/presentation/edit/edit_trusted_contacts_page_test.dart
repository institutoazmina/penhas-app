import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/escape_manual/domain/entity/escape_manual_task.dart';
import 'package:penhas/app/features/escape_manual/domain/escape_manual_toggle.dart';
import 'package:penhas/app/features/escape_manual/presentation/edit/edit_trusted_contacts_controller.dart';
import 'package:penhas/app/features/escape_manual/presentation/edit/edit_trusted_contacts_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/test_utils.dart';
import '../../../../../utils/widget_tester_ext.dart';

const _maxTrustedContacts = 3;
const _filledContactId = 2;
const _nonFilledContactId = 1;
int get _randomContactId => Random().nextInt(_maxTrustedContacts) + 1;

final _contactName = 'Jane Doe';
final _contactPhone = '123456789';

void main() {
  late IModularNavigator mockNavigator;
  late EscapeManualToggleFeature mockToggleFeature;
  late EditTrustedContactsController controller;
  final contacts = <ContactEntity>[
    ContactEntity(
      id: _filledContactId,
      name: _contactName,
      phone: _contactPhone,
    ),
  ];

  setUp(() {
    mockToggleFeature = _MockEscapeManualToggleFeature();

    mockNavigator = _MockModularNavigator();
    Modular.navigatorDelegate = mockNavigator;

    when(() => mockToggleFeature.maxTrustedContacts)
        .thenAnswer((_) async => _maxTrustedContacts);

    controller = EditTrustedContactsController(
        contacts: contacts, escapeManualToggleFeature: mockToggleFeature);
  });

  group(EditTrustedContactsPage, () {
    testWidgets(
      'should call navigator pop when back pressed',
      (tester) async {
        // arrange
        await tester.pumpWidget(
          buildTestableWidget(EditTrustedContactsPage(
            controller: controller,
          )),
        );
        await tester.pumpAndSettle();

        // act
        final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
        widgetsAppState as WidgetsBindingObserver;
        await widgetsAppState.didPopRoute();
        await tester.pumpAndSettle();

        // assert
        verify(() => mockNavigator.pop(contacts)).called(1);
      },
    );

    testWidgets(
      'should show update contact dialog with empty fields',
      (tester) async {
        // arrange
        final contactId = _nonFilledContactId;
        await tester.pumpWidget(
          buildTestableWidget(EditTrustedContactsPage(
            controller: controller,
          )),
        );
        await tester.pumpAndSettle();

        // act
        await tester.tapAll(
          find.descendant(
            of: find.byKey(Key('trusted-contact_$contactId')),
            matching: find.byTooltip('Editar'),
          ),
        );
        await tester.pumpAndSettle();

        // assert
        expect(find.byKey(Key('contact-name-field')), findsOneWidget);
        expect(
          tester
              .widget<TextFormField>(find.byKey(Key('contact-name-field')))
              .controller
              ?.text,
          isEmpty,
        );
        expect(find.byKey(Key('contact-phone-field')), findsOneWidget);
        expect(
          tester
              .widget<TextFormField>(find.byKey(Key('contact-phone-field')))
              .controller
              ?.text,
          isEmpty,
        );
      },
    );

    testWidgets(
      'should show update contact dialog with filled fields',
      (tester) async {
        // arrange
        final contactId = _filledContactId;
        await tester.pumpWidget(
          buildTestableWidget(EditTrustedContactsPage(
            controller: controller,
          )),
        );
        await tester.pumpAndSettle();

        // act
        await tester.tapAll(
          find.descendant(
            of: find.byKey(Key('trusted-contact_$contactId')),
            matching: find.byTooltip('Editar'),
          ),
        );
        await tester.pumpAndSettle();

        // assert
        expect(find.byKey(Key('contact-name-field')), findsOneWidget);
        expect(
          tester
              .widget<TextFormField>(find.byKey(Key('contact-name-field')))
              .controller
              ?.text,
          _contactName,
        );
        expect(find.byKey(Key('contact-phone-field')), findsOneWidget);
        expect(
          tester
              .widget<TextFormField>(find.byKey(Key('contact-phone-field')))
              .controller
              ?.text,
          _contactPhone,
        );
      },
    );

    testWidgets(
      'should close dialog without changes when close button is pressed',
      (tester) async {
        // arrange
        final contactId = _randomContactId;
        final newName = 'Mary';
        final newPhone = '987654321';
        await tester.pumpWidget(
          buildTestableWidget(EditTrustedContactsPage(controller: controller)),
        );
        await tester.pumpAndSettle();

        // act
        await tester.tapAll(
          find.descendant(
            of: find.byKey(Key('trusted-contact_$contactId')),
            matching: find.byTooltip('Editar'),
          ),
        );
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(Key('contact-name-field')), newName);
        await tester.enterText(
            find.byKey(Key('contact-phone-field')), newPhone);
        await tester.tap(find.text('Fechar'));
        await tester.pumpAndSettle();

        // assert
        expect(find.text(newName), findsNothing);
        expect(find.text(newPhone), findsNothing);
      },
    );

    testWidgets(
      'should validate empty fields when save button is pressed',
      (tester) async {
        // arrange
        final contactId = _randomContactId;
        await tester.pumpWidget(
          buildTestableWidget(EditTrustedContactsPage(controller: controller)),
        );
        await tester.pumpAndSettle();

        // act
        await tester.tapAll(
          find.descendant(
            of: find.byKey(Key('trusted-contact_$contactId')),
            matching: find.byTooltip('Editar'),
          ),
        );
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(Key('contact-name-field')), '');
        await tester.enterText(find.byKey(Key('contact-phone-field')), '');
        await tester.tap(find.text('Salvar'));
        await tester.pumpAndSettle();

        // assert
        expect(find.text('Por favor informe o nome'), findsOneWidget);
        expect(find.text('Por favor informe o telefone'), findsOneWidget);
      },
    );

    testWidgets(
      'should update contact when save button is pressed',
      (tester) async {
        // arrange
        final contactId = _randomContactId;
        final newName = 'Mary';
        final newPhone = '987654321';
        await tester.pumpWidget(
          buildTestableWidget(EditTrustedContactsPage(controller: controller)),
        );
        await tester.pumpAndSettle();

        // act
        await tester.tapAll(
          find.descendant(
            of: find.byKey(Key('trusted-contact_$contactId')),
            matching: find.byTooltip('Editar'),
          ),
        );
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(Key('contact-name-field')), newName);
        await tester.enterText(
            find.byKey(Key('contact-phone-field')), newPhone);
        await tester.tap(find.text('Salvar'));
        await tester.pumpAndSettle();

        // assert
        expect(find.text(newName), findsOneWidget);
        expect(find.text(newPhone), findsOneWidget);
      },
    );

    testWidgets(
      'should show contact remove confirmation for filled item',
      (tester) async {
        // arrange
        final contactId = _filledContactId;
        await tester.pumpWidget(
          buildTestableWidget(EditTrustedContactsPage(controller: controller)),
        );
        await tester.pumpAndSettle();

        // act
        await tester.tapAll(
          find.descendant(
            of: find.byKey(Key('trusted-contact_$contactId')),
            matching: find.byTooltip('Remover'),
          ),
        );
        await tester.pumpAndSettle();

        // assert
        expect(find.text('Remover contato'), findsOneWidget);
      },
    );

    testWidgets(
      'should not show contact remove confirmation for empty item',
      (tester) async {
        // arrange
        final contactId = _nonFilledContactId;
        await tester.pumpWidget(
          buildTestableWidget(EditTrustedContactsPage(controller: controller)),
        );
        await tester.pumpAndSettle();

        // act
        await tester.tapAll(
          find.descendant(
            of: find.byKey(Key('trusted-contact_$contactId')),
            matching: find.byTooltip('Remover'),
          ),
        );
        await tester.pumpAndSettle();

        // assert
        expect(find.text('Remover contato'), findsNothing);
      },
    );

    testWidgets(
      'should not remove contact when cancel pressed',
      (tester) async {
        // arrange
        final contactId = _filledContactId;
        await tester.pumpWidget(
          buildTestableWidget(EditTrustedContactsPage(controller: controller)),
        );
        await tester.pumpAndSettle();

        // act
        await tester.tapAll(
          find.descendant(
            of: find.byKey(Key('trusted-contact_$contactId')),
            matching: find.byTooltip('Remover'),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Não'));
        await tester.pumpAndSettle();

        // assert
        expect(find.byKey(Key('trusted-contact_$contactId')), findsOneWidget);
        expect(find.text(_contactName), findsOneWidget);
        expect(find.text(_contactPhone), findsOneWidget);
      },
    );

    testWidgets(
      'should remove contact when confirm pressed',
      (tester) async {
        // arrange
        final contactId = _filledContactId;
        await tester.pumpWidget(
          buildTestableWidget(EditTrustedContactsPage(controller: controller)),
        );
        await tester.pumpAndSettle();

        // act
        await tester.tapAll(
          find.descendant(
            of: find.byKey(Key('trusted-contact_$contactId')),
            matching: find.byTooltip('Remover'),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Sim'));
        await tester.pumpAndSettle();

        // assert
        expect(find.byKey(Key('trusted-contact_$contactId')), findsOneWidget);
        expect(find.text(_contactName), findsNothing);
        expect(find.text(_contactPhone), findsNothing);
      },
    );

    group('golden', () {
      screenshotTestSimplified(
        'should render correctly',
        fileName: 'edit_trusted_contacts_page',
        pageBuilder: () => EditTrustedContactsPage(controller: controller),
      );

      screenshotTestSimplified(
        'should show remove contact confirmation dialog',
        fileName: 'edit_trusted_contacts_page_with_remove_contact_dialog',
        pageBuilder: () => EditTrustedContactsPage(controller: controller),
        pumpBeforeTest: (tester) async {
          await tester.pumpAndSettle();
          await tester.tapAll(
            find.descendant(
              of: find.byKey(Key('trusted-contact_2')),
              matching: find.byTooltip('Remover'),
            ),
          );
          await tester.pumpAndSettle();
        },
      );

      screenshotTestSimplified(
        'should show update contact dialog',
        fileName: 'edit_trusted_contacts_page_with_update_contact_dialog',
        pageBuilder: () => EditTrustedContactsPage(controller: controller),
        pumpBeforeTest: (tester) async {
          await tester.pumpAndSettle();
          await tester.tapAll(
            find.descendant(
              of: find.byKey(Key('trusted-contact_3')),
              matching: find.byTooltip('Editar'),
            ),
          );
          await tester.pumpAndSettle();
        },
      );
    });
  });
}

class _MockEscapeManualToggleFeature extends Mock
    implements EscapeManualToggleFeature {}

class _MockModularNavigator extends Mock implements IModularNavigator {}
