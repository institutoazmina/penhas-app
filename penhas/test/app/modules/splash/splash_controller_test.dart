import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/modules/splash/splash_module.dart';

void main() {
  initModule(SplashModule());
  // AuthenticationController authentication;
  //
  setUp(() {
    //     authentication = AuthenticationModule.to.get<AuthenticationController>();
  });

  group('Route to authentication when session is not authenticated', () {
    test("", () {
      expect(Modular.actualRoute, "/authentication");
    });
  });
}
