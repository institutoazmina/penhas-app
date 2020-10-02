import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/filters/data/models/filter_tag_model.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';

class FilterUseCase {
  Future<Either<Failure, List<FilterTagEntity>>> skills() async {
    return right([
      FilterTagModel(id: "1", label: "Escuta acolhedora", isSelected: false),
      FilterTagModel(id: "2", label: "Psicologia", isSelected: false),
      FilterTagModel(id: "3", label: "Abrigo", isSelected: false),
      FilterTagModel(id: "4", label: "Apoio jurídico", isSelected: false),
      FilterTagModel(id: "5", label: "Finanças pessoais", isSelected: false),
      FilterTagModel(id: "6", label: "Saúde e bem estar", isSelected: false),
      FilterTagModel(id: "8", label: "Segurança digital", isSelected: false),
      FilterTagModel(id: "9", label: "Segurança pessoal", isSelected: false),
    ]);
  }
}
