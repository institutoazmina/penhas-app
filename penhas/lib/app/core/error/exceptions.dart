class ApiProviderException implements Exception {
  final Map<String, dynamic> bodyContent;

  ApiProviderException({this.bodyContent = const <String, dynamic>{}});
}

class ApiProviderSessionExpection implements Exception {}
