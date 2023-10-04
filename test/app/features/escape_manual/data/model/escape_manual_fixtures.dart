import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual.dart';
import 'package:penhas/app/features/escape_manual/domain/entity/escape_manual.dart';

final escapeManualModelFixture = EscapeManualRemoteModel(
  assistant: const EscapeManualAssistantRemoteModel(
    title: 'text',
    subtitle: 'explanation',
    quizSession: QuizSessionModel(
      sessionId: 'sessionId',
    ),
  ),
  tasks: [
    EscapeManualTaskRemoteModel(
      id: 'id',
      type: 'type',
      group: 'group',
      title: 'title',
      description: 'description',
      isEditable: true,
      userInputValue: 'userInputValue',
      updatedAt: DateTime.now(),
    ),
  ],
);

const escapeManualEntityFixture = EscapeManualEntity(
  assistant: EscapeManualAssistantEntity(
    explanation: 'explanation',
    action: EscapeManualAssistantActionEntity(
      text: 'text',
      quizSession: QuizSessionModel(
        sessionId: 'sessionId',
      ),
    ),
  ),
  sections: [
    EscapeManualTasksSectionEntity(
      title: 'group',
      tasks: [
        EscapeManualTaskEntity(
          id: 'id',
          type: 'type',
          description: 'description',
          isDone: false,
          isEditable: true,
          userInputValue: 'userInputValue',
        ),
      ],
    ),
  ],
);

final escapeManualRemoteModelFixture = EscapeManualRemoteModel(
  assistant: const EscapeManualAssistantRemoteModel(
    title: 'action button',
    subtitle: 'Explanation',
    quizSession: QuizSessionModel(
      sessionId: 'MF1234',
    ),
  ),
  tasks: [
    EscapeManualTaskRemoteModel(
      id: '71',
      type: 'checkbox',
      group: 'Itens Básicos',
      description:
          'Organize uma mochila com roupas. Se achar que a mochila levantará suspeita, separe em sacolas plásticas algumas mudas de roupa. Você pode ir separando as peças de roupas no decorrer dos dias para não levantar suspeitas.',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701023000),
    ),
    EscapeManualTaskRemoteModel(
      id: '72',
      type: 'checkbox',
      group: 'Itens Básicos',
      description: 'Ponha na mochila medicamentos básicos e de uso contínuo',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701023000),
    ),
    EscapeManualTaskRemoteModel(
      id: '73',
      type: 'checkbox',
      group: 'Passos para fuga',
      description:
          'Cadastre-se e/ou verifique se o seu Cadastro Único (CadÚnico) está ativo.',
      isEditable: true,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701023000),
    ),
    EscapeManualTaskRemoteModel(
      id: '75',
      type: 'checkbox',
      group: 'Segurança pessoal',
      description:
          'Busque o Centro de Referência de Assistência Social (CRAS).',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701025000),
    ),
    EscapeManualTaskRemoteModel(
      id: '76',
      type: 'checkbox',
      group: 'Passos para fuga',
      description:
          'Leve ao CRAS toda documentação necessária, tanto sua, quanto das crianças, se houver.',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701025000),
    ),
  ],
);
