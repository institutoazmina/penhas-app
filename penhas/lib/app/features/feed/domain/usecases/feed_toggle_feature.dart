import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:meta/meta.dart';

class FeedToggleFeature {
  final IAppModulesServices _modulesServices;
  static String featureCode = 'noticias';

  Future<bool> get isEnabled => _isEnabled();

  FeedToggleFeature({@required IAppModulesServices modulesServices})
      : this._modulesServices = modulesServices;

  Future<bool> _isEnabled() async {
    final module =
        await _modulesServices.feature(name: FeedToggleFeature.featureCode);
    return module != null;
  }
}
