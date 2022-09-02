import 'package:equatable/equatable.dart';

abstract class NonCriticalError extends Error {
  NonCriticalError([this.message]);

  String? message;
}

class ApiProviderException extends Equatable implements Exception {
  const ApiProviderException({this.bodyContent = const <String, dynamic>{}});

  final Map<String, dynamic> bodyContent;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [bodyContent];
}

class NetworkServerException implements Exception {}

class ApiProviderSessionError extends NonCriticalError {}

class InternetConnectionException implements Exception {}
