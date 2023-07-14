import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/app_state_entity.dart';
import '../entities/update_user_profile_entity.dart';

abstract class IAppStateRepository {
  Future<Either<Failure, AppStateEntity>> check();
  Future<Either<Failure, AppStateEntity>> update(
    UpdateUserProfileEntity update,
  );
}
