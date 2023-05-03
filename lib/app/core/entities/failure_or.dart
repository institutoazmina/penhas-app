import 'package:dartz/dartz.dart';

import '../error/failures.dart';

typedef FailureOr<T> = Either<Failure, T>;
