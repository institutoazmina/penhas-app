import '../../../core/extension/iterable.dart';
import 'entity/escape_manual.dart';
import 'repository/escape_manual_repository.dart';

class GetEscapeManualUseCase {
  const GetEscapeManualUseCase({
    required IEscapeManualRepository repository,
  }) : _repository = repository;

  final IEscapeManualRepository _repository;

  Stream<EscapeManualEntity> call() => _repository.fetch().map(_sortTasks);
}

EscapeManualEntity _sortTasks(
  EscapeManualEntity entity,
) =>
    entity.copyWith(
      sections: entity.sections
          .map(
            (section) => section.copyWith(
              tasks: section.tasks.sortIndexed(_compare).toList(),
            ),
          )
          .toList(),
    );

int _compare(
  MapEntry<int, EscapeManualTaskEntity> a,
  MapEntry<int, EscapeManualTaskEntity> b,
) {
  final aValue = a.value;
  final bValue = b.value;

  if (aValue is! EscapeManualTodoTaskEntity ||
      bValue is! EscapeManualTodoTaskEntity) {
    return 0;
  }

  if (aValue.isDone == bValue.isDone) {
    return a.key.compareTo(b.key);
  }

  return aValue.isDone ? 1 : -1;
}
