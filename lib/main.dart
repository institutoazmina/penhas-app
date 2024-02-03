import 'bootstrap/bootstrap.dart';
import 'bootstrap/impl/main_app_runner.dart';

void main() {
  Bootstrap.instance.withRunner(
    MainAppRunner(),
  );
}
