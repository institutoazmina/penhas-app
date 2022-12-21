# PenhaS

<div>
    <a href='https://play.google.com/store/apps/details?id=penhas.com.br&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Disponível no Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/pt-br_badge_web_generic.png' style="height: 50px" align="center"/></a> <a href="https://apps.apple.com/br/app/penhas/id1441569466?itsct=apps_box_badge&amp;itscg=30200"><img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/pt-br?size=250x83&amp;releaseDate=1627171200?h=cffe6c4b48ab6dc75dbc0f04b34de8c2" alt="Download on the App Store" style="height: 39px" align="center"></a>
</div>

## Requisitos

- SDK Flutter ^2.10.0
- Android SDK
- XCode
- Projetos Android e iOS no Firebase
- Chave de API do Google Maps

## Configuração

### Firebase

Para ser possível executar o aplicativo, é necessário ter os arquivos de configuração do Firebase, para isso pode ser utilizado o Firebase CLI com o FlutterFire, siga o primeiro passo na documentação oficial (https://firebase.google.com/docs/flutter/setup?platform=ios#install-cli-tools) para instalar as ferramentas de linha de comando.

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


A chave gerada deve ser colocada nos arquivos de configuração do Android e iOS que ficam localizados em `android/local.properties` e `ios/Flutter/Secrets.xcconfig` respectivamente, crie esses arquivos caso não existam e coloque a chave da seguinte maneira:

```
GEO_API_KEY=[SUA CHAVE DE API]
```

## Execução

```bash
flutter run --dart-define=PENHAS_BASE_URL=[URL]
```

## Testes automatizados

Para rodar os testes automatizados:

```bash
flutter test
```

