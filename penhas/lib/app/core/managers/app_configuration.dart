import 'package:meta/meta.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';

abstract class IAppConfiguration {
  Future<String> get apiToken;
  Future<void> saveApiToken({@required String token});
  Uri get penhasServer;
  Future<bool> get isAuthenticated;
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
  Future<bool> get isAuthenticated async {
    return apiToken == null;
  }

  @override
  Uri get penhasServer => Uri.https('elasv2-api.appcivico.com', '/');

  @override
  Future<void> saveApiToken({@required String token}) async {
    await _storage.put(_tokenKey, token);
    return;
  }
}
