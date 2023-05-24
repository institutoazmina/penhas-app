import '../../../../core/managers/modules_sevices.dart';

class SupportCenterToggleFeature {
  SupportCenterToggleFeature({required IAppModulesServices modulesServices})
      : _modulesServices = modulesServices;

  final IAppModulesServices _modulesServices;
  static String featureCode = 'pontos_de_apoio';

  Future<bool> get isEnabled => _isEnabled();

  Future<bool> _isEnabled() async {
    try {
      return await _modulesServices.isEnabled(featureCode);
    } catch (_) {
      return false;
    }
  }
}
