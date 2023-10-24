import '../../../../core/error/failures.dart';
import '../../../../shared/logger/log.dart';

mixin MapFailureMessage {
  final String internetConnectionFailure =
      'O servidor está inacessível, o PenhaS está com acesso à Internet?';
  final String serverFailure =
      'O servidor está com problema neste momento, tente novamente.';
  final String genericFailure =
      'Oops.. ocorreu um erro inesperado, tente novamente mais tarde.';

  String mapFailureMessage(failure) {
    switch (failure.runtimeType) {
      case InternetConnectionFailure:
        return internetConnectionFailure;
      case ServerFailure:
        return serverFailure;
      case ServerSideFormFieldValidationFailure:
        return mapServerSideValidationFailure(
          failure as ServerSideFormFieldValidationFailure,
        );
      default:
        logError(failure);
        return genericFailure;
    }
  }

  String mapServerSideValidationFailure(
    ServerSideFormFieldValidationFailure failure,
  ) {
    return failure.message ?? genericFailure;
  }
}
