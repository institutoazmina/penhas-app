import 'package:penhas/app/core/managers/modules_sevices.dart';

class FeedToggleFeature {
  FeedToggleFeature({required IAppModulesServices modulesServices})
      : _modulesServices = modulesServices;

  final IAppModulesServices _modulesServices;
  static String featureCode = 'noticias';

  Future<bool> get isEnabled => _isEnabled();

  Future<bool> _isEnabled() async {
    final module =
        await _modulesServices.feature(name: FeedToggleFeature.featureCode);
    return module != null;
  }
}
