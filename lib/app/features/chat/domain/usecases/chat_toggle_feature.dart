import '../../../../core/managers/modules_sevices.dart';

class ChatPrivateToggleFeature {
  ChatPrivateToggleFeature({required IAppModulesServices modulesServices})
      : _modulesServices = modulesServices;

  final IAppModulesServices _modulesServices;
  static String featureCode = 'chat_privado';

  Future<bool> get isEnabled => _isEnabled();

  Future<bool> _isEnabled() async {
    try {
      final module = await _modulesServices.feature(
        name: ChatPrivateToggleFeature.featureCode,
      );
      return module != null;
    } catch (e) {
      return false;
    }
  }
}

class ChatSupportToggleFeature {
  ChatSupportToggleFeature({required IAppModulesServices modulesServices})
      : _modulesServices = modulesServices;

  final IAppModulesServices _modulesServices;
  static String featureCode = 'chat_suporte';

  Future<bool> get isEnabled => _isEnabled();

  Future<bool> _isEnabled() async {
    try {
      final module = await _modulesServices.feature(
        name: ChatSupportToggleFeature.featureCode,
      );
      return module != null;
    } catch (e) {
      return false;
    }
  }
}
