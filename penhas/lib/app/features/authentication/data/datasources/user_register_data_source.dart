import 'package:meta/meta.dart';
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
