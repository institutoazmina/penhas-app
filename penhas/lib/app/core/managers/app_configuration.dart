import 'package:meta/meta.dart';
import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';

abstract class IAppConfiguration {
  Future<String> get apiToken;
  Future<void> saveApiToken({@required String token});
  Future<void> logout();
  Uri get penhasServer;
  Future<AuthorizationStatus> get authorizationStatus;
  Future<void> saveCategoryPreference({@required List<String> codes});
  Future<void> saveTagsPreference({@required List<String> codes});
  Future<List<String>> getCategoryPreference();
  Future<List<String>> getTagsPreference();
}

class AppConfiguration implements IAppConfiguration {
  final _tokenKey = 'br.com.penhas.tokenServer';
  final _preferenceTagsKey = 'br.com.penhas.preferenceTags';
  final _preferenceCategoryKey = 'br.com.penhas.preferenceCategory';
  final ILocalStorage _storage;

  AppConfiguration({@required ILocalStorage storage}) : this._storage = storage;

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

  @override
  Future<void> saveCategoryPreference({List<String> codes}) async {
    final String data = codes.join(',');
    await _storage.put(_preferenceCategoryKey, data);
    return;
  }

  @override
  Future<void> saveTagsPreference({List<String> codes}) async {
    final String data = codes.join(',');
    await _storage.put(_preferenceTagsKey, data);
    return;
  }

  @override
  Future<List<String>> getCategoryPreference() async {
    return _storage
        .get(_preferenceCategoryKey)
        .then((value) => value.split(','));
  }

  @override
  Future<List<String>> getTagsPreference() {
    return _storage.get(_preferenceTagsKey).then((value) => value.split(','));
  }
}
