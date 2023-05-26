import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_aquarius.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_aries.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_cancer.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_capricorn.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_gemini.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_leo.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_libra.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_pisces.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_sagittarius.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_scorpio.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_taurus.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_virgo.dart';
import 'package:penhas/app/features/zodiac/domain/usecases/zodiac.dart';

void main() {
  group(Zodiac, () {
    late Zodiac sut;

    setUp(() {
      sut = Zodiac();
    });

    group('pickEightRandomSign', () {
      test('exclude the current signs from random sign list', () {
        // arrange
        final birthday = DateTime.parse('1990-03-21');
        final currentSign = sut.sign(birthday);
        // act
        final result = sut.pickEightRandomSign(birthday);
        // assert
        expect(result.contains(currentSign), isFalse);
      });
    });

    group('sign', () {
      group('return ZodiacSignAries when birthday is', () {
        test('03/21', () {
          // arrange
          final birthday = DateTime.parse('1990-03-21');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignAries>());
        });

        test('04/20', () {
          // arrange
          final birthday = DateTime.parse('1990-04-20');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignAries>());
        });
      });

      group('return ZodiacSignTaurus when birthday is', () {
        test('04/21', () {
          // arrange
          final birthday = DateTime.parse('1991-04-21');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignTaurus>());
        });

        test('05/03', () {
          // arrange
          final birthday = DateTime.parse('1991-05-03');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignTaurus>());
        });

        test('05/20', () {
          // arrange
          final birthday = DateTime.parse('1991-05-20');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignTaurus>());
        });
      });

      group('return ZodiacSignGemini when birthday is', () {
        test('05/21', () {
          // arrange
          final birthday = DateTime.parse('1992-05-21');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignGemini>());
        });

        test('06/20', () {
          // arrange
          final birthday = DateTime.parse('1992-06-20');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignGemini>());
        });
      });

      group('return ZodiacSignCancer when birthday is', () {
        test('06/21', () {
          // arrange
          final birthday = DateTime.parse('1993-06-21');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignCancer>());
        });

        test('07/22', () {
          // arrange
          final birthday = DateTime.parse('1993-07-22');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignCancer>());
        });
      });

      group('return ZodiacSignLeo when birthday is', () {
        test('07/23', () {
          // arrange
          final birthday = DateTime.parse('1994-07-23');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignLeo>());
        });

        test('08/22', () {
          // arrange
          final birthday = DateTime.parse('1994-08-22');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignLeo>());
        });
      });

      group('return ZodiacSignVirgo when birthday is', () {
        test('08/23', () {
          // arrange
          final birthday = DateTime.parse('1995-08-23');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignVirgo>());
        });

        test('09/22', () {
          // arrange
          final birthday = DateTime.parse('1995-09-22');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignVirgo>());
        });
      });

      group('return ZodiacSignLibra when birthday is', () {
        test('09/23', () {
          // arrange
          final birthday = DateTime.parse('1996-09-23');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignLibra>());
        });

        test('10/22', () {
          // arrange
          final birthday = DateTime.parse('1996-10-22');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignLibra>());
        });
      });

      group('return ZodiacSignScorpio when birthday is', () {
        test('10/23', () {
          // arrange
          final birthday = DateTime.parse('1997-10-23');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignScorpio>());
        });

        test('11/21', () {
          // arrange
          final birthday = DateTime.parse('1997-11-21');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignScorpio>());
        });
      });

      group('return ZodiacSignSagittarius when birthday is', () {
        test('11/22', () {
          // arrange
          final birthday = DateTime.parse('1998-11-22');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignSagittarius>());
        });

        test('12/21', () {
          // arrange
          final birthday = DateTime.parse('1998-12-21');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignSagittarius>());
        });
      });

      group('return ZodiacSignCapricorn when birthday is', () {
        test('12/22', () {
          // arrange
          final birthday = DateTime.parse('1999-12-22');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignCapricorn>());
        });

        test('01/20', () {
          // arrange
          final birthday = DateTime.parse('1999-01-20');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignCapricorn>());
        });
      });

      group('return ZodiacSignAquarius when birthday is', () {
        test('01/21', () {
          // arrange
          final birthday = DateTime.parse('2000-01-21');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignAquarius>());
        });

        test('02/19', () {
          // arrange
          final birthday = DateTime.parse('2000-02-19');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignAquarius>());
        });
      });

      group('return ZodiacSignPisces when birthday is', () {
        test('02/20', () {
          // arrange
          final birthday = DateTime.parse('2000-02-20');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignPisces>());
        });

        test('03/20', () {
          // arrange
          final birthday = DateTime.parse('2000-03-20');
          // act
          final result = sut.sign(birthday);
          // assert
          expect(result, isA<ZodiacSignPisces>());
        });
      });
    });
  });
}
