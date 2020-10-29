import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';

abstract class ISupportCenterRepository {
  Future<Either<Failure, SupportCenterMetadataEntity>> metadata();
}

class SupportCenterRepository implements ISupportCenterRepository {
  @override
  Future<Either<Failure, SupportCenterMetadataEntity>> metadata() {
    throw UnimplementedError();
  }
}
