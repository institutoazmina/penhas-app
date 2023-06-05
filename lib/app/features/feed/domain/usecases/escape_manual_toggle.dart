import '../../../../core/managers/modules_sevices.dart';

class EscapeManualToggleFeature {
  EscapeManualToggleFeature({
    required IAppModulesServices modulesServices,
  }) : _modulesServices = modulesServices;

  final IAppModulesServices _modulesServices;
  static const String featureCode = 'mf';

  Future<bool> get isEnabled => _isEnabled();

  Future<bool> _isEnabled() async {
    try {
      return await _modulesServices.isEnabled(featureCode);
    } catch (_) {
      return false;
    }
  }
}
