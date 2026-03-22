# Funcionalidades Principais

## Visão Geral

O aplicativo PenhaS oferece um conjunto abrangente de funcionalidades projetadas para apoiar mulheres em situações de violência doméstica. Cada funcionalidade foi cuidadosamente desenvolvida considerando segurança, privacidade e facilidade de uso.

## 1. Autenticação e Segurança

### Login e Registro
- **Registro seguro** com validação de dados
- **Login tradicional** com email e senha
- **Modo camuflado** (Stealth Mode) para situações de emergência
- **Login anônimo** para acesso rápido a recursos essenciais

### Modo Camuflado (Stealth Mode)
```dart
// Ativação através de sequência especial na tela de login
// Aparência de calculadora ou app inofensivo
// Acesso rápido às funcionalidades de emergência
```

Características:
- Interface disfarçada
- Acesso com PIN especial
- Dados criptografados separadamente
- Logout automático por inatividade

## 2. Central de Ajuda (Help Center)

### Botão de Pânico
- **Acionamento rápido** em situações de emergência
- **Envio de localização** para contatos de confiança
- **Gravação de áudio** automática
- **Notificação silenciosa** para não alertar o agressor

### Rede de Guardiões
- Cadastro de até 5 contatos de confiança
- Envio de alertas via SMS
- Compartilhamento de localização em tempo real
- Histórico de alertas enviados

### Gravação de Áudio
- Gravação discreta de evidências
- Armazenamento seguro e criptografado
- Sincronização com servidor quando houver conexão
- Limite de duração configurável

## 3. Feed Social

### Publicações
- **Compartilhamento de experiências** de forma anônima ou identificada
- **Sistema de apoio** através de reações
- **Moderação de conteúdo** para ambiente seguro
- **Filtros por categoria** (violência física, psicológica, etc.)

### Interações
```dart
// Tipos de interação disponíveis
enum TweetAction {
  like,     // Demonstrar apoio
  comment,  // Adicionar comentário de suporte
  report,   // Reportar conteúdo inadequado
  share     // Compartilhar (com cuidado)
}
```

### Filtros e Preferências
- Filtros por tipo de violência
- Ocultar conteúdo sensível
- Preferências de notificação
- Modo de leitura anônimo

## 4. Chat Seguro

### Canais de Comunicação
1. **Chat com Suporte Profissional**
   - Atendimento por profissionais treinados
   - Horário de atendimento configurável
   - Fila de espera transparente

2. **Chat Privado entre Usuárias**
   - Mensagens criptografadas ponta a ponta
   - Verificação de identidade
   - Bloqueio e denúncia de usuários

### Recursos do Chat
- Indicador de digitação
- Confirmação de leitura opcional
- Histórico de conversas
- Busca em mensagens

## 5. Pontos de Apoio (Support Centers)

### Mapa Interativo
- **Localização de serviços** próximos
- **Delegacias especializadas** da mulher
- **Centros de atendimento** psicológico e jurídico
- **Abrigos** e casas de acolhimento

### Funcionalidades do Mapa
```dart
// Tipos de pontos de apoio
enum SupportCenterType {
  police,        // Delegacias
  legal,         // Apoio jurídico
  psychological, // Apoio psicológico
  shelter,       // Abrigos
  health         // Serviços de saúde
}
```

### Informações Detalhadas
- Horário de funcionamento
- Telefones de contato
- Serviços oferecidos
- Avaliações de outras usuárias
- Rotas e navegação

## 6. Manual de Fuga

### Planejamento Seguro
- **Checklist personalizada** de itens importantes
- **Documentos necessários** organizados
- **Planejamento financeiro** básico
- **Estratégias de saída** segura

### Tarefas e Acompanhamento
```dart
class EscapeManualTask {
  String title;
  String description;
  bool isCompleted;
  DateTime? completedAt;
  TaskCategory category; // Documentos, Finanças, Segurança, etc.
}
```

### Sincronização e Backup
- Salvamento automático local
- Sincronização quando online
- Exportação segura de dados
- Compartilhamento controlado

## 7. Quiz de Avaliação de Risco

### Avaliação Personalizada
- Questionários baseados em evidências científicas
- Análise de risco de violência
- Recomendações personalizadas
- Acompanhamento temporal

### Tipos de Avaliação
1. **Violência Física**
2. **Violência Psicológica**
3. **Violência Sexual**
4. **Violência Patrimonial**
5. **Violência Moral**

### Resultados e Orientações
- Score de risco
- Orientações específicas
- Recursos recomendados
- Histórico de avaliações

## 8. Sistema de Notificações

### Tipos de Notificação
- **Alertas de segurança**
- **Mensagens do chat**
- **Atualizações do feed**
- **Lembretes do manual de fuga**

### Configurações
- Notificações silenciosas
- Horários permitidos
- Prioridade por tipo
- Modo não perturbe

## 9. Perfil e Configurações

### Gestão de Perfil
- Informações básicas (podem ser fictícias por segurança)
- Avatar personalizado
- Biografia opcional
- Configurações de privacidade

### Preferências do App
- Tema (claro/escuro)
- Idioma
- Tamanho da fonte
- Modo de economia de dados

### Segurança da Conta
- Alteração de senha
- Autenticação em duas etapas (planejado)
- Dispositivos autorizados
- Exclusão segura de conta

## 10. Feature Toggles

Sistema de ativação/desativação remota de funcionalidades:

```dart
// Configurações disponíveis via Remote Config
class FeatureFlags {
  bool loginOffline;        // Login no modo offline
  bool chatPrivateEnabled;  // Chat privado entre usuárias
  bool escapeManualEnabled; // Manual de fuga
  int quizAnimationDuration; // Duração das animações
}
```

## 11. Modo Offline

### Funcionalidades Disponíveis Offline
- Acesso ao manual de fuga salvo
- Visualização de pontos de apoio cached
- Gravação de áudio local
- Leitura de conteúdo baixado

### Sincronização Inteligente
- Queue de ações pendentes
- Sincronização automática ao conectar
- Priorização de dados críticos
- Feedback visual do status

## 12. Acessibilidade

### Recursos de Acessibilidade
- Suporte a leitores de tela
- Alto contraste
- Tamanhos de fonte ajustáveis
- Navegação por teclado (em tablets)

## Integrações Entre Funcionalidades

As funcionalidades trabalham de forma integrada:

1. **Help Center + Guardiões**: Alertas automáticos
2. **Chat + Feed**: Suporte direto a autoras
3. **Quiz + Manual de Fuga**: Recomendações baseadas em risco
4. **Pontos de Apoio + Navegação**: Rotas seguras
5. **Notificações + Modo Camuflado**: Alertas discretos

## Considerações de Segurança

Todas as funcionalidades são desenvolvidas com foco em:
- **Privacidade**: Dados mínimos e criptografados
- **Discrição**: Interfaces que não chamam atenção
- **Rapidez**: Acesso rápido em emergências
- **Confiabilidade**: Funcionamento em condições adversas

## Próximos Passos

- Entenda o [Gerenciamento de Estado](05-gerenciamento-estado.md) das funcionalidades
- Veja [Autenticação e Segurança](06-autenticacao-seguranca.md) em detalhes
- Explore a [Integração com API](07-integracao-api.md) para sincronização de dados