import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_play_tile_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/audios_state.dart';
import 'package:penhas/app/features/help_center/presentation/audios/audios_controller.dart';
import 'package:penhas/app/features/help_center/presentation/audios/audios_page.dart';

import '../../../../../utils/aditional_bind_module.dart';

void main() {
  late AudiosController mockController;

  setUpAll(() {
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

  testWidgets('Audios Page With State Loaded', (tester) async {
    
    // arrange
    initializeDateFormatting();

    const audioDuration = '1m30s';
    const message = 'Você tem 1 áudio gravado';
    const description = 'Toque no ícone para solicitar o audio';


    AudioEntity audioReference = AudioEntity(
      audioDuration: audioDuration,
      canPlay: true,
      createdAt: DateTime(2023, 2, 3, 14, 44),
      id: '123',
      isRequestGranted: true,
      isRequested: true,
    );

    List<AudioPlayTileEntity> audiosList = [
      AudioPlayTileEntity(
        audio: audioReference,
        description: description,
        onPlayAudio: (audioReference) {},
        onActionSheet: (audioReference) {},
      )
    ];

    when(() => mockController.currentState)
        .thenReturn(AudiosState.loaded(audiosList, message));

    final messageWidget = find.text(message);
    final audioDurationWidget = find.text(audioDuration);
    final audioDescriptionWidget = find.text(description);


    // act
    await tester.pumpWidget(
      const MaterialApp(
        home: AudiosPage(),
      ),
    );

    // assert
    expect(messageWidget, findsOneWidget);
    expect(audioDurationWidget, findsOneWidget);
    expect(audioDescriptionWidget, findsOneWidget);

  });
}

class _MockAudiosController extends Mock implements AudiosController {}
