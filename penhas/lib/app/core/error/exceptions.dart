class ApiProviderException implements Exception {
  final Map<String, dynamic> bodyContent;

  ApiProviderException({this.bodyContent = const <String, dynamic>{}});
}

class NetworkServerException implements Exception {}

class ApiProviderSessionExpection implements Exception {}

class InternetConnectionException implements Exception {}
