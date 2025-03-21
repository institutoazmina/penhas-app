import '../../domain/entities/reset_password_response_entity.dart';

class PasswordResetResponseModel extends ResetPasswordResponseEntity {
  const PasswordResetResponseModel({
    required super.message,
    required super.digits,
    required super.ttl,
    required super.ttlRetry,
  });

  factory PasswordResetResponseModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetResponseModel(
      digits: json['digits'],
      message: json['message'],
      ttlRetry: json['min_ttl_retry'],
      ttl: json['ttl'],
    );
  }
}
