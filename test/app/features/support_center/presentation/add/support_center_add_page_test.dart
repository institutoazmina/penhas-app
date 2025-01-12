import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';
import 'package:penhas/app/features/support_center/presentation/add/support_center_add_controller.dart';
import 'package:penhas/app/features/support_center/presentation/add/support_center_add_page.dart';

import '../../../../../utils/golden_tests.dart';

void main() {
  late SupportCenterUseCase useCase;
  late SupportCenterAddController controller;

  final devices = const [
    Device(
      name: 'iPhone 6',
      size: Size(375, 667),
    ),
    Device(
      name: 'iPhone Pro',
      size: Size(390, 844),
      safeArea: EdgeInsets.only(top: 47, bottom: 34),
    ),
    Device(
      name: 'iPhone Pro Max',
      size: Size(428, 1800),
      safeArea: EdgeInsets.only(top: 47, bottom: 34),
    ),
  ];

  setUp(() {
    useCase = MockSupportCenterUseCase();

    controller = SupportCenterAddController(
      supportCenterUseCase: useCase,
    );
  });

  group(SupportCenterAddPage, () {
    testWidgets(
      'should show loading state when initial',
      (tester) async {
        // arrange
        when(() => useCase.metadata()).thenAnswer(
          (_) async => dartz.Left(ServerFailure()),
        );
        // act
        await tester.pumpWidget(
          MaterialApp(
            home: SupportCenterAddPage(controller: controller),
          ),
        );
        // assert
        expect(find.text('Carregando as categorias'), findsOneWidget);
      },
    );

    testWidgets('should show loaded state with categories', (tester) async {
      // arrange
      when(() => useCase.metadata()).thenAnswer(
        (_) async => dartz.Right(
          SupportCenterMetadataEntity(
            categories: [
              FilterTagEntity(
                id: '1',
                label: 'Categoria 1',
                isSelected: false,
              ),
              FilterTagEntity(
                id: '2',
                label: 'Categoria 2',
                isSelected: false,
              ),
            ],
            projects: [],
          ),
        ),
      );
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: SupportCenterAddPage(controller: controller),
        ),
      );
      await tester.pumpAndSettle();
      // assert
      expect(find.text('Adicionar Ponto'), findsOneWidget);
      expect(find.text('Informação sobre o ponto de apoio'), findsOneWidget);
      expect(find.text('* Marcam os campos com preenchimento obrigatório.'),
          findsOneWidget);
      expect(find.text('Nome *'), findsOneWidget);
      expect(find.text('Categoria *'), findsOneWidget);
      expect(find.text('Abrangência *'), findsOneWidget);
      expect(find.text('Nome do logradouro (Rua, Avenida, etc) *'),
          findsOneWidget);
      expect(find.text('Número *'), findsOneWidget);
      expect(find.text('Complemento'), findsOneWidget);
      expect(find.text('Bairro'), findsOneWidget);
      expect(find.text('Município *'), findsOneWidget);
      expect(find.text('Estado *'), findsOneWidget);
      expect(find.text('CEP'), findsOneWidget);
      expect(find.text('DDD primário'), findsOneWidget);
      expect(find.text('Telefone primário'), findsOneWidget);
      expect(find.text('Telefone é WhatsApp?'), findsOneWidget);
      expect(find.text('DDD secundário'), findsOneWidget);
      expect(find.text('Telefone secundário'), findsOneWidget);

      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -1000));
      await tester.pumpAndSettle();

      expect(find.text('Observação'), findsOneWidget);
    });

    screenshotTest(
      'support center add page - error state',
      fileName: 'support_center_add_page_error',
      pageBuilder: () => SupportCenterAddPage(controller: controller),
      setUp: () {
        when(() => useCase.metadata()).thenAnswer(
          (_) async => dartz.Left(ServerFailure()),
        );
      },
    );

    screenshotTest(
      'support center add page - loaded state',
      fileName: 'support_center_add_page_loaded',
      pageBuilder: () => SupportCenterAddPage(controller: controller),
      devices: devices,
      setUp: () {
        when(() => useCase.metadata()).thenAnswer(
          (_) async => dartz.Right(
            SupportCenterMetadataEntity(
              categories: [
                FilterTagEntity(
                  id: '1',
                  label: 'Categoria 1',
                  isSelected: false,
                ),
                FilterTagEntity(
                  id: '2',
                  label: 'Categoria 2',
                  isSelected: false,
                ),
              ],
              projects: [],
            ),
          ),
        );
      },
    );
  });
}

class MockSupportCenterUseCase extends Mock implements SupportCenterUseCase {}
