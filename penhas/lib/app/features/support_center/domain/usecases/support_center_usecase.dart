import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/support_center/data/repositories/support_center_repository.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';

class SupportCenterUseCase {
  final ISupportCenterRepository _supportCenterRepository;
  SupportCenterMetadataEntity _cacheMetadata;

  SupportCenterUseCase({
    @required ISupportCenterRepository supportCenterRepository,
  }) : this._supportCenterRepository = supportCenterRepository;

  Future<Either<Failure, SupportCenterMetadataEntity>> metadata() async {
    if (_cacheMetadata != null) {
      return right(_cacheMetadata);
    }

    final metadata = await _supportCenterRepository.metadata();
    _cacheMetadata = metadata.getOrElse(() => null);

    return metadata;
  }
}
