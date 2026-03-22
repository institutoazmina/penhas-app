# Estrutura do Projeto

## Visão Geral

O projeto PenhaS segue uma estrutura modular e bem organizada, facilitando a manutenção, escalabilidade e colaboração entre desenvolvedores. A estrutura reflete os princípios da Clean Architecture e a abordagem modular do Flutter.

## Estrutura de Diretórios Principal

```
penhas-app/
├── android/               # Configurações específicas do Android
├── ios/                   # Configurações específicas do iOS
├── lib/                   # Código-fonte principal do app
├── test/                  # Testes unitários e de widget
├── assets/                # Recursos estáticos (imagens, fontes, etc.)
├── docs/                  # Documentação técnica
├── fastlane/              # Scripts de automação de deploy
├── pubspec.yaml           # Dependências e configurações do projeto
└── analysis_options.yaml  # Regras de análise de código
```

## Estrutura Detalhada do `/lib`

### `/lib/main.dart`
Ponto de entrada da aplicação. Inicializa o bootstrap e configura os runners.

### `/lib/bootstrap/`
Sistema de inicialização do app:
```
bootstrap/
├── bootstrap.dart         # Classe principal de bootstrap
└── impl/
    ├── main_app_runner.dart        # Runner da aplicação principal
    ├── background_tasks_runner.dart # Runner de tarefas em segundo plano
    └── app_runner_mixin.dart       # Mixin compartilhado
```

### `/lib/app/`
Código principal da aplicação:
```
app/
├── app_module.dart        # Módulo raiz com configurações globais
├── app_widget.dart        # Widget raiz da aplicação
├── core/                  # Funcionalidades centrais
├── features/              # Módulos de funcionalidades
└── shared/                # Componentes compartilhados
```

## Estrutura Core (`/lib/app/core/`)

### `analytics/`
- `analytics_wrapper.dart` - Wrapper para Firebase Analytics

### `data/`
- `formz/` - Validadores de formulário reutilizáveis

### `entities/`
- Classes de entidade compartilhadas entre features

### `error/`
- `failures.dart` - Classes de falha customizadas
- Tratamento centralizado de erros

### `extension/`
- Extensões Dart para tipos built-in
- Helpers e utilities

### `managers/`
- `app_configuration.dart` - Configurações globais do app
- `user_profile_store.dart` - Gerenciamento do perfil do usuário
- `audio_sync_manager.dart` - Sincronização de áudios
- `background_task_manager.dart` - Gerenciamento de tarefas em segundo plano
- `local_store.dart` - Interface para armazenamento local

### `network/`
- `api_client.dart` - Cliente HTTP configurado
- `api_server_configure.dart` - Configuração do servidor
- `network_info.dart` - Informações de conectividade

### `pages/`
- Páginas compartilhadas entre módulos
- Componentes de UI reutilizáveis

### `remoteconfig/`
- `i_remote_config.dart` - Interface para Remote Config
- `remote_config.dart` - Implementação Firebase Remote Config

### `states/`
- Estados globais da aplicação
- Enums e tipos compartilhados

### `storage/`
```
storage/
├── cache_storage.dart              # Interface para cache
├── i_local_storage.dart            # Interface para storage local
├── local_storage_shared_preferences.dart # Implementação SharedPreferences
├── migrator_local_storage.dart     # Migração de dados
├── persistent_storage.dart         # Storage persistente
├── secure_local_storage.dart       # Storage seguro
└── impl/
    ├── hive_cache_storage.dart     # Implementação Hive para cache
    └── hive_persistent_storage.dart # Implementação Hive persistente
```

### `types/`
- Tipos e typedefs globais

## Estrutura de Features (`/lib/app/features/`)

Cada feature segue o padrão Clean Architecture:

```
feature_name/
├── data/
│   ├── models/        # DTOs e modelos de dados
│   └── repositories/  # Implementações concretas
├── domain/
│   ├── entities/      # Entidades de negócio
│   ├── repositories/  # Interfaces de repositório
│   ├── states/        # Estados específicos da feature
│   └── usecases/      # Casos de uso
├── presentation/
│   ├── pages/         # Páginas/telas
│   ├── widgets/       # Widgets específicos
│   └── controllers/   # Controllers (MobX stores)
└── feature_module.dart # Módulo da feature
```

