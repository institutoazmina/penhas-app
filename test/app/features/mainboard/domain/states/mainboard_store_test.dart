// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_store.dart';

void main() {
  group(MainboardStore, () {
    late MainboardStore store;
    late IAppModulesServices mockServices;
    late PageController pageController;

    setUp(() {
      mockServices = MockIAppModulesServices();
      pageController = MockPageController();
      when(() => mockServices.feature(name: any(named: 'name')))
          .thenAnswer((_) async => FakeAppStateModuleEntity());
      when(() => mockServices.isEnabled(any())).thenAnswer((_) async => true);

      store = MainboardStore(
        modulesServices: mockServices,
        initialPage: const MainboardState.feed(),
        pageController: pageController,
      );
    });

    test('initializes with the correct initial page', () {
      // arrange
      const expectedPage = MainboardState.feed();
      // act
      final result = store.selectedPage;
      // assert
      expect(result, equals(expectedPage));
    });

    test('setupProgress initializes with the correct pages', () async {
      // arrange
      const expectedPages = [
        MainboardState.feed(),
        MainboardState.compose(),
        MainboardState.helpCenter(),
        MainboardState.chat(),
        MainboardState.supportPoint(),
      ];
      // act
      await store.setupProgress;
      final result = store.pages;
      // assert
      expect(result, equals(expectedPages));
      verify(
        () => pageController.jumpToPage(
          expectedPages.indexOf(const MainboardState.feed()),
        ),
      ).called(1);
    });

    test('jumps to the correct page when changePage is called', () async {
      // arrange
      await store.setupProgress;
      final expectedPage = MainboardState.chat();
      final expectedIndex = store.pages.indexOf(expectedPage);
      // act
      await store.changePage(to: expectedPage);
      // assert
      expect(store.selectedPage, equals(expectedPage));
      verify(() => pageController.jumpToPage(expectedIndex)).called(1);
    });
  });
}

class MockIAppModulesServices extends Mock implements IAppModulesServices {}

class FakeAppStateModuleEntity extends Fake implements AppStateModuleEntity {}

class MockPageController extends Mock implements PageController {}
