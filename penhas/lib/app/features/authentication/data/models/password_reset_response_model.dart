import 'package:meta/meta.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';

class PasswordResetResponseModel extends ResetPasswordResponseEntity {
  PasswordResetResponseModel({
    @required String message,
    @required int digits,
    @required int ttl,
    @required int ttlRetry,
  }) : super(message: message, digits: digits, ttl: ttl, ttlRetry: ttlRetry);

  factory PasswordResetResponseModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetResponseModel(
      digits: (json['digits'] as num).toInt(),
      message: json['message'],
      ttlRetry: (json['min_ttl_retry']).toInt(),
      ttl: (json['ttl']).toInt(),
    );
  }
}
