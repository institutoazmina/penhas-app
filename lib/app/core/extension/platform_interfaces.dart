import 'dart:io';

import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';

class PlatformPlugins {
  static void ensureAllInitialized() {
    PathProvider.ensureInitialized();
    SharedPreferences.ensureInitialized();
  }
}

class PathProvider {
  static void ensureInitialized() {
    if (Platform.isAndroid) PathProviderAndroid.registerWith();
    if (Platform.isIOS) PathProviderIOS.registerWith();
  }
}

class SharedPreferences {
  static void ensureInitialized() {
    if (Platform.isAndroid) SharedPreferencesAndroid.registerWith();
    if (Platform.isIOS) SharedPreferencesIOS.registerWith();
  }
}
