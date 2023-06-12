import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/help_center/domain/states/audios_state.dart';
import 'package:penhas/app/features/help_center/presentation/audios/audios_controller.dart';
import 'package:penhas/app/features/help_center/presentation/audios/audios_page.dart';

import '../../../../../utils/aditional_bind_module.dart';

void main() {
  late AudiosController mockController;

  setUp(() {
    mockController = _MockAudiosController();
    when(() => mockController.loadPage()).thenAnswer((_) => Future.value());

    initModule(
      AditionalBindModule(
        binds: [
          Bind.instance<AudiosController>(mockController),
        ],
      ),
    );
  });

  testWidgets('Audios Page Initial Load', (tester) async {
    // arrange
    when(() => mockController.currentState)
        .thenReturn(const AudiosState.initial());
    final appBar = find.text('Minhas gravações');

    // act
    await tester.pumpWidget(
      const MaterialApp(
        home: AudiosPage(),
      ),
    );

    // assert
    expect(appBar, findsOneWidget);

  });
}

class _MockAudiosController extends Mock implements AudiosController {}
