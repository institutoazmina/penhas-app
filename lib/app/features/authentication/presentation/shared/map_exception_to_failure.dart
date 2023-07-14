import 'dart:io';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class MapExceptionToFailure {
  static Failure map(Object error) {
    if (error is InternetConnectionException) {
      return InternetConnectionFailure();
    } else if (error is ApiProviderSessionError) {
      return ServerSideSessionFailed();
    } else if (error is NetworkServerException) {
      return ServerFailure();
    } else if (error is FileSystemException) {
      return FileSystemFailure();
    }

    if (error is ApiProviderException) {
      if (error.bodyContent['error'] == 'expired_jwt') {
        return ServerSideSessionFailed();
      }
      if (error.bodyContent['error'] == 'no-gps') {
        return GpsFailure(error.bodyContent['message']);
      }
      if (error.bodyContent['error'] == 'location_not_found') {
        return AddressFailure(error.bodyContent['message']);
      }

      return ServerSideFormFieldValidationFailure(
          error: error.bodyContent['error'],
          field: error.bodyContent['field'],
          reason: error.bodyContent['reason'],
          message: error.bodyContent['message'],);
    }

    return ServerFailure();
  }
}
