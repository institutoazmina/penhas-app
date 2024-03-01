import 'package:dartz/dartz.dart';

import '../error/failures.dart';

typedef Result<T> = Either<Failure, T>;
