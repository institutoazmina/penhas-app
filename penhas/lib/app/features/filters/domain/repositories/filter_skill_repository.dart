import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:penhas/app/features/filters/data/models/filter_skills_model.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';

abstract class IFilterSkillRepository {
  Future<Either<Failure, List<FilterTagEntity>>> skills();
}

class FilterSkillRepository implements IFilterSkillRepository {
  final IApiProvider _apiProvider;

  FilterSkillRepository({
    @required IApiProvider apiProvider,
  }) : this._apiProvider = apiProvider;

  Future<Either<Failure, List<FilterTagEntity>>> skills() async {
    final endPoint = "/filter-skills";

    try {
      final response = await _apiProvider.get(path: endPoint).parseSkills();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _FutureExtension<T extends String> on Future<T> {
  Future<List<FilterTagEntity>> parseSkills() async {
    return this.then((data) async {
      final jsonData = jsonDecode(data) as Map<String, Object>;
      return FilterSkillsModel.fromJson(jsonData).skills;
    });
  }
}
