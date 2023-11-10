import 'entity/escape_manual.dart';
import 'repository/escape_manual_repository.dart';

class GetEscapeManualUseCase {
  const GetEscapeManualUseCase({
    required IEscapeManualRepository repository,
  }) : _repository = repository;

  final IEscapeManualRepository _repository;

  Stream<EscapeManualEntity> call() => _repository.fetch();
}
