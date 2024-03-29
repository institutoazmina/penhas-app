import '../../../../core/managers/modules_sevices.dart';

class TweetToggleFeature {
  TweetToggleFeature({required IAppModulesServices modulesServices})
      : _modulesServices = modulesServices;

  final IAppModulesServices _modulesServices;
  static String featureCode = 'tweets';

  Future<bool> get isEnabled => _isEnabled();

  Future<bool> _isEnabled() async {
    try {
      final module =
          await _modulesServices.feature(name: TweetToggleFeature.featureCode);
      return module != null;
    } catch (e) {
      return false;
    }
  }
}
