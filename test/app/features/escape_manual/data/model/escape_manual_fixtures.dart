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
    id: '2',
    type: EscapeManualTaskType.contacts,
    value: [
      ContactModel(
        id: 1,
        name: 'Contact name',
        phone: '(00) 00000-0000',
      ),
    ],
  ),
  EscapeManualTaskLocalModel(
    id: '3',
    type: EscapeManualTaskType.contacts,
    value: <ContactModel>[],
    isRemoved: true,
  ),
];

final escapeManualModelFixture = EscapeManualRemoteModel(
  lastModifiedAt: DateTime.fromMillisecondsSinceEpoch(1699916213000),
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
      type: EscapeManualTaskType.normal,
      group: 'group',
      title: 'title',
      description: 'description',
      isDone: false,
      value: null,
      updatedAt: DateTime.now(),
    ),
    EscapeManualTaskRemoteModel(
      id: '2',
      type: EscapeManualTaskType.contacts,
      group: 'group 2',
      title: 'title',
      description: 'description',
      isDone: true,
      updatedAt: DateTime.now(),
    ),
    EscapeManualTaskRemoteModel(
      id: '3',
      type: EscapeManualTaskType.contacts,
      group: 'group',
      title: 'title',
      description: 'description',
      isDone: true,
      value: [
        ContactModel(
          id: 1,
          name: 'Other contact name',
          phone: '(11) 99999-9999',
        ),
      ],
      updatedAt: DateTime.now(),
    ),
    EscapeManualTaskRemoteModel(
      id: '42',
      type: EscapeManualTaskType.button,
      group: 'Transporte',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1706249823000),
      value: ButtonModel(
        label: 'Revisar Transporte',
        route: '/quiz/start?session_id=abcdedfgh',
      ),
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
        EscapeManualDefaultTaskEntity(
          id: '1',
          description: 'description',
          isDone: false,
        ),
        EscapeManualContactsTaskEntity(
          id: '3',
          description: 'description',
          isDone: true,
          value: <ContactEntity>[
            ContactModel(
              id: 1,
              name: 'Other contact name',
              phone: '(11) 99999-9999',
            ),
          ],
        ),
      ],
    ),
    EscapeManualTasksSectionEntity(
      title: 'group 2',
      tasks: [
        EscapeManualContactsTaskEntity(
          id: '2',
          description: 'description',
          isDone: true,
          value: null,
        ),
      ],
    ),
    EscapeManualTasksSectionEntity(
      title: 'Transporte',
      tasks: [
        EscapeManualButtonTaskEntity(
          id: '42',
          button: ButtonModel(
            label: 'Revisar Transporte',
            route: '/quiz/start?session_id=abcdedfgh',
          ),
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
        EscapeManualDefaultTaskEntity(
          id: '1',
          description: 'description',
          isDone: true,
        ),
      ],
    ),
    EscapeManualTasksSectionEntity(
      title: 'group 2',
      tasks: [
        EscapeManualContactsTaskEntity(
          id: '2',
          description: 'description',
          isDone: false,
          value: <ContactEntity>[
            ContactModel(
              id: 1,
              name: 'Contact name',
              phone: '(00) 00000-0000',
            ),
          ],
        ),
      ],
    ),
    EscapeManualTasksSectionEntity(
      title: 'Transporte',
      tasks: [
        EscapeManualButtonTaskEntity(
          id: '42',
          button: ButtonModel(
            label: 'Revisar Transporte',
            route: '/quiz/start?session_id=abcdedfgh',
          ),
        ),
      ],
    ),
  ],
);

