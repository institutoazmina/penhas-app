import 'package:meta/meta.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

abstract class AuthenticationDataSource {
  /// Calls the http://server.api/login? endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<SessionModel> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });
}
