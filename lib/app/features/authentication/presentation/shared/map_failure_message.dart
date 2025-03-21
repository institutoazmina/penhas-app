import '../../../../core/error/failures.dart';
import '../../../../shared/logger/log.dart';

mixin MapFailureMessage {
  final String internetConnectionFailure =
      'O servidor está inacessível, o PenhaS está com acesso à Internet?';
  final String serverFailure =
      'O servidor está com problema neste momento, tente novamente.';
  final String genericFailure =
      'Oops.. ocorreu um erro inesperado, tente novamente mais tarde.';

  String mapFailureMessage(Failure failure) {
    var message = genericFailure;

    switch (failure.runtimeType) {
      case const (InternetConnectionFailure):
        message = internetConnectionFailure;
        break;
      case const (ServerFailure):
        message = serverFailure;
        break;
      case const (ServerSideFormFieldValidationFailure):
        message = mapServerSideValidationFailure(
          failure as ServerSideFormFieldValidationFailure,
        );
        break;
      default:
        logError(failure);
    }

    return message;
  }

  String mapServerSideValidationFailure(
    ServerSideFormFieldValidationFailure failure,
  ) {
    return failure.message ?? genericFailure;
  }
}
