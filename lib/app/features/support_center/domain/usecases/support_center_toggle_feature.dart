import '../../../../core/managers/modules_sevices.dart';

class SupportCenterToggleFeature {
  SupportCenterToggleFeature({required IAppModulesServices modulesServices})
      : _modulesServices = modulesServices;

  final IAppModulesServices _modulesServices;
  static String featureCode = 'pontos_de_apoio';

  Future<bool> get isEnabled => _modulesServices.isEnabled(featureCode);
}
