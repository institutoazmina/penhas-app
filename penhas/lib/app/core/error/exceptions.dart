import 'package:equatable/equatable.dart';

abstract class NonCriticalError extends Error {
  String? message;

  NonCriticalError([this.message]);
}

class ApiProviderException implements Exception, Equatable {
  ApiProviderException({this.bodyContent = const <String, dynamic>{}});

  final Map<String, dynamic> bodyContent;

  @override
  final bool stringify = true;

  @override
  List<Object?> get props => [bodyContent];
}

class NetworkServerException implements Exception {}

class ApiProviderSessionError extends NonCriticalError {}

class InternetConnectionException implements Exception {}
