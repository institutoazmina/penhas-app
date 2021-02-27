import 'dart:collection';

class AppRoute {
  String path;
  Map<String, String> args;

  AppRoute(String uri) {
    assert(uri.trim().isNotEmpty);
    assert(uri.startsWith('/'));

    List<String> pathAndArgs = uri.split('?');
    path = pathAndArgs.first;

    if (pathAndArgs.length > 1) {
      args = new HashMap<String, String>();
      pathAndArgs.last.split('&').forEach((arg) {
        List<String> kv = arg.split('=');
        args[kv.first] = kv.last;
      });
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppRoute &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          args == other.args;

  @override
  int get hashCode => path.hashCode ^ args.hashCode;
}
