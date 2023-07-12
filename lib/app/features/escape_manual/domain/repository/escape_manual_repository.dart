import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/escape_manual.dart';

abstract class IEscapeManualRepository {
  Future<Either<Failure, EscapeManualEntity>> fetch();
}
