import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:meta/meta.dart';

class ChatToggleFeature {
  final IAppModulesServices _modulesServices;
  static String featureCode = 'chat_privado';

  Future<bool> get isEnabled => _isEnabled();

  ChatToggleFeature({@required IAppModulesServices modulesServices})
      : this._modulesServices = modulesServices;

  Future<bool> _isEnabled() async {
    final module =
        await _modulesServices.feature(name: ChatToggleFeature.featureCode);
    return module != null;
  }
}
