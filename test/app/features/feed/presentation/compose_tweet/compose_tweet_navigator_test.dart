import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_navigator.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_store.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_controller.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_page.dart';

void main() {
  late MainboardStore mockMainboardStore;
  late IModularNavigator mockModularNavigator;
  late BuildContext mockContext;
  late MainboardPageState mockMainBoardPageState;
  late MainboardController mockMainBoardController;

  setUpAll(() {
    registerFallbackValue(const MainboardState.compose());
  });

  setUp(() {
    mockMainboardStore = _MainBoardStoreMock();
    mockContext = _MockContext();
    mockMainBoardPageState = _MockMainBoardPageState();
    mockMainBoardController = _MockMainBoardController();
    Modular.navigatorDelegate = mockModularNavigator = ModularNavigatorMock();

    when(() => mockContext.findAncestorStateOfType<MainboardPageState>())
        .thenReturn(mockMainBoardPageState);
    when(() => mockMainBoardPageState.controller)
        .thenReturn(mockMainBoardController);
    when(() => mockMainBoardController.mainboardStore)
        .thenReturn(mockMainboardStore);
  });

  group(ComposeTweetNavigator, () {
    test(
      'should pop navigation when currentUri ends with /compose',
      () async {
        // arrange
        final sut = ComposeTweetNavigator(
          currentUri: Uri.parse('/mainboard/compose'),
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
        );
        when(() => mockMainboardStore.changePage(to: any(named: 'to')))
            .thenAnswer((_) async {});

        // act
        await sut.navigateToFeed(mockContext);

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
        );
        when(() => mockMainboardStore.changePage(to: any(named: 'to')))
            .thenAnswer((_) async {});

        // act
        await sut.navigateToFeed(mockContext);

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

class _MainBoardStoreMock extends Mock implements MainboardStore {}

class ModularNavigatorMock extends Mock implements IModularNavigator {}

class _MockContext extends Mock implements BuildContext {}

class _MockMainBoardController extends Mock implements MainboardController {}

class _MockMainBoardPageState extends Mock implements MainboardPageState {
  @override
  String toString({
    DiagnosticLevel minLevel = DiagnosticLevel.info,
  }) =>
      'MainboardPageState';
}
