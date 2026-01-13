# Visão Geral da Arquitetura

## Introdução

O aplicativo PenhaS é construído usando Flutter e segue os princípios da Clean Architecture combinados com uma abordagem modular. Este design arquitetural garante separação de responsabilidades, testabilidade e manutenibilidade, ao mesmo tempo que fornece flexibilidade para o desenvolvimento de funcionalidades.

## Padrões Arquiteturais

### Clean Architecture

A aplicação implementa Clean Architecture com clara separação entre:

1. **Camada de Apresentação** - Componentes de UI, páginas e controllers
2. **Camada de Domínio** - Lógica de negócio, casos de uso e entidades
3. **Camada de Dados** - Repositórios, fontes de dados e modelos

### Arquitetura Modular

O app usa [Flutter Modular](https://pub.dev/packages/flutter_modular) para injeção de dependência e roteamento, organizando o código em módulos de funcionalidades. Cada módulo é autocontido com seus próprios:

- Rotas
- Dependências
- Lógica de negócio
- Componentes de UI

## Componentes Principais da Arquitetura

### 1. Sistema de Bootstrap

A inicialização do app é gerenciada por um sistema de bootstrap que controla:

```dart
// lib/bootstrap/bootstrap.dart
class Bootstrap {
  Future<void> withRunner(Runner runner) async {
    await runner.initialize();
    await runner.configure();
    runner.run();
  }
}
```

Dois runners principais:
- `MainAppRunner` - Inicializa a aplicação principal
- `BackgroundTasksRunner` - Gerencia serviços em segundo plano

### 2. Sistema de Módulos

O módulo raiz (`AppModule`) define:

- Dependências globais
- Rotas principais
- Serviços centrais

```dart
class AppModule extends Module {
  @override
  List<Bind> get binds => [
    // Bindings de repositórios
    Bind.factory<IAppStateRepository>((i) => AppStateRepository(...)),
    
    // Bindings de casos de uso
    Bind.factory<AppStateUseCase>((i) => AppStateUseCase(...)),
    
    // Bindings de serviços
    Bind.lazySingleton<ILocalStorage>((i) => MigratorLocalStorage(...)),
  ];
  
  @override
  List<ModularRoute> get routes => [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/authentication', module: SignInModule()),
    ModuleRoute('/mainboard', module: MainboardModule()),
  ];
}
```

### 3. Gerenciamento de Estado

O app usa [MobX](https://pub.dev/packages/mobx) para gerenciamento reativo de estado:

- **Stores** - Mantêm o estado da aplicação
- **Actions** - Modificam o estado
- **Computed values** - Estado derivado
- **Reactions** - Efeitos colaterais

Exemplo de padrão store:
```dart
abstract class _MainboardStoreBase with Store {
  @observable
  ObservableList<MainboardState> pages = ObservableList();
  
  @observable
  MainboardState selectedPage = const MainboardState.feed();
  
  @action
  Future changePage({required MainboardState to}) async {
    // Lógica de mudança de página
  }
}
```

### 4. Navegação

A navegação é gerenciada através do sistema de roteamento do Flutter Modular:

- Rotas declarativas nos módulos
- Navegação type-safe
- Suporte a deep linking
- Guards de rota para autenticação

## Arquitetura de Funcionalidades

Cada funcionalidade segue uma estrutura consistente:

```
feature/
├── data/
│   ├── models/        # Objetos de transferência de dados
│   └── repositories/  # Implementações de repositórios
├── domain/
│   ├── entities/      # Entidades de negócio
│   ├── repositories/  # Interfaces de repositórios
│   ├── states/        # Definições de estado
│   └── usecases/      # Lógica de negócio
└── presentation/
    ├── pages/         # Telas da UI
    ├── widgets/       # Componentes reutilizáveis
    └── controllers/   # Controllers de página (stores MobX)
```

## Injeção de Dependência

Flutter Modular fornece injeção de dependência com diferentes tempos de vida:

- **Factory** - Nova instância por injeção
- **Singleton** - Instância única durante toda vida do app
- **LazySingleton** - Instância única criada no primeiro uso

## Fluxo de Dados

1. **Interação do Usuário** → UI dispara ação do controller
2. **Controller** → Chama caso de uso com parâmetros
3. **Caso de Uso** → Executa lógica de negócio, chama repositório
4. **Repositório** → Busca/armazena dados via API ou storage local
5. **Resposta** → Dados fluem de volta pelas camadas
6. **Atualização da UI** → Reações MobX atualizam a UI

## Tratamento de Erros

A arquitetura implementa um sistema robusto de tratamento de erros:

- Classes de falha customizadas para diferentes tipos de erro
- Tipo Either (usando Dartz) para tratamento funcional de erros
- Mapeamento centralizado de erros e mensagens amigáveis ao usuário

## Arquitetura de Segurança

- Armazenamento seguro para dados sensíveis
- Autenticação baseada em token
- Modo camuflado para situações de emergência
- Serviço em segundo plano para funcionalidade do botão de pânico

## Decisões Arquiteturais Principais

1. **Clean Architecture** - Garante testabilidade e separação de responsabilidades
2. **Abordagem Modular** - Permite isolamento de funcionalidades e escalabilidade da equipe
3. **MobX para Estado** - Fornece programação reativa com mínimo boilerplate
4. **Padrão Repository** - Abstrai fontes de dados da lógica de negócio
5. **Padrão Use Case** - Encapsula regras de negócio e fluxos de trabalho

## Benefícios

- **Testabilidade** - Cada camada pode ser testada independentemente
- **Manutenibilidade** - Clara separação de responsabilidades
- **Escalabilidade** - Fácil adicionar novas funcionalidades como módulos
- **Reusabilidade** - Componentes e lógica de negócio compartilhados
- **Colaboração em Equipe** - Limites claros entre funcionalidades

## Próximos Passos

- Revise a [Pilha Tecnológica](02-pilha-tecnologica.md) para detalhes de implementação
- Explore a [Estrutura do Projeto](03-estrutura-projeto.md) para organização do código
- Verifique o [Gerenciamento de Estado](05-gerenciamento-estado.md) para padrões MobX