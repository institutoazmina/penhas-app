import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/network_info.dart';

import '../../../utils/helper.mocks.dart';

void main() {
  late NetworkInfo networkInfo;
  late final MockDataConnectionChecker mockDataConnectionChecker =
      MockDataConnectionChecker();

  setUp(() {
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
