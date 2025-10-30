# PenhaS

O PenhaS é um aplicativo móvel gratuito de ajuda, informação e acolhimento a mulheres em situação de violência doméstica.


<div>
    <a href='https://play.google.com/store/apps/details?id=penhas.com.br&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Disponível no Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/pt-br_badge_web_generic.png' style="height: 50px" align="center"/></a> <a href="https://apps.apple.com/br/app/penhas/id1441569466?itsct=apps_box_badge&amp;itscg=30200"><img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/pt-br?size=250x83&amp;releaseDate=1627171200?h=cffe6c4b48ab6dc75dbc0f04b34de8c2" alt="Download on the App Store" style="height: 39px" align="center"></a>
</div>

## 📋 Sumário
1. [Visão Geral](#1-visão-geral)  
2. [Funcionalidades](#2-funcionalidades)  
3. [Requisitos](#3-requisitos)  
4. [Configuração](#4-configuração)  
   - [Firebase](#firebase)  
   - [Google Maps](#google-maps)  
5. [Execução](#5-execução)  
6. [Testes Automatizados](#6-testes-automatizados)  
7. [Iniciar pelo VS Code](#7-iniciar-pelo-vs-code)  
8. [Contribuições](#8-contribuições)  
9. [Licença](#9-licença)  


## 1. Visão Geral
O app conecta mulheres entre si em uma rede de apoio e oferece ferramentas práticas para romper o ciclo de violência doméstica.

Qualquer pessoa engajada no enfrentamento à violência contra a mulher pode se cadastrar, conversar com outras pessoas no feed e acessar conteúdos informativos sobre o tema, além de visualizar um **mapa de pontos de apoio** disponíveis em todo o Brasil.

Mulheres (cis ou trans), homens trans e pessoas não binárias têm acesso a funcionalidades exclusivas, como:
- **Botão de pânico**
- **Gravação de áudio** para produção de provas
- **Manual de Fuga** para se preparar para a saída da situação de violência
- **Mapa com pontos de apoio**
- **Espaço de escuta acolhedora**, com atendimento profissional humanizado

Lançado em março de 2019, o PenhaS evoluiu com a colaboração de diversas mulheres e especialistas.

Em 2023, ganhou o **Manual de Fuga**, ferramenta que ajuda mulheres a planejarem uma saída segura de situações de violência.

O projeto é **open source**, licenciado sob **AGPL-3.0**, refletindo o compromisso do **Instituto AzMina** com o uso ético, colaborativo e livre da tecnologia.


## 2. Funcionalidades

- **Feed e Rede de Apoio:** espaço comunitário para compartilhamento de relatos (inclusive anônimos), interação e acesso a conteúdos informativos (reportagens, leis, dicas etc.).  
- **Atendimento profissional personalizado:** canal direto com profissionais experientes e oferecendo orientação confidencial.  
- **Manual de Fuga:** plano personalizado de saída de ambientes violentos, baseado na Lei Maria da Penha.  
- **Botão de Pânico:** envia SMS com localização e pedido de socorro a até cinco contatos de confiança.  
- **Discagem rápida:** ligação direta para o número 190.  
- **Gravação de áudios:** registro discreto de sons do ambiente, gerando possíveis provas jurídicas.  
- **Mapa de Pontos de Apoio:** visualização de delegacias e serviços públicos de atendimento à mulher.

> ⚠️ Para usar todas as funcionalidades, é necessário conceder permissões de localização e microfone.
> Dados sensíveis são tratados de forma segura conforme a política de privacidade do app.


## 3. Requisitos

- [FVM](https://fvm.app/) (recomendável) ou SDK Flutter 3.0.5
- Android SDK
- XCode
- Projetos Android e iOS no Firebase
- Chave de API do Google Maps


## 4. Configuração
Antes de rodar o aplicativo pela primeira vez, são necessárias algumas configurações de serviços externos.

### Firebase

Para ser possível executar o aplicativo, é necessário ter os arquivos de configuração do Firebase, para isso pode ser utilizado o Firebase CLI com o FlutterFire, siga o primeiro passo na [documentação oficial](https://firebase.google.com/docs/flutter/setup?platform=ios#install-cli-tools) para instalar as ferramentas de linha de comando.

Instalar a gem do xcode para que o comando funcione corretamente (Obrigatório caso for buildar o app em iOS)

```bash
gem install xcodeproj
```

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

> 🔒 Mantenha esses arquivos fora do controle de versão.


## 5. Execução

Com tudo configurado, execute:

```bash
fvm flutter run --dart-define=PENHAS_BASE_URL=[URL]
```

## 6. Testes automatizados

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

No VS Code, Também é possível instalar a extensão [Coverage Gutters](https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters), do [ryanluker](https://github.com/ryanluker/vscode-coverage-gutters) e a [Flutter Coverage](https://marketplace.visualstudio.com/items?itemName=Flutterando.flutter-coverage), do Fluterando.




## 7. Iniciar app pelo VS Code

Para iniciar o app utilizando o VS Code adicione os seguintes arquivos dentro da pasta `.vscode`

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

## 8. Contribuições 💜
Quer contribuir? Siga estas orientações:

1. **Issues:** relate bugs ou sugestões de melhoria.  
2. **Fork + PR:** crie uma branch e envie um Pull Request com descrição clara das alterações.  
3. **Padrões de código:** siga o estilo definido em `analysis_options.yaml`.  
4. **Testes:** inclua testes automatizados sempre que possível.  
5. **Documentação:** atualize o README e arquivos relacionados.  
6. **Code Review:** aceite feedbacks e colabore de forma construtiva.

> Cada contribuição fortalece uma ferramenta essencial na luta contra a violência de gênero. 

---

## 9. Licença
Este projeto está licenciado sob a **AGPL-3.0 (Affero General Public License)**.  
O código pode ser usado e modificado livremente, desde que as distribuições derivadas mantenham a mesma licença e disponibilizem seu código-fonte.

---

<p align="center"><em>Desenvolvido com ♥ pelo Instituto AzMina</em></p>

