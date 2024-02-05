import '../../../../core/storage/cache_storage.dart';
import '../../../../core/storage/impl/json_object_store.dart';
import '../../../../core/storage/object_store.dart';
import '../../../../core/types/json.dart';

class EscapeManualCacheStore extends JsonObjectStore
    implements IObjectStore<JsonObject> {
  EscapeManualCacheStore({
    required ICacheStorage storage,
  }) : super(name: 'escape_manual_cache', storage: storage);
}
