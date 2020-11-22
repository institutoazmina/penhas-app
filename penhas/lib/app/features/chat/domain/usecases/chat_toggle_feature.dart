import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:meta/meta.dart';

class ChatPrivateToggleFeature {
  final IAppModulesServices _modulesServices;
  static String featureCode = 'chat_privado';

  Future<bool> get isEnabled => _isEnabled();

  ChatPrivateToggleFeature({@required IAppModulesServices modulesServices})
      : this._modulesServices = modulesServices;

  Future<bool> _isEnabled() async {
    final module = await _modulesServices.feature(
        name: ChatPrivateToggleFeature.featureCode);
    return module != null;
  }
}

class ChatSupportToggleFeature {
  final IAppModulesServices _modulesServices;
  static String featureCode = 'chat_suporte';

  Future<bool> get isEnabled => _isEnabled();

  ChatSupportToggleFeature({@required IAppModulesServices modulesServices})
      : this._modulesServices = modulesServices;

  Future<bool> _isEnabled() async {
    final module = await _modulesServices.feature(
        name: ChatSupportToggleFeature.featureCode);
    return module != null;
  }
}
