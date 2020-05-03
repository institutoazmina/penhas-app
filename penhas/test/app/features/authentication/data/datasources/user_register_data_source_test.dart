import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/datasources/user_register_data_source.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

import '../../../../../utils/json_util.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  MockHttpClient apiclient;
  MockApiServerConfigure serverConfiguration;
  Uri serverEndpoint;
  Cep cep;
  Cpf cpf;
  EmailAddress emailAddress;
  Password password;
  Fullname fullname;
  Nickname nickName;
  Birthday birthday;
  Genre genre;
  HumanRace race;
  UserRegisterDataSource dataSource;

  setUp(() {
    emailAddress = EmailAddress("valid@email.com");
    password = Password('_myStr0ngP@ssw0rd');
    cep = Cep('63024-370');
    cpf = Cpf('23693281343');
    fullname = Fullname('Maria da Penha Maia Fernandes');
    nickName = Nickname('penha');
    birthday = Birthday('1994-01-01');
    race = HumanRace.brown;
    genre = Genre.female;

    serverEndpoint = Uri.https('api.anyserver.io', '/');
    apiclient = MockHttpClient();
    serverConfiguration = MockApiServerConfigure();
    dataSource = UserRegisterDataSource(
      apiClient: apiclient,
      serverConfiguration: serverConfiguration,
    );

    // MockApiServerConfigure configuration
    when(serverConfiguration.baseUri).thenAnswer((_) => serverEndpoint);
    when(serverConfiguration.userAgent())
        .thenAnswer((_) => Future.value("iOS 11.4/Simulator/1.0.0"));
  });

  Future<Map<String, String>> setupHttpHeader() async {
    final userAgent = await serverConfiguration.userAgent();
    return {
      'User-Agent': userAgent,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }

  Future<Map<String, dynamic>> setupQueryParameters(
      {@required bool justValidadeField}) async {
    final userAgent = await serverConfiguration.userAgent();
    return {
      'app_version': userAgent,
      'dry': justValidadeField ? '1' : '0',
      'email': emailAddress.rawValue,
      'senha': password.rawValue,
      'cep': cep.rawValue,
      'cpf': cpf.rawValue,
      'nome_completo': fullname.rawValue,
      'apelido': nickName.rawValue,
      'dt_nasc': birthday.rawValue,
      'genero': genre.rawValue,
      'raca': race.rawValue
    };
  }

  Future<Uri> setupHttpRequest({@required bool justValidadeField}) async {
    final queryParameters =
        await setupQueryParameters(justValidadeField: justValidadeField);
    return Uri(
      scheme: serverEndpoint.scheme,
      host: serverEndpoint.host,
      path: '/signup',
      queryParameters: queryParameters,
    );
  }

  group('UserRegisterDataSource', () {
    test(
        'should perform a POST with parameters and application/x-www-form-urlencoded header',
        () async {
      // arrange
      final bodyContent =
          JsonUtil.getStringSync(from: 'authentication/login_success.json');
      when(apiclient.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(bodyContent, 200));
      final headers = await setupHttpHeader();
      final loginUri = await setupHttpRequest(justValidadeField: false);
      // act
      await dataSource.register(
          emailAddress: emailAddress,
          password: password,
          cep: cep,
          cpf: cpf,
          fullname: fullname,
          nickName: nickName,
          birthday: birthday,
          genre: genre,
          race: race);
      // assert
      verify(apiclient.post(loginUri, headers: headers));
    });
  });
}
