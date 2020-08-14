import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';

class MapExceptionToFailure {
  static Failure map(Object error) {
    if (error is InternetConnectionException) {
      return InternetConnectionFailure();
    } else if (error is ApiProviderSessionExpection) {
      return ServerSideSessionFailed();
    } else if (error is NetworkServerException) {
      return ServerFailure();
    }

    if (error is ApiProviderException) {
      if (error.bodyContent['error'] == 'expired_jwt') {
        return ServerSideSessionFailed();
      }

      return ServerSideFormFieldValidationFailure(
          error: error.bodyContent['error'],
          field: error.bodyContent['field'],
          reason: error.bodyContent['reason'],
          message: error.bodyContent['message']);
    }

    return ServerFailure();
  }
}
