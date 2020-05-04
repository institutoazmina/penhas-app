import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

abstract class IUserRegisterDataSource {
  Future<SessionModel> register({
    @required EmailAddress emailAddress,
    @required Password password,
    @required Cep cep,
    @required Cpf cpf,
    @required Fullname fullname,
    @required Nickname nickName,
    @required Birthday birthday,
    @required Genre genre,
    @required HumanRace race,
  });

  Future<ValidField> checkField({
    EmailAddress emailAddress,
    Password password,
    Cep cep,
    Cpf cpf,
    Fullname fullname,
    Nickname nickName,
    Birthday birthday,
    Genre genre,
    HumanRace race,
  });
}

class UserRegisterDataSource implements IUserRegisterDataSource {
  final http.Client apiClient;
  final IApiServerConfigure serverConfiguration;

  UserRegisterDataSource({
    @required this.apiClient,
    @required this.serverConfiguration,
  });

  @override
  Future<SessionModel> register({
    @required EmailAddress emailAddress,
    @required Password password,
    @required Cep cep,
    @required Cpf cpf,
    @required Fullname fullname,
    @required Nickname nickName,
    @required Birthday birthday,
    @required Genre genre,
    @required HumanRace race,
  }) async {
    final userAgent = await serverConfiguration.userAgent();
    final Map<String, String> queryParameters = {
      'app_version': userAgent,
      'dry': '0',
      'email': emailAddress.rawValue,
      'senha': password.rawValue,
      'cep': cep.rawValue,
      'cpf': cpf.rawValue,
      'nome_completo': fullname.rawValue,
      'apelido': nickName.rawValue,
      'dt_nasc': birthday.rawValue,
      'genero': genre.rawValue,
      'raca': race.rawValue,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest =
        await _setupHttpRequest(queryParameters: queryParameters);
    final response = await apiClient.post(httpRequest, headers: httpHeader);
    if (response.statusCode == HttpStatus.ok) {
      return SessionModel.fromJson(json.decode(response.body));
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  @override
  Future<ValidField> checkField({
    EmailAddress emailAddress,
    Password password,
    Cep cep,
    Cpf cpf,
    Fullname fullname,
    Nickname nickName,
    Birthday birthday,
    Genre genre,
    HumanRace race,
  }) async {
    final userAgent = await serverConfiguration.userAgent();
    final Map<String, String> queryParameters = {
      'app_version': userAgent,
      'dry': '1',
      'email': emailAddress?.rawValue,
      'senha': password?.rawValue,
      'cep': cep?.rawValue,
      'cpf': cpf?.rawValue,
      'nome_completo': fullname?.rawValue,
      'apelido': nickName?.rawValue,
      'dt_nasc': birthday?.rawValue,
      'genero': genre?.rawValue,
      'raca': race?.rawValue,
    };

    final httpHeader = await _setupHttpHeader();
    final httpRequest =
        await _setupHttpRequest(queryParameters: queryParameters);
    final response = await apiClient.post(httpRequest, headers: httpHeader);
    if (response.statusCode == HttpStatus.ok) {
      return ValidField();
    } else {
      throw ApiProviderException(bodyContent: json.decode(response.body));
    }
  }

  Future<Map<String, String>> _setupHttpHeader() async {
    final userAgent = await serverConfiguration.userAgent();
    return {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }

  Future<Uri> _setupHttpRequest(
      {@required Map<String, String> queryParameters}) async {
    queryParameters.removeWhere((k, v) => v == null);
    return Uri(
      scheme: serverConfiguration.baseUri.scheme,
      host: serverConfiguration.baseUri.host,
      path: '/signup',
      queryParameters: queryParameters,
    );
  }
}
