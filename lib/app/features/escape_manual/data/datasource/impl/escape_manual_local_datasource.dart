import 'dart:async';

import '../../../../../core/storage/collection_store.dart';
import '../../model/escape_manual_local.dart';
import '../escape_manual_datasource.dart';

export '../escape_manual_datasource.dart' show IEscapeManualLocalDatasource;

class EscapeManualLocalDatasource implements IEscapeManualLocalDatasource {
  EscapeManualLocalDatasource({
    required ICollectionStore<EscapeManualTaskLocalModel> store,
  }) : _store = store;

  final ICollectionStore<EscapeManualTaskLocalModel> _store;

  @override
  Stream<Iterable<EscapeManualTaskLocalModel>> fetchTasks() =>
      _store.watchAll();
}
