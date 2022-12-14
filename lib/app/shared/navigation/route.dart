import 'dart:collection';

class AppRoute {
  AppRoute(String uri)
      : assert(uri.trim().isNotEmpty),
        assert(uri.startsWith('/')) {
    final List<String> pathAndArgs = uri.split('?');
    path = pathAndArgs.first;

    if (pathAndArgs.length > 1) {
      args = HashMap<String, String>();
      pathAndArgs.last.split('&').forEach((arg) {
        final List<String> kv = arg.split('=');
        args![kv.first] = kv.last;
      });
    }
  }

  late String path;
  Map<String, String>? args;

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
