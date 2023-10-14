import 'dart:convert';

import '../../../../../core/network/api_client.dart';
import '../../../../appstate/data/model/quiz_session_model.dart';
import '../../model/escape_manual_remote.dart';
import '../escape_manual_datasource.dart';

export '../escape_manual_datasource.dart' show IEscapeManualRemoteDatasource;

class EscapeManualRemoteDatasource implements IEscapeManualRemoteDatasource {
  EscapeManualRemoteDatasource({
    required IApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  final IApiProvider _apiProvider;

  @override
  Future<QuizSessionModel> start(String sessionId) async {
    final response = await _apiProvider.post(
      path: '/me/quiz',
      parameters: {'session_id': sessionId},
    ).then(jsonDecode);

    return QuizSessionModel.fromJson(response['quiz_session']);
  }

  @override
  Future<EscapeManualRemoteModel> fetch() async {
    final response = await _apiProvider.get(
      path: '/me/tarefas',
      parameters: {
        'modificado_apos': '0',
      },
    ).then(jsonDecode);

    return EscapeManualRemoteModel.fromJson(response);
  }
}
