import 'dart:convert';

import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:meta/meta.dart';

class HelpCenterCallActionFeature {
  final IAppModulesServices _modulesServices;
  final String _featureCode = 'modo_seguranca';

  Future<String> get callingNumber => _callingNumber();

  HelpCenterCallActionFeature({@required IAppModulesServices modulesServices})
      : this._modulesServices = modulesServices;

  Future<String> _callingNumber() {
    return _modulesServices
        .feature(name: _featureCode)
        .then((module) => jsonDecode(module.meta))
        .then((json) => json as Map<String, Object>)
        .then((json) => json['numero']);
  }
}
