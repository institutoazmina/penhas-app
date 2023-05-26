import '../../../../core/managers/modules_sevices.dart';

class EscapeManualToggleFeature {
  EscapeManualToggleFeature({
    required IAppModulesServices modulesServices,
  }) : _modulesServices = modulesServices;

  final IAppModulesServices _modulesServices;
  static String featureCode = 'mf';

  Future<bool> get isEnabled => _isEnabled();

  Future<bool> _isEnabled() async {
    final module = await _modulesServices.feature(name: featureCode);
    return module != null;
  }
}
