# PenhaS

## Requisitos

- SDK Flutter ^2.10.0
- Ruby Bundler

## Instalação

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## Ambientes

Temos dois ambientes disponíveis:
- PROD (Produção): https://***REMOVED***
- DEV (Desenvolvimento): https://***REMOVED***

## Execução

Além do padrão `flutter run`, temos mais algumas possibilidades fornecidas na aplicação para executá-la:

```bash
flutter run
# OU
flutter run [TARGET]
# OU
flutter run --dart-define=env.apiBaseUrl=[URL]
```
Valores dos argumentos:
- **TARGET**: (posicional, opcional) - indica o arquivo com o entry-point principal da aplicação, possíveis valores:
    - `lib/main.dart` (padrão) para o ambiente de PROD;
    - `lib/main_dev.dart` para ambiente de DEV.
- **URL**: (opcional) - informada utilizando `--dart-define` para atribuir o valor da váriavel de ambiente `env.apiBaseUrl`, que indica a URL base do ambiente. Somente válido quando o `TARGET` for o padrão (`lib/main.dart`), exemplo:
    - `--dart-define=env.apiBaseUrl='https://***REMOVED***'`

_Execute `flutter run --help` para ver as outras opções disponíveis do Flutter._

## Testes automatizados

Para rodar os testes automatizados:

```bash
flutter test
```

## Publicação

Temos dois canais de publicação do app: Beta e Release.

### Beta

Os artefatos enviados por esse canal são encaminhados para os grupos de testes do Firebase e sempre apontão para o ambiente de DEV.

Para fazer parte dos **grupos de testes**, acesse o link da plataforma desejada e informe o e-mail:
- Android: ***REMOVED***
- iOS: ***REMOVED***

Para publicar utilize o comando:
```bash
# para ambas as plataformas
./bin/publish
# somente android
./bin/publish --platform=android
# somente ios
./bin/publish --platform=ios
```

### Release

São os artefatos que serão disponibilizados nas lojas de aplicativos da Google e Apple,  sempre apontarão para o ambiente de PROD, e são enviados primeiramente para os testes internos `Alpha` (Google) e `Test Flight` (Apple), precisando fazer as próximas etapas nos seus respectivos paineis para que possam se tornarem públicas.

Para publicar utilize o comando `./bin/publish` com a flag `--release`, exemplos:
```bash
# para ambas as plataformas
./bin/publish --release
# somente android
./bin/publish --release --platform=android
# somente ios
./bin/publish --release --platform=ios
```
