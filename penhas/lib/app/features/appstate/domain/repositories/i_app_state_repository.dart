import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/update_user_profile_entity.dart';

abstract class IAppStateRepository {
  Future<Either<Failure, AppStateEntity>> check();
  Future<Either<Failure, AppStateEntity>> update(
      UpdateUserProfileEntity update);
}
