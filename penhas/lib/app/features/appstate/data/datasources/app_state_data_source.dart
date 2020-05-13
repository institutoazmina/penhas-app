import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';

abstract class IAppStateDataSource {
  Future<AppStateModel> check();
}
