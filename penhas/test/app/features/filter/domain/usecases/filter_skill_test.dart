import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/filters/domain/usecases/filter_use_case.dart';

void main() {
  FilterUseCase sut;
  List<FilterTagEntity> filterTags;

  setUp(() {
    filterTags = [
      FilterTagEntity(id: "1", label: "Escuta acolhedora", isSelected: false),
      FilterTagEntity(id: "2", label: "Psicologia", isSelected: false),
      FilterTagEntity(id: "3", label: "Abrigo", isSelected: false),
      FilterTagEntity(id: "4", label: "Apoio jurídico", isSelected: false),
      FilterTagEntity(id: "5", label: "Finanças pessoais", isSelected: false),
      FilterTagEntity(id: "6", label: "Saúde e bem estar", isSelected: false),
      FilterTagEntity(id: "8", label: "Segurança digital", isSelected: false),
      FilterTagEntity(id: "9", label: "Segurança pessoal", isSelected: false),
    ];
  });

  group('', () {
    test('should retrieve skills from server', () async {
      // arrange
      final actual = filterTags;
      // act
      final matcher = await sut.skills();
      // assert
      expect(actual, matcher);
    });
  });
}
