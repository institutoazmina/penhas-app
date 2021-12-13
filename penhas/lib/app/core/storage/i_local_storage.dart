import 'package:dartz/dartz.dart';

abstract class ILocalStorage {
  Future<Either<dynamic, String>> get(String key);
  Future<void> put(String key, String? value);
  Future<void> delete(String key);
}
