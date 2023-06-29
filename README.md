# PenhaS

<div>
    <a href='https://play.google.com/store/apps/details?id=penhas.com.br&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Disponível no Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/pt-br_badge_web_generic.png' style="height: 50px" align="center"/></a> <a href="https://apps.apple.com/br/app/penhas/id1441569466?itsct=apps_box_badge&amp;itscg=30200"><img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/pt-br?size=250x83&amp;releaseDate=1627171200?h=cffe6c4b48ab6dc75dbc0f04b34de8c2" alt="Download on the App Store" style="height: 39px" align="center"></a>
</div>

## Requisitos

- [FVM](https://fvm.app/) (recomendável) ou SDK Flutter ^2.10.0
- Android SDK
- XCode
- Projetos Android e iOS no Firebase
- Chave de API do Google Maps

## Configuração

### Firebase

Para ser possível executar o aplicativo, é necessário ter os arquivos de configuração do Firebase, para isso pode ser utilizado o Firebase CLI com o FlutterFire, siga o primeiro passo na [documentação oficial](https://firebase.google.com/docs/flutter/setup?platform=ios#install-cli-tools) para instalar as ferramentas de linha de comando.

Após as ferramentas serem instaladas podemos baixar esses arquivos com o seguinte comando:

```bash
flutterfire configure -y \
    --project=penhas-v3 \ # ou substitua pelo nome do projeto registrado
    --out=lib/firebase_options.dart \
    --platforms=android,ios \
    --android-package-name=dev.penhas.com.br \
    --ios-bundle-id=dev.penhas.alphacode.com.br
```

### Google Maps

Para exibição dos pontos de apoio, utilizamos o Google Maps SDK para Flutter, siga os passos na página do plugin para gerar a chave de API e habilitar o Google Maps para as plataformas Android e iOS: https://pub.dev/packages/google_maps_flutter


A chave gerada deve ser colocada nos arquivos de configuração do Android e iOS que ficam localizados em `android/secrets.properties` e `ios/Flutter/Secrets.xcconfig` respectivamente, crie esses arquivos caso não existam e coloque a chave da seguinte maneira:

```
GEO_API_KEY=[SUA CHAVE DE API]
```

## Execução

```bash
fvm flutter run --dart-define=PENHAS_BASE_URL=[URL]
```

## Testes automatizados

Para rodar os testes automatizados:

```bash
fvm flutter test
```

Para gerar relatório em html da cobertura dos testes execute

```
genhtml coverage/lcov.info -o coverage/html
```

O arquivo gerado estará disponível em `coverage/html/index.html`.
Para executar o comando é preciso ter o pacote [lcov](https://wiki.documentfoundation.org/Development/Lcov) instalado.

No VS Code, Também é possível instalar a extensão [Coverage Gutters](https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters), do [ryanluker](https://github.com/ryanluker/vscode-coverage-gutters), [Flutter Coverage](https://marketplace.visualstudio.com/items?itemName=Flutterando.flutter-coverage), do Fluterando.




## Iniciar app pelo VS Code

Para iniciar o app utilizando o vs code adicione os seguintes arquivos dentro da pasta `.vscode`

```
- launch.json
- settings.json
```

Aponte sua configuração para o sdk utilizado pelo fvm em `settings.json`. Geralmente elas ficam na pasta `.fvm/`:

```
{
    "dart.flutterSdkPath": ".fvm/flutter_sdk",
    "search.exclude": {
      "**/.fvm": true
    },
    "files.watcherExclude": {
      "**/.fvm": true
    }
  }
```

E em `launch.json` adicione 

```
{
  "version": "0.0.1",
  "configurations": [
    {
      "name": "Flutter",
      "request": "launch",
      "type": "dart",
      "program": "./lib/main.dart"
    }
  ]
}
```

Caso queira iniciar o app apontando para um ambiente diferente, isso pode ser feito utilizando o argumento `PENHAS_BASE_URL`. A configuração do arquivo ficaria como abaixo, substituindo `<URL_DO_AMBIENTE>` pela url a ser utilizada.


```
{
  "version": "0.0.1",
  "configurations": [
    {
      "name": "Flutter",
      "request": "launch",
      "type": "dart",
      "program": "./lib/main.dart",
      "args": ["--dart-define=PENHAS_BASE_URL=<URL_DO_AMBIENTE>"]
    }
  ]
}
```

      