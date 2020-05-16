import 'package:meta/meta.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';

abstract class IQuizDataSource {
  Future<AppStateModel> update({@required QuizRequestEntity quiz});
}

class QuizDataSource implements IQuizDataSource {
  @override
  Future<AppStateModel> update({@required QuizRequestEntity quiz}) {}
}