final escapeManualRemoteModelFixture = EscapeManualRemoteModel(
  lastModifiedAt: DateTime.fromMillisecondsSinceEpoch(1699916213000),
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
      type: EscapeManualTaskType.normal,
      group: 'Itens Básicos',
      description:
          'Organize uma mochila com roupas. Se achar que a mochila levantará suspeita, separe em sacolas plásticas algumas mudas de roupa. Você pode ir separando as peças de roupas no decorrer dos dias para não levantar suspeitas.',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701023000),
    ),
    EscapeManualTaskRemoteModel(
      id: '72',
      type: EscapeManualTaskType.normal,
      group: 'Itens Básicos',
      description: 'Ponha na mochila medicamentos básicos e de uso contínuo',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701023000),
    ),
    EscapeManualTaskRemoteModel(
      id: '73',
      type: EscapeManualTaskType.normal,
      group: 'Passos para fuga',
      description:
          'Cadastre-se e/ou verifique se o seu Cadastro Único (CadÚnico) está ativo.',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701023000),
    ),
    EscapeManualTaskRemoteModel(
      id: '75',
      type: EscapeManualTaskType.normal,
      group: 'Segurança pessoal',
      description:
          'Busque o Centro de Referência de Assistência Social (CRAS).',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701025000),
    ),
    EscapeManualTaskRemoteModel(
      id: '101',
      type: EscapeManualTaskType.contacts,
      group: 'Contatos',
      description: 'Informe os contatos de pessoas de confiança.',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701025000),
      value: null,
    ),
    EscapeManualTaskRemoteModel(
      id: '42',
      type: EscapeManualTaskType.button,
      group: 'Transporte',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1706249823000),
      value: ButtonModel(
        label: 'Revisar Transporte',
        route: '/quiz/start?session_id=abcdedfgh',
      ),
    ),
  ],
);

final updatedEscapeManualRemoteModelFixture = EscapeManualRemoteModel(
  lastModifiedAt: DateTime.fromMillisecondsSinceEpoch(1699916697000),
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
      type: EscapeManualTaskType.normal,
      group: 'Itens Básicos',
      description: 'Ponha na mochila medicamentos básicos e de uso contínuo',
      isDone: true,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1696116772000),
    ),
    EscapeManualTaskRemoteModel(
      id: '73',
      type: EscapeManualTaskType.normal,
      group: 'Passos para fuga',
      description:
          'Cadastre-se e/ou verifique se o seu Cadastro Único (CadÚnico) está ativo.',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1696116772000),
      value: null,
    ),
    EscapeManualTaskRemoteModel(
      id: '75',
      type: EscapeManualTaskType.normal,
      group: 'Segurança pessoal',
      description:
          'Busque o Centro de Referência de Assistência Social (CRAS).',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701025000),
    ),
    EscapeManualTaskRemoteModel(
      id: '101',
      type: EscapeManualTaskType.contacts,
      group: 'Contatos',
      description: 'Informe os contatos de pessoas de confiança.',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1696116772000),
      value: [
        ContactModel(
          id: 1,
          name: 'Contact name',
          phone: '(11) 99999-9999',
        ),
      ],
    ),
    EscapeManualTaskRemoteModel(
      id: '42',
      type: EscapeManualTaskType.button,
      group: 'Transporte',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1706249823000),
      value: ButtonModel(
        label: 'Revisar Transporte',
        route: '/quiz/start?session_id=abcdedfgh',
      ),
    ),
    EscapeManualTaskRemoteModel(
      id: '76',
      type: EscapeManualTaskType.normal,
      group: 'Passos para fuga',
      description:
          'Leve ao CRAS toda documentação necessária, tanto sua, quanto das crianças, se houver.',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(1689701025000),
    ),
  ],
);

final EscapeManualTaskEntity escapeManualTaskEntityFixture =
    EscapeManualDefaultTaskEntity(
  id: '1',
  description: 'description',
  isDone: true,
);

final EscapeManualEditableTaskEntity escapeManualEditableTaskEntityFixture =
    EscapeManualContactsTaskEntity(
  id: '1',
  description: 'description',
  isDone: true,
  value: <ContactEntity>[
    ContactModel(
      id: 1,
      name: 'Contact name',
      phone: '(00) 00000-0000',
    ),
  ],
);
