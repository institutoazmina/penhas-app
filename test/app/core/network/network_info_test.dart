import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  late INetworkInfo networkInfo;
  late final MockDataConnectionChecker mockDataConnectionChecker =
      MockDataConnectionChecker();

  setUp(() {
    networkInfo = NetworkInfo(mockDataConnectionChecker);
  });

  group(NetworkInfo, () {
    test('forward the call to DataConnectionChecker.hasConnection', () async {
      // arrange
      const expected = true;
      when(() => mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);
      // act
      final actual = await networkInfo.isConnected;
      // assert
      verify(() => mockDataConnectionChecker.hasConnection).called(1);
      expect(actual, expected);
    });
  });
}
