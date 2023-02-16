import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/datasources/user_register_data_source.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockIApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  final MockHttpClient apiClient = MockHttpClient();
  final MockIApiServerConfigure serverConfiguration = MockIApiServerConfigure();

  final Uri serverEndpoint = Uri.https('api.anyserver.io', '/');
  late Cep cep;
  late Cpf cpf;
  late EmailAddress emailAddress;
  late SignUpPassword password;
  late Fullname fullName;
  late Fullname socialName;
  late Nickname nickName;
  late Birthday birthday;
  late Genre genre;
  late HumanRace race;
  late UserRegisterDataSource dataSource;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    emailAddress = EmailAddress('valid@email.com');
    password = SignUpPassword('_myStr0ngP@ssw0rd', PasswordValidator());
    cep = Cep('63024-370');
    cpf = Cpf('23693281343');
    fullName = Fullname('Maria da Penha Maia Fernandes');
    socialName = Fullname('Maria da Penha');
    nickName = Nickname('penha');
    birthday = Birthday('1994-01-01');
    race = HumanRace.brown;
    genre = Genre.female;

    dataSource = UserRegisterDataSource(
      apiClient: apiClient,
      serverConfiguration: serverConfiguration,
    );

    // MockApiServerConfigure configuration
    when(() => serverConfiguration.baseUri).thenReturn(serverEndpoint);
    when(() => serverConfiguration.userAgent)
        .thenAnswer((_) async => 'iOS 11.4/Simulator/1.0.0');
  });

  Future<Map<String, String>> setupHttpHeader() async {
    final userAgent = await serverConfiguration.userAgent;
    return {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }

  Future<Map<String, dynamic>> setupQueryParameters({
    required bool justValidadeField,
  }) async {
    final userAgent = await serverConfiguration.userAgent;
    final Map<String, String?> queryParameters = {
      'app_version': userAgent,
      'dry': justValidadeField ? '1' : '0',
      'email': emailAddress.rawValue,
      'senha': justValidadeField ? null : password.rawValue,
      'cep': justValidadeField ? null : cep.rawValue,
      'cpf': cpf.rawValue,
      'nome_completo': justValidadeField ? null : fullName.rawValue,
      'nome_social': justValidadeField ? null : socialName.rawValue,
      'apelido': justValidadeField ? null : nickName.rawValue,
      'dt_nasc': justValidadeField ? null : birthday.rawValue,
      'genero': justValidadeField ? null : genre.rawValue,
      'raca': justValidadeField ? null : race.rawValue
    };
    queryParameters.removeWhere((k, v) => v == null);
    return queryParameters;
  }

  Future<Uri> setupHttpRequest({required bool justValidadeField}) async {
    final queryParameters =
        await setupQueryParameters(justValidadeField: justValidadeField);
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: '/signup',
      queryParameters: queryParameters,
    );
  }

  void setupHttpClientSuccess200(String bodyContent) {
    when(() => apiClient.post(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(bodyContent, HttpStatus.ok));
  }

  void setupHttpClientError400() {
    final bodyContent = JsonUtil.getStringSync(
      from: 'authentication/registration_email_already_exists.json',
    );

    when(() => apiClient.post(any(), headers: any(named: 'headers')))
        .thenAnswer(
            (_) async => http.Response(bodyContent, HttpStatus.notFound));
  }

  void setupHttpClientRegisterSuccess() {
    final bodyContent =
        JsonUtil.getStringSync(from: 'authentication/login_success.json');
    setupHttpClientSuccess200(bodyContent);
  }

  group(UserRegisterDataSource, () {
    group('register', () {
      test('must performance POST with user-agent and header configured',
          () async {
        // arrange
        setupHttpClientRegisterSuccess();
        final headers = await setupHttpHeader();
        final loginUri = await setupHttpRequest(justValidadeField: false);
        // act
        await dataSource.register(
          emailAddress: emailAddress,
          password: password,
          cep: cep,
          cpf: cpf,
          fullname: fullName,
          socialName: socialName,
          nickName: nickName,
          birthday: birthday,
          genre: genre,
          race: race,
        );
        // assert
        verify(() => apiClient.post(loginUri, headers: headers)).called(1);
      });
      test(
        'return SessionModel when get HttpStatus.ok',
        () async {
          // arrange
          setupHttpClientRegisterSuccess();
          final jsonData =
              await JsonUtil.getJson(from: 'authentication/login_success.json');
          final sessionModel = SessionModel.fromJson(jsonData);
          // act
          final result = await dataSource.register(
            emailAddress: emailAddress,
            password: password,
            cep: cep,
            cpf: cpf,
            fullname: fullName,
            socialName: socialName,
            nickName: nickName,
            birthday: birthday,
            genre: genre,
            race: race,
          );
          // assert
          expect(result, sessionModel);
        },
      );
      test(
          'return ApiProviderException when the response code is nonsuccess (non 200)',
          () async {
        // arrange
        final bodyContent = await JsonUtil.getJson(
          from: 'authentication/registration_email_already_exists.json',
        );
        setupHttpClientError400();
        // act
        final sut = dataSource.register;
        // assert
        expect(
          () => sut(
            emailAddress: emailAddress,
            password: password,
            cep: cep,
            cpf: cpf,
            fullname: fullName,
            nickName: nickName,
            birthday: birthday,
            genre: genre,
            race: race,
          ),
          throwsA(
            isA<ApiProviderException>()
                .having((e) => e.bodyContent, 'Got bodyContent', bodyContent),
          ),
        );
      });
    });
    group('checkField', () {
      test('must performance POST with user-agent and header configured',
          () async {
        // arrange
        setupHttpClientRegisterSuccess();
        final headers = await setupHttpHeader();
        final loginUri = await setupHttpRequest(justValidadeField: true);
        // act
        await dataSource.checkField(emailAddress: emailAddress, cpf: cpf);
        // assert
        verify(() => apiClient.post(loginUri, headers: headers)).called(1);
      });
      test(
        'return ValidField when get HttpStatus.ok',
        () async {
          // arrange
          const String bodyContent = '{"continue": 1}';
          setupHttpClientSuccess200(bodyContent);
          // act
          final result = await dataSource.checkField(
            emailAddress: emailAddress,
            password: password,
            cep: cep,
            cpf: cpf,
            fullname: fullName,
            socialName: socialName,
            nickName: nickName,
            birthday: birthday,
            genre: genre,
            race: race,
          );

          // assert
          expect(result, const ValidField());
        },
      );
      test(
          'should return ApiProviderException when the response code is nonsuccess (non 200)',
          () async {
        // arrange
        final bodyContent = await JsonUtil.getJson(
          from: 'authentication/registration_email_already_exists.json',
        );
        setupHttpClientError400();
        // act
        final sut = dataSource.checkField;
        // assert
        expect(
          () => sut(emailAddress: emailAddress, cpf: cpf),
          throwsA(
            isA<ApiProviderException>()
                .having((e) => e.bodyContent, 'Got bodyContent', bodyContent),
          ),
        );
      });
    });
  });
}
