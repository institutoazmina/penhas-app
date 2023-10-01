import 'package:dartz/dartz.dart';
import 'login_offline_toggle.dart';

import '../../../../core/error/failures.dart';
import '../entities/session_entity.dart';
import '../repositories/i_authentication_repository.dart';
import 'email_address.dart';
import 'sign_in_password.dart';

class AuthenticateUser {
  AuthenticateUser({
    required IAuthenticationRepository authenticationRepository,
  }) : _repository = authenticationRepository;

  final IAuthenticationRepository _repository;

  Future<Either<Failure, SessionEntity>> call({
    required EmailAddress email,
    required SignInPassword password,
  }) async {
    return await _repository.signInWithEmailAndPassword(
      emailAddress: email,
      password: password,
    );
  }
}

abstract class AuthenticateUserWithOfflineSupport {
  AuthenticateUserWithOfflineSupport(
      IAuthenticationRepository authenticationRepository,
      LoginOfflineToggleFeature loginOfflineToggleFeature)
      : _repository = authenticationRepository,
        _loginOfflineToggleFeature = loginOfflineToggleFeature;

  final IAuthenticationRepository _repository;
  final LoginOfflineToggleFeature _loginOfflineToggleFeature;

  Future<Either<Failure, SessionEntity>> call({
    required EmailAddress email,
    required SignInPassword password,
  }) async {
    final Either<Failure, SessionEntity> response;
    if (_loginOfflineToggleFeature.isEnabled) {
      response = await _repository.signInOffline(
        emailAddress: email,
        password: password,
      );
    } else {
      response = await _repository.signInWithEmailAndPassword(
        emailAddress: email,
        password: password,
      );
    }

    return response;
  }
}

class AuthenticateStealthUser extends AuthenticateUserWithOfflineSupport {
  AuthenticateStealthUser(
      {required IAuthenticationRepository authenticationRepository,
      required LoginOfflineToggleFeature loginOfflineToggleFeature})
      : super(authenticationRepository, loginOfflineToggleFeature);
}

class AuthenticateAnonymousUser
    extends AuthenticateUserWithOfflineSupport {
  AuthenticateAnonymousUser(
      {required IAuthenticationRepository authenticationRepository,
      required LoginOfflineToggleFeature loginOfflineToggleFeature})
      : super(authenticationRepository, loginOfflineToggleFeature);
}
