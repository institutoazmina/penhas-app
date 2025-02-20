import 'exceptions.dart';
import 'failures.dart';

class ApiProviderErrorMapper {
  static Failure map(Object error) {
    if (error is NetworkServerException) {
      return InternetConnectionFailure();
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
        message: error.bodyContent['message'],
      );
    }

    if (error is ApiProviderSessionError) {
      return ServerSideSessionFailed();
    }

    return ServerFailure();
  }
}