### Features Principais:

1. **`appstate/`** - Estado global da aplicação
2. **`authentication/`** - Login, registro, recuperação de senha
3. **`chat/`** - Sistema de mensagens
4. **`escape_manual/`** - Manual de fuga
5. **`feed/`** - Feed de publicações
6. **`filters/`** - Sistema de filtros
7. **`help_center/`** - Central de ajuda e emergência
8. **`main_menu/`** - Menu principal e drawer
9. **`mainboard/`** - Tela principal com bottom navigation
10. **`notification/`** - Sistema de notificações
11. **`quiz/`** - Questionários de avaliação
12. **`splash/`** - Tela de splash
13. **`support_center/`** - Pontos de apoio
14. **`users/`** - Perfis de usuário
15. **`zodiac/`** - Funcionalidade de signos

## Estrutura Shared (`/lib/app/shared/`)

```
shared/
├── design_system/     # Sistema de design
│   ├── colors.dart    # Paleta de cores
│   ├── text_styles.dart # Estilos de texto
│   └── theme.dart     # Tema da aplicação
├── logger/            # Sistema de logs
├── navigation/        # Navegação compartilhada
└── widgets/           # Widgets reutilizáveis
```

## Estrutura de Assets (`/assets/`)

```
assets/
├── fonts/             # Arquivos de fonte
│   ├── ds/            # Design System
│   └── lato/          # Família Lato
├── images/            # Imagens e ícones
    ├── chat/          # Imagens do chat
    ├── svg/           # Ícones SVG organizados por feature
    ├── support_center/ # Imagens dos pontos de apoio
    ├── tutorial_*/    # Imagens dos tutoriais
    └── zodiac/        # Ícones dos signos
```

## Estrutura de Testes (`/test/`)

A estrutura de testes espelha a estrutura do código:

```
test/
├── app/
│   ├── core/          # Testes do core
│   ├── features/      # Testes das features
│   └── shared/        # Testes de componentes compartilhados
├── assets/            # Assets para testes
├── utils/             # Utilitários de teste
│   ├── mocks.dart     # Mocks reutilizáveis
│   └── golden_config.dart # Configuração para golden tests
└── flutter_test_config.dart # Configuração global de testes
```

## Configurações de Plataforma

### Android (`/android/`)
- `app/build.gradle` - Configurações do app
- `app/src/*/AndroidManifest.xml` - Manifestos por flavor
- `fastlane/` - Automação Android

### iOS (`/ios/`)
- `Runner/Info.plist` - Configurações do app
- `Runner.xcodeproj/` - Projeto Xcode
- `fastlane/` - Automação iOS

## Arquivos de Configuração Importantes

### `pubspec.yaml`
- Dependências do projeto
- Configuração de assets
- Metadados do app

### `analysis_options.yaml`
- Regras de linting
- Configurações do analyzer

### `build.yaml`
- Configurações do build_runner
- Code generation

### `.fvm/fvm_config.json`
- Versão do Flutter fixada para o projeto

## Convenções de Nomenclatura

1. **Arquivos**: snake_case (ex: `user_profile_page.dart`)
2. **Classes**: PascalCase (ex: `UserProfilePage`)
3. **Variáveis/Funções**: camelCase (ex: `getUserProfile`)
4. **Constantes**: SCREAMING_SNAKE_CASE ou camelCase prefixado com 'k'
5. **Arquivos privados**: Prefixo underscore (ex: `_private_helper.dart`)

## Organização de Imports

Ordem recomendada:
1. Imports do Dart
2. Imports de packages externos
3. Imports do projeto (relativos)
4. Exports

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/error/failures.dart';
import '../domain/entities/user.dart';
```

## Próximos Passos

- Explore as [Funcionalidades Principais](04-funcionalidades.md) para entender cada módulo
- Veja o [Gerenciamento de Estado](05-gerenciamento-estado.md) para padrões MobX
- Consulte a [Configuração do Ambiente](09-configuracao-desenvolvimento.md) para começar a desenvolver