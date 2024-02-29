import 'package:equatable/equatable.dart';

class AppRoute extends Equatable {
  AppRoute(String uri)
      : assert(uri.trim().isNotEmpty),
        assert(uri.startsWith('/')),
        uri = Uri.parse(uri);

  final Uri uri;
  late final String path = uri.path;
  late final Map<String, String>? args =
      uri.queryParameters.isNotEmpty ? uri.queryParameters : null;

  @override
  List<Object?> get props => [uri, path, args];
}
