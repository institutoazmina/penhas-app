import 'package:penhas/app/core/managers/modules_sevices.dart';

class TweetToggleFeature {
  TweetToggleFeature({required IAppModulesServices modulesServices})
      : _modulesServices = modulesServices;

  final IAppModulesServices _modulesServices;
  static String featureCode = 'tweets';

  Future<bool> get isEnabled => _isEnabled();

  TweetToggleFeature({required IAppModulesServices modulesServices})
      : this._modulesServices = modulesServices;

  Future<bool> _isEnabled() async {
    final module =
        await _modulesServices.feature(name: TweetToggleFeature.featureCode);
    return module != null;
  }
}
