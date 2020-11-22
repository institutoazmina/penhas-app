import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:meta/meta.dart';

class TweetToggleFeature {
  final IAppModulesServices _modulesServices;
  static String featureCode = 'tweets';

  Future<bool> get isEnabled => _isEnabled();

  TweetToggleFeature({@required IAppModulesServices modulesServices})
      : this._modulesServices = modulesServices;

  Future<bool> _isEnabled() async {
    final module =
        await _modulesServices.feature(name: TweetToggleFeature.featureCode);
    return module != null;
  }
}
