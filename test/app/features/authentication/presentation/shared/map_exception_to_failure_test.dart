import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';

void main() {
  group(MapExceptionToFailure, () {
    test(
      'should map to InternetConnectionFailure when exception is InternetConnectionException',
      () {
        // arrange
        final exception = InternetConnectionException();

        // act
        final result = MapExceptionToFailure.map(exception);

        // assert
        expect(result, equals(InternetConnectionFailure()));
      },
    );

    test(
      'should map to ServerSideSessionFailed when exception is ApiProviderSessionError',
      () {
        // arrange
        final exception = ApiProviderSessionError();

        // act
        final result = MapExceptionToFailure.map(exception);

        // assert
        expect(result, equals(ServerSideSessionFailed()));
      },
    );

    test(
      'should map to ServerFailure when exception is NetworkServerException',
      () {
        // arrange
        final exception = NetworkServerException();

        // act
        final result = MapExceptionToFailure.map(exception);

        // assert
        expect(result, equals(ServerFailure()));
      },
    );

    test(
      'should map to FileSystemFailure when exception is FileSystemException',
      () {
        // arrange
        const exception = FileSystemException();

        // act
        final result = MapExceptionToFailure.map(exception);

        // assert
        expect(result, equals(FileSystemFailure()));
      },
    );

    group('given ApiProviderException', () {
      test(
        'should map to ServerSideSessionFailed when error is expired_jwt',
        () {
          // arrange
          const exception = ApiProviderException(
            bodyContent: {'error': 'expired_jwt'},
          );

          // act
          final result = MapExceptionToFailure.map(exception);

          // assert
          expect(result, equals(ServerSideSessionFailed()));
        },
      );

      test(
        'should map to GpsFailure when error is no-gps',
        () {
          // arrange
          const exception = ApiProviderException(
            bodyContent: {
              'error': 'no-gps',
              'message': 'no gps error message',
            },
          );

          // act
          final result = MapExceptionToFailure.map(exception);

          // assert
          expect(result, equals(GpsFailure('no gps error message')));
        },
      );

      test(
        'should map to AddressFailure when error is location_not_found',
        () {
          // arrange
          const exception = ApiProviderException(
            bodyContent: {
              'error': 'location_not_found',
              'message': 'location not found error',
            },
          );

          // act
          final result = MapExceptionToFailure.map(exception);

          // assert
          expect(result, equals(AddressFailure('location not found error')));
        },
      );

      test(
        'should map to ServerSideFormFieldValidationFailure when error is not handled',
        () {
          // arrange
          const exception = ApiProviderException(
            bodyContent: {
              'error': 'other error',
              'message': 'message error',
              'field': 'field error',
              'reason': 'reason error',
            },
          );

          // act
          final result = MapExceptionToFailure.map(exception);

          // assert
          expect(
            result,
            equals(
              ServerSideFormFieldValidationFailure(
                error: 'other error',
                field: 'field error',
                reason: 'reason error',
                message: 'message error',
              ),
            ),
          );
        },
      );
    });

    test(
      'should map to ServerFailure when exception is not handled',
      () {
        // arrange
        final exception = Error();

        // act
        final result = MapExceptionToFailure.map(exception);

        // assert
        expect(result, equals(ServerFailure()));
      },
    );
  });
}
