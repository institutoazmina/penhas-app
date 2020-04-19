import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfo networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfo(mockDataConnectionChecker);
  });

  group('NetworkInfo', () {
    test('should forward the call to DataConnectionChecker.hasConnection', () {
      // arrange
      final hasConnectionFuture = Future.value(true);
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => hasConnectionFuture);
      // act
      final result = networkInfo.isConnected;
      // assert
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, hasConnectionFuture);
    });
  });
}
