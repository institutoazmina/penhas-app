import 'package:meta/meta.dart';
import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';

abstract class IAppConfiguration {
  Future<String> get apiToken;
  Future<void> saveApiToken({@required String token});
  Future<void> logout();
  Uri get penhasServer;
  Future<AuthorizationStatus> get authorizationStatus;
}

class AppConfiguration implements IAppConfiguration {
  final _tokenKey = 'br.com.penhas.tokenServer';
  final ILocalStorage _storage;

  factory AppConfiguration({@required ILocalStorage storage}) {
    return AppConfiguration._(storage);
  }

  AppConfiguration._(this._storage);

  @override
  Future<String> get apiToken {
    return _storage.get(_tokenKey);
  }

  @override
  Future<AuthorizationStatus> get authorizationStatus async {
    final value = await apiToken;
    return value == null
        ? AuthorizationStatus.anonymous
        : AuthorizationStatus.authenticated;
  }

  @override
  Uri get penhasServer => Uri.https('elasv2-api.appcivico.com', '/');

  @override
  Future<void> saveApiToken({@required String token}) async {
    await _storage.put(_tokenKey, token);
    return;
  }

  @override
  Future<void> logout() async {
    await _storage.delete(_tokenKey);
    return;
  }
}
