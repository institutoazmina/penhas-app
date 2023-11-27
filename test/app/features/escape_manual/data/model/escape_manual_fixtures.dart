import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_local.dart';
import 'package:penhas/app/features/escape_manual/data/model/escape_manual_remote.dart';
import 'package:penhas/app/features/escape_manual/domain/entity/escape_manual.dart';

final escapeManualLocalModelsFixture = [
  EscapeManualTaskLocalModel(
    id: '1',
    isDone: true,
  ),
  EscapeManualTaskLocalModel(
    id: '3',
    isRemoved: true,
  ),
];

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
      id: '1',
      type: 'checkbox',
      group: 'group',
      title: 'title',
      description: 'description',
      isDone: false,
      userInputValue: null,
      updatedAt: DateTime.now(),
    ),
    EscapeManualTaskRemoteModel(
      id: '2',
      type: 'checkbox_contact',
      group: 'group 2',
      title: 'title',
      description: 'description',
      isDone: true,
      updatedAt: DateTime.now(),
    ),
    EscapeManualTaskRemoteModel(
      id: '3',
      type: 'checkbox',
      group: 'group',
      title: 'title',
      description: 'description',
      userInputValue: null,
      updatedAt: DateTime.now(),
    ),
  ],
);

final escapeManualEntityFixture = EscapeManualEntity(
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
          id: '1',
          type: 'checkbox',
          description: 'description',
          isDone: false,
          userInputValue: null,
        ),
        EscapeManualTaskEntity(
          id: '3',
          type: 'checkbox',
          description: 'description',
          userInputValue: null,
          isDone: false,
        ),
      ],
    ),
    EscapeManualTasksSectionEntity(
      title: 'group 2',
      tasks: [
        EscapeManualTaskEntity(
          id: '2',
          type: 'checkbox_contact',
          description: 'description',
          isDone: true,
          userInputValue: null,
        ),
      ],
    ),
  ],
);

final updatedEscapeManualEntityFixture = EscapeManualEntity(
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
          id: '1',
          type: 'checkbox',
          description: 'description',
          isDone: true,
          userInputValue: null,
        ),
      ],
    ),
    EscapeManualTasksSectionEntity(
      title: 'group 2',
      tasks: [
        EscapeManualTaskEntity(
          id: '2',
          type: 'checkbox_contact',
          description: 'description',
          isDone: true,
          userInputValue: null,
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

final updatedEscapeManualRemoteModelFixture = EscapeManualRemoteModel(
  assistant: const EscapeManualAssistantRemoteModel(
    title: 'new action button',
    subtitle: 'New explanation',
    quizSession: QuizSessionModel(
      sessionId: 'session id',
    ),
  ),
  tasks: [
    EscapeManualTaskRemoteModel(
      id: '72',
      type: 'checkbox',
      group: 'Itens Básicos',
      description: 'Ponha na mochila medicamentos básicos e de uso contínuo',
      isDone: true,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1696116772000),
    ),
    EscapeManualTaskRemoteModel(
      id: '73',
      type: 'checkbox',
      group: 'Passos para fuga',
      description:
          'Cadastre-se e/ou verifique se o seu Cadastro Único (CadÚnico) está ativo.',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1696116772000),
      userInputValue: 'campo livre',
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

final escapeManualTaskEntityFixture = EscapeManualTaskEntity(
  id: '1',
  type: 'checkbox',
  description: 'description',
  isDone: true,
  userInputValue: null,
);
