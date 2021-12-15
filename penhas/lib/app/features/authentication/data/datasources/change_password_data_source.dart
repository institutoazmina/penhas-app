import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/models/password_reset_response_model.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

abstract class IChangePasswordDataSource {
  Future<ValidField> reset({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    String? resetToken,
  });

  Future<ValidField> validToken({
    EmailAddress? emailAddress,
    String? resetToken,
  });

  Future<PasswordResetResponseModel> request({EmailAddress? emailAddress});
}

class ChangePasswordDataSource implements IChangePasswordDataSource {
  final http.Client apiClient;
  final IApiServerConfigure serverConfiguration;

  ChangePasswordDataSource({
    required this.apiClient,
    required this.serverConfiguration,
  });

  final http.Client apiClient;
  final IApiServerConfigure serverConfiguration;

  @override
  Future<PasswordResetResponseModel> request(
      {EmailAddress? emailAddress}) async {
    final userAgent = await serverConfiguration.userAgent;
    final Map<String, String?> queryParameters = {
      'app_version': userAgent,
      'email': emailAddress!.rawValue,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest = serverConfiguration.baseUri.replace(
      path: '/reset-password/request-new',
      queryParameters: queryParameters,
    );

    final response = await apiClient.post(httpRequest, headers: httpHeader);
    if (response.statusCode == HttpStatus.ok) {
      return PasswordResetResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<ValidField> reset(
      {EmailAddress? emailAddress,
      SignUpPassword? password,
      String? resetToken}) async {
    final userAgent = await serverConfiguration.userAgent;
    final Map<String, String?> queryParameters = {
      'dry': '0',
      'app_version': userAgent,
      'email': emailAddress!.rawValue,
      'senha': password!.rawValue,
      'token': resetToken,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest = serverConfiguration.baseUri.replace(
      path: '/reset-password/write-new',
      queryParameters: queryParameters,
    );

    final response = await apiClient.post(httpRequest, headers: httpHeader);
    if (response.statusCode == HttpStatus.ok) {
      return const ValidField();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  Future<Map<String, String>> _setupHttpHeader() async {
    final userAgent = await serverConfiguration.userAgent;
    return {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }

  @override
  Future<ValidField> validToken(
      {EmailAddress? emailAddress, String? resetToken}) async {
    final userAgent = await serverConfiguration.userAgent;
    final Map<String, String?> queryParameters = {
      'dry': '1',
      'app_version': userAgent,
      'email': emailAddress!.rawValue,
      'token': resetToken,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest = serverConfiguration.baseUri.replace(
      path: '/reset-password/write-new',
      queryParameters: queryParameters,
    );

    final response = await apiClient.post(httpRequest, headers: httpHeader);
    if (response.statusCode == HttpStatus.ok) {
      return const ValidField();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }
}
