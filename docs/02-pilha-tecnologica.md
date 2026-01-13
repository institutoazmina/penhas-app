# Pilha Tecnológica

## Visão Geral

O aplicativo PenhaS utiliza tecnologias modernas e confiáveis para garantir performance, segurança e manutenibilidade. Esta documentação detalha as principais tecnologias, frameworks e bibliotecas utilizadas no projeto.

## Framework Principal

### Flutter (SDK 3.2.0+)

- **Framework multiplataforma** para desenvolvimento de aplicações móveis nativas
- **Dart** como linguagem de programação
- **Hot Reload** para desenvolvimento rápido
- **Widget-based UI** para interfaces consistentes

## Gerenciamento de Estado e Arquitetura

### Flutter Modular (^5.0.3)
- Sistema de injeção de dependência
- Roteamento modular
- Organização de código em módulos independentes

### MobX (^2.0.5) + Flutter MobX (^2.0.5)
- Gerenciamento reativo de estado
- Observáveis e ações
- Integração perfeita com Flutter
- Code generation com `mobx_codegen`

### Dartz (^0.10.1)
- Programação funcional em Dart
- Tipo `Either` para tratamento de erros
- Operações funcionais

## Armazenamento e Persistência

### Hive Flutter (^1.1.0)
- Banco de dados NoSQL local
- Alta performance
- Criptografia nativa
- Type-safe com adaptadores

### Flutter Secure Storage (^9.2.4)
- Armazenamento seguro de dados sensíveis
- Criptografia AES
- Keychain (iOS) e Keystore (Android)

### Shared Preferences (^2.0.11)
- Armazenamento de preferências simples
- Dados não sensíveis
- Configurações do usuário

## Comunicação com Backend

### HTTP (^1.2.2)
- Cliente HTTP para requisições REST
- Suporte a interceptors
- Gerenciamento de headers

### Equatable (^2.0.3)
- Comparação de objetos
- Útil para estados e entidades

## Funcionalidades de Segurança e Emergência

### Flutter Background Service (^5.1.0)
- Execução de tarefas em segundo plano
- Essencial para botão de pânico
- Notificações persistentes

### Geolocator (^12.0.0)
- Localização GPS
- Rastreamento de posição
- Permissões de localização

### Permission Handler (^11.4.0)
- Gerenciamento de permissões do sistema
- Solicitação e verificação de permissões

## Mapas e Localização

### Google Maps Flutter (2.2.0)
- Integração com Google Maps
- Marcadores personalizados
- Visualização de pontos de apoio

### Map Launcher (^3.0.0)
- Integração com apps de mapas nativos
- Navegação turn-by-turn
- Suporte múltiplos apps de mapa

## Mídia e Comunicação

### Flutter Sound (^9.25.4)
- Gravação e reprodução de áudio
- Suporte a múltiplos formatos
- Controle de qualidade de áudio

### Flutter HTML (^3.0.0)
- Renderização de conteúdo HTML
- Suporte a CSS customizado
- Widgets nativos

### WebView Flutter (^4.9.0)
- Visualização de conteúdo web
- JavaScript bridge
- Navegação controlada

## Analytics e Monitoramento

### Firebase Core (3.12.1)
- Infraestrutura Firebase
- Configuração base

### Firebase Analytics (11.4.3)
- Análise de comportamento do usuário
- Eventos customizados
- Funis de conversão

### Firebase Crashlytics (4.3.4)
- Relatórios de crash em tempo real
- Stack traces detalhados
- Análise de estabilidade

### Firebase Remote Config (^5.4.2)
- Feature toggles
- Configuração remota
- A/B testing

## UI/UX e Design

### Flutter SVG (^2.0.0)
- Renderização de SVGs
- Ícones escaláveis
- Otimização de assets

### Badges (^2.0.2)
- Notificações visuais
- Contadores em ícones

### Asuka (^2.2.1)
- Snackbars e dialogs globais
- Navegação simplificada
- Overlays customizados

### Flutter Widget from HTML (^0.16.0)
- Conversão HTML para widgets
- Renderização otimizada

## Utilitários de Desenvolvimento

### Build Runner (^2.1.5)
- Code generation
- Automatização de tarefas
- Watch mode para desenvolvimento

### Freezed (^2.0.4)
- Immutable classes
- Union types
- JSON serialization

### JSON Serializable (^6.3.1)
- Serialização/deserialização JSON
- Type-safe
- Code generation

### Logger (^2.0.2)
- Sistema de logs estruturado
- Níveis de log configuráveis
- Pretty printing

## Testes

### Flutter Test (SDK)
- Framework de testes nativo
- Widget tests
- Unit tests

### Mocktail (^1.0.0)
- Mocking framework
- Sintaxe limpa
- Null safety

### Golden Toolkit (^0.15.0)
- Golden tests
- Comparação visual
- Testes de regressão visual

### Alchemist (^0.11.0)
- Golden tests avançados
- CI/CD integration
- Múltiplas plataformas

## Ferramentas de Build e Deploy

### Fastlane
- Automação de deploy
- Build e distribuição
- Integração com lojas

### Firebase App Distribution
- Distribuição beta
- Gestão de testers
- Feedback integrado

## Dependências Auxiliares

### UUID (^4.3.3)
- Geração de identificadores únicos

### Intl (^0.19.0)
- Internacionalização
- Formatação de datas/números

### Path Provider (^2.0.8)
- Acesso a diretórios do sistema
- Paths platform-specific

### Device Info Plus
- Informações do dispositivo
- Identificação de plataforma

### Package Info Plus
- Informações do app
- Versão e build number

### RxDart (^0.28.0)
- Extensões reativas
- Streams avançados

### Timeago (^3.1.0)
- Formatação de tempo relativo
- "há 5 minutos"

### URL Launcher (^6.1.7)
- Abertura de URLs
- Suporte a schemes customizados

## Considerações de Versão

- **Flutter SDK**: Mínimo 3.2.0, máximo 4.0.0
- **Dart SDK**: Compatível com Flutter SDK
- **Android**: Min SDK 21 (Android 5.0)
- **iOS**: Deployment target 11.0

## Gerenciamento de Dependências

O projeto utiliza:
- **pubspec.yaml** para declaração de dependências
- **pubspec.lock** para versões fixas
- **FVM** para gerenciamento de versão do Flutter

## Próximos Passos

- Veja a [Estrutura do Projeto](03-estrutura-projeto.md) para entender a organização do código
- Consulte a [Configuração do Ambiente](09-configuracao-desenvolvimento.md) para setup inicial
- Revise as [Funcionalidades Principais](04-funcionalidades.md) para entender o uso das tecnologias