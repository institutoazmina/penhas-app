import '../../extension/hive.dart';
import '../key_value_storage.dart';

mixin HiveStorage on IKeyValueStorage {
  Future<Box> get box;

  @override
  Future<T?> get<T>(String key) async {
    final box = await this.box;
    return await box.get(key);
  }

  @override
  Future<void> put<T>(String key, T value) async {
    final box = await this.box;
    await box.put(key, value);
  }

  @override
  Future<void> putAll<T>(Map<String, T> values) async {
    final box = await this.box;
    await box.putAll(values);
  }

  @override
  Future<void> remove(String key) async {
    final box = await this.box;
    await box.delete(key);
  }

  @override
  Future<void> removeAll(Iterable<String> keys) async {
    final box = await this.box;
    await box.deleteAll(keys);
  }

  @override
  Future<void> clear() async {
    final box = await this.box;
    await box.clear();
  }
}
