# Distribuição de testes iOS via TestFlight

O canal de teste do iOS saiu do Firebase App Distribution e passou para o
TestFlight com **link público**. O testador não precisa mais informar UDID, nem
esperar a build ser re-assinada, nem confiar em certificado nas Configurações —
basta instalar o app TestFlight e clicar num link.

O Android continua no Firebase App Distribution, onde não há dor de UDID.

A distribuição iOS por Firebase (UDID, profile ad-hoc) foi removida. Staging e
produção saem do mesmo workflow, `distribute.yml`; a opção de mandar a build
para e-mails específicos (`android_testers`) vale só para o Android, porque no
TestFlight a entrega é por grupo/link público.

## Como disparar uma build de teste

O pipeline só roda no upstream (`institutoazmina/penhas-app`); o fork `wura-io`
não tem os environments.

```bash
gh workflow run distribute.yml --repo institutoazmina/penhas-app --ref main \
  -f environment=staging -f platform=ios
gh run watch --repo institutoazmina/penhas-app
```

O número de versão vem do `pubspec.yaml`; só o build number é incrementado
automaticamente (`max(build do pubspec, último build no TestFlight) + 1`). O
"What to Test" sai da seção `## [Unreleased]` do `CHANGELOG.md` — se estiver
vazia, a lane usa um texto padrão.

Para builds de **produção**, use o mesmo workflow com `-f environment=production`
(ver [processo-de-release.md](processo-de-release.md)).

## Como o time não-técnico instala

1. Instale o app **TestFlight** pela App Store.
2. Abra o link público do canal de teste (peça ao time técnico).
3. Toque em **Install**. O app de teste aparece **lado a lado** com o PenhaS de
   produção — ele não substitui o app da loja.

Builds do TestFlight expiram em **90 dias**; depois disso é preciso disparar uma
build nova.

---

## Passos manuais de configuração (uma vez só)

O canal usa um app **separado** do de produção, para conviver lado a lado com o
app da loja no mesmo aparelho e apontar para o backend de homologação:

| Item | Valor |
|---|---|
| Bundle ID | `dev.penhas.testflight.com.br` |
| App ID name | PenhaS Testflight Dev App |
| Team ID | `295N44GCDS` (AzMina) |
| Grupo interno | PenhaS Testers |

### A. App Store Connect / Developer Portal

Requer papel **Admin** ou **App Manager**.

1. **Criar o app record** com bundle ID `dev.penhas.testflight.com.br` e SKU
   próprio. O nome precisa ser único na App Store inteira, mesmo para um app que
   nunca será publicado (ex.: "PenhaS Beta Interno"). **Nunca submeta este app
   para App Review de loja** — ele vive só no TestFlight.
2. **Criar provisioning profile App Store** (Distribution → App Store Connect)
   vinculado ao App ID, usando o **mesmo certificado Apple Distribution** já em
   uso (certificado é por Team, não por app — não gere `.p12` novo).

   > ⚠️ O `PenhaS_Dev_Testflight.mobileprovision` gerado inicialmente é
   > **ad-hoc** (`ProfileDistributionType: ADHOC`, com `ProvisionedDevices`) e
   > **não serve** para upload ao TestFlight. Recrie como App Store — esse
   > profile não enumera dispositivos, que é justamente o ponto da migração.

   Anote o nome exato: ele vai para a var `IOS_PROVISIONING_PROFILE`. Se o
   profile não existir, o `sigh` cria um com esse nome automaticamente.
3. **TestFlight → Testers & Groups**:
   - grupo **interno** "PenhaS Testers" (time técnico, até 100 pessoas com papel
     no ASC): ative **"distribuição automática de novas builds"**; as builds
     liberam em minutos, sem review. Grupo interno **não** entra em
     `TESTFLIGHT_GROUPS` — o `pilot` só distribui para grupos externos;
   - grupo **externo** com **Enable Public Link** ligado, quando for abrir para
     o time não-técnico. Aí sim, o nome exato dele vai para `TESTFLIGHT_GROUPS`.
4. **Preencher "Test Information"** (beta description, e-mail de contato,
   política de privacidade). Sem isso o Beta App Review do grupo externo é
   rejeitado.

### B. Firebase

O TestFlight substitui apenas o **canal de distribuição**, não o SDK — Analytics
e Crashlytics seguem reportando pelo plist.

5. No projeto `penhas-v3`, criar (ou localizar) o app iOS com bundle ID
   `dev.penhas.testflight.com.br` e baixar o **`GoogleService-Info.plist`** dele.
   O bundle ID dentro do plist precisa bater com o do build, senão os eventos vão
   para o app errado.
