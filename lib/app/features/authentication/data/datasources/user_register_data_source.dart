import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_server_configure.dart';
import '../../domain/usecases/birthday.dart';
import '../../domain/usecases/cep.dart';
import '../../domain/usecases/cpf.dart';
import '../../domain/usecases/email_address.dart';
import '../../domain/usecases/full_name.dart';
import '../../domain/usecases/genre.dart';
import '../../domain/usecases/human_race.dart';
import '../../domain/usecases/nickname.dart';
import '../../domain/usecases/sign_up_password.dart';
import '../models/session_model.dart';

abstract class IUserRegisterDataSource {
  Future<SessionModel> register({
    required EmailAddress? emailAddress,
    required SignUpPassword? password,
    required Cep? cep,
    required Cpf? cpf,
    required Fullname? fullname,
    required Fullname? socialName,
    required Nickname? nickName,
    required Birthday? birthday,
    required Genre? genre,
    required HumanRace? race,
  });

  Future<ValidField> checkField({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    Cep? cep,
    Cpf? cpf,
    Fullname? fullname,
    Fullname? socialName,
    Nickname? nickName,
    Birthday? birthday,
    Genre? genre,
    HumanRace? race,
  });
}

class UserRegisterDataSource implements IUserRegisterDataSource {
  UserRegisterDataSource({
    required this.apiClient,
    required this.serverConfiguration,
  });

  final http.Client? apiClient;
  final IApiServerConfigure? serverConfiguration;

  @override
  Future<SessionModel> register({
    required EmailAddress? emailAddress,
    required SignUpPassword? password,
    required Cep? cep,
    required Cpf? cpf,
    required Fullname? fullname,
    Fullname? socialName,
    required Nickname? nickName,
    required Birthday? birthday,
    required Genre? genre,
    required HumanRace? race,
  }) async {
    final userAgent = await serverConfiguration!.userAgent;
    final Map<String, String?> queryParameters = {
      'app_version': userAgent,
      'dry': '0',
      'email': emailAddress!.rawValue,
      'senha': password!.rawValue,
      'cep': cep!.rawValue,
      'cpf': cpf!.rawValue,
      'nome_completo': fullname!.rawValue,
      'nome_social': socialName?.rawValue,
      'apelido': nickName!.rawValue,
      'dt_nasc': birthday!.rawValue,
      'genero': genre?.rawValue,
      'raca': race?.rawValue,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest =
        await _setupHttpRequest(queryParameters: queryParameters);

    final response = await apiClient!.post(httpRequest, headers: httpHeader);
    if (response.statusCode == HttpStatus.ok) {
      return SessionModel.fromJson(json.decode(response.body));
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<ValidField> checkField({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    Cep? cep,
    Cpf? cpf,
    Fullname? fullname,
    Fullname? socialName,
    Nickname? nickName,
    Birthday? birthday,
    Genre? genre,
    HumanRace? race,
  }) async {
    final userAgent = await serverConfiguration!.userAgent;
    final Map<String, String?> queryParameters = {
      'app_version': userAgent,
      'dry': '1',
      'email': emailAddress?.rawValue,
      'senha': password?.rawValue,
      'cep': cep?.rawValue,
      'cpf': cpf?.rawValue,
      'nome_completo': fullname?.rawValue,
      'nome_social': socialName?.rawValue,
      'apelido': nickName?.rawValue,
      'dt_nasc': birthday?.rawValue,
      'genero': genre?.rawValue,
      'raca': race?.rawValue,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest =
        await _setupHttpRequest(queryParameters: queryParameters);
    final response = await apiClient!.post(httpRequest, headers: httpHeader);
    if (response.statusCode == HttpStatus.ok) {
      return const ValidField();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  Future<Map<String, String>> _setupHttpHeader() async {
    final userAgent = await serverConfiguration!.userAgent;
    return {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }

  Future<Uri> _setupHttpRequest({
    required Map<String, String?> queryParameters,
  }) async {
    queryParameters.removeWhere((k, v) => v == null);
    return serverConfiguration!.baseUri.replace(
      path: '/signup',
      queryParameters: queryParameters,
    );
  }
}
