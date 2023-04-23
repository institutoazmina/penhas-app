import '../../../../core/error/failures.dart';
import '../../../../shared/logger/log.dart';

mixin MapFailureMessage {
  final String internetConnectionFailure =
      'O servidor está inacessível, o PenhaS está com acesso à Internet?';
  final String serverFailure =
      'O servidor está com problema neste momento, tente novamente.';
  final String genericFailure =
      'Oops.. ocorreu um erro inesperado, tente novamentetarde.';

  String mapFailureMessage(Failure failure) {
    var message = genericFailure;

    switch (failure.runtimeType) {
      case InternetConnectionFailure:
        message = internetConnectionFailure;
        break;
      case ServerFailure:
        message = serverFailure;
        break;
      case ServerSideFormFieldValidationFailure:
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
