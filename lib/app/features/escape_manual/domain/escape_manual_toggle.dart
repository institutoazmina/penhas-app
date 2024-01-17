import 'dart:convert';

import '../../../core/managers/modules_sevices.dart';
import '../../../shared/logger/log.dart';

const _defaultMaxTrustedContacts = 3;

class EscapeManualToggleFeature {
  EscapeManualToggleFeature({
    required IAppModulesServices modulesServices,
  }) : _modulesServices = modulesServices;

  static const String featureCode = 'mf';

  final IAppModulesServices _modulesServices;

  Future<bool> get isEnabled => _isEnabled();

  Future<int> get maxTrustedContacts => _maxTrustedContacts();

  Future<bool> _isEnabled() async {
    try {
      return await _modulesServices.isEnabled(featureCode);
    } catch (_) {
      return false;
    }
  }

  Future<int> _maxTrustedContacts() async {
    try {
      final module = await _modulesServices.feature(name: featureCode);
      final meta = jsonDecode(module!.meta) as Map<String, dynamic>;
      return int.parse("${meta['max_checkbox_contato']}");
    } catch (error, stackTrace) {
      logError(error, stackTrace);
      return _defaultMaxTrustedContacts;
    }
  }
}
