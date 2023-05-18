// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';

void main() {
  const id = 'testId';
  const label = 'testLabel';
  const isSelected = true;

  const newId = 'newTestId';
  const newLabel = 'newTestLabel';
  const newIsSelected = false;

  group(FilterTagEntity, () {
    test('supports value comparisons', () {
      expect(
        FilterTagEntity(id: id, label: label, isSelected: isSelected),
        FilterTagEntity(id: id, label: label, isSelected: isSelected),
      );
    });

    test('copyWith creates a new instance with the same and/or updated values',
        () {
      final tagEntity =
          FilterTagEntity(id: id, label: label, isSelected: isSelected);
      final copiedTagEntity = tagEntity.copyWith(
          id: newId, label: newLabel, isSelected: newIsSelected);

      // The old and new instances are not equal
      expect(tagEntity == copiedTagEntity, false);

      // The new values have been copied correctly
      expect(copiedTagEntity.id, newId);
      expect(copiedTagEntity.label, newLabel);
      expect(copiedTagEntity.isSelected, newIsSelected);
    });
  });
}
