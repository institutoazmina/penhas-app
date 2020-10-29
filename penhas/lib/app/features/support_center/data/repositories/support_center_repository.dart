import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:penhas/app/features/support_center/data/models/support_center_metadata_model.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';

abstract class ISupportCenterRepository {
  Future<Either<Failure, SupportCenterMetadataEntity>> metadata();
}

class SupportCenterRepository implements ISupportCenterRepository {
  final IApiProvider _apiProvider;

  SupportCenterRepository({
    @required IApiProvider apiProvider,
  }) : this._apiProvider = apiProvider;

  @override
  Future<Either<Failure, SupportCenterMetadataEntity>> metadata() async {
    final endPoint = "/pontos-de-apoio-dados-auxiliares";

    try {
      final response = await _apiProvider.get(path: endPoint).parseMetadata();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _ChatChannelRepository<T extends String> on Future<T> {
  Future<SupportCenterMetadataEntity> parseMetadata() async {
    return this
        .then((v) => jsonDecode(v) as Map<String, Object>)
        .then((v) => SupportCenterMetadataModel.fromJson(v));
  }
}
