import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/escape_manual/domain/entity/escape_manual_task.dart';
import 'package:penhas/app/features/escape_manual/domain/escape_manual_toggle.dart';
import 'package:penhas/app/features/escape_manual/presentation/edit/edit_trusted_contacts_controller.dart';
import 'package:penhas/app/features/escape_manual/presentation/edit/edit_trusted_contacts_state.dart';

const _maxTrustedContacts = 3;

void main() {
  group(EditTrustedContactsController, () {
    late EscapeManualToggleFeature mockToggleFeature;
    late _IOnEditTrustedContactsReaction mockOnReaction;
    late Completer<int> maxTrustedContactsCompleter;

    setUp(() {
      mockToggleFeature = _MockEscapeManualToggleFeature();
      mockOnReaction = _MockOnEditTrustedContactsReaction();

      maxTrustedContactsCompleter = Completer<int>();
      when(() => mockToggleFeature.maxTrustedContacts)
          .thenAnswer((_) => maxTrustedContactsCompleter.future);
      maxTrustedContactsCompleter.complete(_maxTrustedContacts);
    });

    EditTrustedContactsController createController([
      List<ContactEntity>? contacts,
    ]) =>
        EditTrustedContactsController(
          contacts: contacts,
          escapeManualToggleFeature: mockToggleFeature,
        )..onReaction(mockOnReaction);

    group('init', () {
      test(
        'should have all placeholders when value is null',
        () async {
          // arrange
          final controller = createController();
          await maxTrustedContactsCompleter.future;

          // assert
          expect(
            controller.state.contacts,
            [
              ContactPlaceholder(1),
              ContactPlaceholder(2),
              ContactPlaceholder(3),
            ],
          );
        },
      );

      test(
        'should have all placeholders when value is empty',
        () async {
          // arrange
          final controller = createController([]);
          await maxTrustedContactsCompleter.future;

          // assert
          expect(
            controller.state.contacts,
            [
              ContactPlaceholder(1),
              ContactPlaceholder(2),
              ContactPlaceholder(3),
            ],
          );
        },
      );

      test(
        'should fill contacts with placeholders',
        () async {
          // arrange
          final controller = createController(
            [
              ContactEntity(id: 2, name: 'name', phone: 'phone'),
            ],
          );
          await maxTrustedContactsCompleter.future;

          // assert
          expect(
            controller.state.contacts,
            [
              ContactPlaceholder(1),
              ContactEntity(id: 2, name: 'name', phone: 'phone'),
              ContactPlaceholder(3),
            ],
          );
        },
      );
    });

    group('onUpdateContactPressed', () {
      test(
        'should open dialog with empty contact',
        () async {
          // arrange
          final controller = createController();
          await maxTrustedContactsCompleter.future;

          // act
          controller.onUpdateContactPressed(ContactPlaceholder(1));

          // assert
          verify(
            () => mockOnReaction(
              EditTrustedContactsReaction.requestContactInfo(
                ContactEntity(id: 1, name: '', phone: ''),
              ),
            ),
          ).called(1);
        },
      );

      test(
        'should open dialog with contact',
        () async {
          // arrange
          final controller = createController(
            [
              ContactEntity(id: 1, name: 'name', phone: 'phone'),
            ],
          );
          await maxTrustedContactsCompleter.future;

          // act
          controller.onUpdateContactPressed(
            ContactEntity(id: 1, name: 'name', phone: 'phone'),
          );

          // assert
          verify(
            () => mockOnReaction(
              EditTrustedContactsReaction.requestContactInfo(
                ContactEntity(id: 1, name: 'name', phone: 'phone'),
              ),
            ),
          ).called(1);
        },
      );
    });

    group('onRemoveContactPressed', () {
      test(
        'should emit askForDeleteConfirmation reaction',
        () async {
          // arrange
          final controller = createController(
            [
              ContactEntity(id: 1, name: 'name', phone: 'phone'),
            ],
          );
          await maxTrustedContactsCompleter.future;

          // act
          controller.onRemoveContactPressed(
            ContactEntity(id: 1, name: 'name', phone: 'phone'),
          );

          // assert
          verify(
            () => mockOnReaction(
              EditTrustedContactsReaction.askForDeleteConfirmation(
                ContactEntity(id: 1, name: 'name', phone: 'phone'),
              ),
            ),
          ).called(1);
        },
      );

      test(
        'should not emit askForDeleteConfirmation reaction',
        () async {
          // arrange
          final controller = createController();
          await maxTrustedContactsCompleter.future;

          // act
          controller.onRemoveContactPressed(ContactPlaceholder(1));

          // assert
          verifyNever(() => mockOnReaction(any()));
        },
      );
    });

    test(
      'updateContact should update contact',
      () async {
        // arrange
        final controller = createController(
          [
            ContactEntity(id: 1, name: 'name', phone: 'phone'),
          ],
        );
        await maxTrustedContactsCompleter.future;

        // act
        await controller.updateContact(
          ContactEntity(id: 1, name: 'name2', phone: 'phone2'),
        );

        // assert
        expect(
          controller.state.contacts,
          [
            ContactEntity(id: 1, name: 'name2', phone: 'phone2'),
            ContactPlaceholder(2),
            ContactPlaceholder(3),
          ],
        );
      },
    );

    test(
      'removeContact should remove contact',
      () async {
        // arrange
        final controller = createController(
          [
            ContactEntity(id: 1, name: 'name', phone: 'phone'),
          ],
        );
        await maxTrustedContactsCompleter.future;

        // act
        await controller.removeContact(
          ContactEntity(id: 1, name: 'name', phone: 'phone'),
        );

        // assert
        expect(
          controller.state.contacts,
          [
            ContactPlaceholder(1),
            ContactPlaceholder(2),
            ContactPlaceholder(3),
          ],
        );
      },
    );
  });
}

class _MockEscapeManualToggleFeature extends Mock
    implements EscapeManualToggleFeature {}

class _MockOnEditTrustedContactsReaction extends Mock
    implements _IOnEditTrustedContactsReaction {}

abstract class _IOnEditTrustedContactsReaction {
  void call(EditTrustedContactsReaction? reaction);
}
