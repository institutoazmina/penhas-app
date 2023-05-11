import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/shared/navigation/app_navigator.dart';
import 'package:penhas/app/shared/navigation/app_route.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class MockModular extends Mock implements IModularNavigator {}

class MockUrlLauncher extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeLaunchOptions());
  });
  group(AppNavigator, () {
    late IModularNavigator mockModular;
    late UrlLauncherPlatform mockUrlLauncher;
    late AppRoute appRoute;

    setUp(() {
      mockModular = MockModular();
      mockUrlLauncher = MockUrlLauncher();
      appRoute = AppRoute('/test?testKey=testValue');
      Modular.navigatorDelegate = mockModular;
      UrlLauncherPlatform.instance = mockUrlLauncher;
    });

    test(
      'push call pushNamed with correct path and arguments',
      () {
        // arrange
        when(
          () =>
              mockModular.pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());
        // action
        AppNavigator.push(appRoute);
        // expect
        verify(() => mockModular.pushNamed(
              appRoute.path,
              arguments: appRoute.args,
            )).called(1);
      },
    );

    test('popUntil return the last route name', () async {
      // arrange
      when(() => mockModular.canPop()).thenReturn(true);
      when(() => mockModular.popUntil(any())).thenAnswer((invocation) {
        invocation.positionalArguments[0](FakeRoute());
      });
      // action
      final lastRouteName =
          await AppNavigator.popUntil(ModalRoute.withName('/'));
      // expect
      expect(lastRouteName, appRoute.path);
    });

    test('popAndPush call popAndPushNamed with correct path and arguments', () {
      // arrange
      when(
        () => mockModular.popAndPushNamed(any(),
            arguments: any(named: 'arguments')),
      ).thenAnswer((_) => Future.value());
      // action
      AppNavigator.popAndPush(appRoute);
      // expect
      verify(() => mockModular.popAndPushNamed(
            appRoute.path,
            arguments: appRoute.args,
          )).called(1);
    });

    group('tryPopOrPushReplacement', () {
      test('call `pop` when `canPop` is true', () {
        // arrange
        when(() => mockModular.canPop()).thenReturn(true);
        when(() => mockModular.pop()).thenAnswer((_) => Future.value());
        // action
        AppNavigator.tryPopOrPushReplacement(appRoute);
        // expect
        verify(() => mockModular.pop()).called(1);
        verifyNever(() => mockModular.pushReplacementNamed(any(),
            arguments: any(named: 'arguments')));
      });
      test('call `pushReplacementNamed` when `canPop` is false', () {
        // arrange
        when(() => mockModular.canPop()).thenReturn(false);
        when(() => mockModular.pushReplacementNamed(any(),
                arguments: any(named: 'arguments')))
            .thenAnswer((_) => Future.value());
        // action
        AppNavigator.tryPopOrPushReplacement(appRoute);
        // expect
        verifyNever(() => mockModular.pop());
        verify(() => mockModular.pushReplacementNamed(appRoute.path,
            arguments: appRoute.args)).called(1);
      });
    });

    group('pushAndRemoveUntil', () {
      test(
        'abandon the flow when hit the last path',
        () async {
          // arrange
          const removeUntil = '/lastPath';
          when(() => mockModular.canPop()).thenReturn(true);
          when(() => mockModular.popUntil(any())).thenAnswer((invocation) {
            invocation.positionalArguments[0](FakeRoute());
          });
          // action
          await AppNavigator.pushAndRemoveUntil(appRoute,
              removeUntil: removeUntil);
          // expect
          verifyNever(() => mockModular.pushNamed(
                any(),
                arguments: any(named: 'arguments'),
              ));
          verifyNever(() => mockModular.pushReplacementNamed(any(),
              arguments: any(named: 'arguments')));
        },
      );
      test(
        'call `pushReplacementNamed` when did not hit the removeUntil path',
        () async {
          // arrange
          const removeUntil = '/removeUntil';
          when(() => mockModular.pushReplacementNamed(
                any(),
                arguments: any(named: 'arguments'),
              )).thenAnswer((_) => Future.value());
          // action
          await AppNavigator.pushAndRemoveUntil(appRoute,
              removeUntil: removeUntil);
          // expect
          verify(() => mockModular.pushReplacementNamed(
                appRoute.path,
                arguments: appRoute.args,
              )).called(1);
          verifyNever(() =>
              mockModular.pushNamed(any(), arguments: any(named: 'arguments')));
        },
      );

      test(
        'call `pushNamed` when removeUntil is same as last path',
        () async {
          // arrange
          const removeUntil = '/lastPath';
          when(() => mockModular.canPop()).thenReturn(true);
          when(() => mockModular.popUntil(any())).thenAnswer((invocation) {
            invocation.positionalArguments[0](FakeRoute(path: removeUntil));
          });
          when(() => mockModular.pushNamed(
                any(),
                arguments: any(named: 'arguments'),
              )).thenAnswer((_) => Future.value());
          // action
          await AppNavigator.pushAndRemoveUntil(appRoute,
              removeUntil: removeUntil);
          // expect
          verify(() => mockModular.pushNamed(
                appRoute.path,
                arguments: appRoute.args,
              ));
          verifyNever(() => mockModular.pushReplacementNamed(any(),
              arguments: any(named: 'arguments')));
        },
      );
    });

    group('launchURL', () {
      test('call launchUrl when url can be launched', () async {
        // arrange
        const url = 'https://example.com';
        when(() => mockUrlLauncher.canLaunch(url))
            .thenAnswer((_) async => true);
        when(() => mockUrlLauncher.launchUrl(
              any(),
              any(),
            )).thenAnswer((_) async => true);
        // action
        await AppNavigator.launchURL(url);
        // expect

        verify(() => mockUrlLauncher.launchUrl(url, any())).called(1);
      });
    });
  });
}

class FakeRoute extends Fake implements Route {
  FakeRoute({
    this.path = '/test',
    this.isHandledPopInternally = false,
  });

  final String path;
  final bool isHandledPopInternally;

  @override
  RouteSettings get settings => RouteSettings(name: path);

  @override
  bool get willHandlePopInternally => isHandledPopInternally;
}

class FakeLaunchOptions extends Fake implements LaunchOptions {}
