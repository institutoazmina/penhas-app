class ApiProviderException implements Exception {
  final Map<String, dynamic> bodyContent;

  ApiProviderException({this.bodyContent = const <String, dynamic>{}});

  // ApiProviderException([this.bodyContent = const Map<String, dynamic>()]);
}

//   abstract class Failure extends Equatable {
//   final List<dynamic> properties;

//   Failure([this.properties = const <dynamic>[]]);

//   @override
//   List<Object> get props => [properties];
// }