6. Monte o tarball de dev com a mesma estrutura do de produção:

   ```bash
   tar czf ios-build-files-dev.tgz \
     ios/Runner/GoogleService-Info.plist \
     ios/Flutter/Secrets.xcconfig
   base64 -i ios-build-files-dev.tgz | tr -d '\n' | pbcopy
   ```

   O `Secrets.xcconfig` pode ter o mesmo conteúdo do de produção (hoje só
   `GEO_API_KEY`).

### C. GitHub Environment (no upstream)

O canal **reusa o environment `firebase-distribution`**, que já tem as
credenciais Apple, o backend de homologação e o tarball do app de teste. Não
crie environment novo: `APPLE_API_KEY_B64` vive por environment (não no nível de
repositório) e secrets do GitHub são write-only — um environment novo exigiria
recuperar o `.p8` original só para reescrever o que já existe.

A lane é escolhida pelo input `environment` do workflow (`staging` ou
`production`); a var `TARGET_LANE` não é mais usada.

7. Ajustar no environment **`firebase-distribution`**:

   | Tipo   | Nome                       | Valor                          |
   |--------|----------------------------|--------------------------------|
   | var    | `IOS_BUNDLE_ID`            | `dev.penhas.testflight.com.br` |
   | var    | `IOS_PROVISIONING_PROFILE` | `PenhaS Dev Testflight`        |
   | secret | `IOS_BUILD_FILES`          | tarball base64 do passo 6      |

   ```bash
   REPO=institutoazmina/penhas-app
   gh variable set IOS_BUNDLE_ID            --env firebase-distribution --repo $REPO --body "dev.penhas.testflight.com.br"
   gh variable set IOS_PROVISIONING_PROFILE --env firebase-distribution --repo $REPO --body "PenhaS Dev Testflight"
   gh secret   set IOS_BUILD_FILES          --env firebase-distribution --repo $REPO --body "$(cat ios-build-files-dev.b64)"
   ```

   As três são lidas **só pelo iOS** — o job Android do mesmo environment não as
   usa, então a distribuição Android por Firebase segue intacta.

   Não crie `TESTFLIGHT_GROUPS` enquanto só existir o grupo **interno** "PenhaS
   Testers": var ausente vira string vazia, e a lane apenas sobe a build — o
   grupo interno recebe pela distribuição automática do ASC. (`gh variable set`
   com `--body ""` trava lendo stdin; por isso não crie a var vazia.) Quando o
   grupo externo com link público existir, crie a var com o nome exato dele.

   ⚠️ `PENHAS_BASE_URL` é compartilhado com o Android nesse environment — o app
   de teste iOS vai apontar para o mesmo backend que o Android de teste já usa.

   `IOS_PROVISIONING_PROFILE` vazio cai em `PenhaS AppStore`, então os
   environments de produção não precisam de alteração.

### D. Verificação

1. **Auth antes de tudo** — só funciona depois do app record existir (passo A1):

   ```bash
   cd ios && IOS_BUNDLE_ID=dev.penhas.testflight.com.br \
     APPLE_API_KEY_PATH=/caminho/app-store-api-key.json \
     bundle exec fastlane ios verify_app_store_auth
   ```

   Falha aqui significa app record ausente ou permissão errada — corrija antes
   de gastar um run de CI.

2. **Disparar o workflow** e acompanhar (comandos no topo deste documento).
3. **Grupo interno primeiro**: a build aparece em minutos, sem review. Confirma
   assinatura, bundle ID e upload sem esperar a Apple.
4. **Beta App Review** para o grupo externo: ~1 dia na primeira build. Builds
   seguintes normalmente liberam sem novo review.
5. **Convivência**: instale pelo link público num iPhone que já tenha o app de
   produção e confirme que os dois aparecem lado a lado.
6. **Backend**: confirme no app de teste que as chamadas vão para
   `api-hmg.penhas.com.br`, não para produção.

## Limites conhecidos

- Builds do TestFlight expiram em **90 dias** — o canal precisa de builds
  periódicas.
- A **primeira build externa** espera Beta App Review; para iteração rápida use
  o grupo interno.
- O **ícone é idêntico** ao de produção, o que confunde quem tem os dois
  instalados. Um badge no ícone do app dev exigiria asset catalog condicional.
- O upload espera o processamento da build na Apple (necessário para
  `distribute_external`), então o job leva alguns minutos a mais que o do
  Firebase.
