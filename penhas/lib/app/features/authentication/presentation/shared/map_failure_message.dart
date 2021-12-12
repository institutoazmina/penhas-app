import 'package:penhas/app/core/error/failures.dart';

mixin MapFailureMessage {
  final String internetConnectionFailure =
      'O servidor está inacessível, o PenhaS está com acesso à Internet?';
  final String serverFailure =
      'O servidor está com problema neste momento, tente novamente.';

  String? mapFailureMessage(Failure failure) {
    String? message;

    switch (failure.runtimeType) {
      case InternetConnectionFailure:
        message = internetConnectionFailure;
        break;
      case ServerFailure:
        message = serverFailure;
        break;
      case ServerSideFormFieldValidationFailure:
        message = mapServerSideValidationFailure(failure as ServerSideFormFieldValidationFailure);
        break;
      default:
        throw UnsupportedError;
    }

    return message;
  }

  String? mapServerSideValidationFailure(
      ServerSideFormFieldValidationFailure failure) {
    return failure.message;
  }
}
