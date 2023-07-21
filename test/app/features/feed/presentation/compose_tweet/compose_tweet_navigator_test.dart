import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_navigator.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_store.dart';

void main() {
  late MainboardStore mockMainboardStore;
  late IModularNavigator mockModularNavigator;

  setUpAll(() {
    registerFallbackValue(const MainboardState.compose());
  });

  setUp(() {
    mockMainboardStore = MainboardStoreMock();
    Modular.navigatorDelegate = mockModularNavigator = ModularNavigatorMock();
  });

  group(ComposeTweetNavigator, () {
    test(
      'should pop navigation when currentUri ends with /compose',
      () async {
        // arrange
        final sut = ComposeTweetNavigator(
          currentUri: Uri.parse('/mainboard/compose'),
          mainboardStore: mockMainboardStore,
        );

        // act
        await sut.navigateToFeed();

        // assert
        verify(() => mockModularNavigator.pop()).called(1);
        verifyZeroInteractions(mockMainboardStore);
      },
    );

    test(
      'should change to feed tab when currentUri is null',
      () async {
        // arrange
        final sut = ComposeTweetNavigator(
          currentUri: null,
          mainboardStore: mockMainboardStore,
        );
        when(() => mockMainboardStore.changePage(to: any(named: 'to')))
            .thenAnswer((_) async {});

        // act
        await sut.navigateToFeed();

        // assert
        verify(
          () => mockMainboardStore.changePage(
            to: const MainboardState.feed(),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockMainboardStore);
      },
    );

    test(
      'should change to feed tab when currentUri not ends with /compose',
      () async {
        // arrange
        final sut = ComposeTweetNavigator(
          currentUri: Uri.parse('/mainboard'),
          mainboardStore: mockMainboardStore,
        );
        when(() => mockMainboardStore.changePage(to: any(named: 'to')))
            .thenAnswer((_) async {});

        // act
        await sut.navigateToFeed();

        // assert
        verify(
          () => mockMainboardStore.changePage(
            to: const MainboardState.feed(),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockMainboardStore);
      },
    );
  });
}

class MainboardStoreMock extends Mock implements MainboardStore {}

class ModularNavigatorMock extends Mock implements IModularNavigator {}
