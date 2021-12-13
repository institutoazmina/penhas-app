class ApiProviderException implements Exception {
  final Map<String, dynamic>? bodyContent;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [bodyContent];
}

class NetworkServerException implements Exception {}

class ApiProviderSessionError extends NonCriticalError {}

class InternetConnectionException implements Exception {}

class HandledException implements Exception {
  String? message;

  HandledException([this.message]);
}