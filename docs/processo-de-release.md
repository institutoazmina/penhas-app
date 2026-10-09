# Processo de release (Android)

## 1. Bump da versão

Em `pubspec.yaml`, incremente nome e build number:

```yaml
version: 3.7.4+71
```

O nome da versão (`3.7.4`) é o que vai para a loja. O build number (`+71`) é só
um piso: a lane usa `max(build do pubspec, maior versionCode já enviado ao
Play) + 1`, então reexecutar o workflow nunca colide com um upload anterior.

Descreva as mudanças na seção `## [Unreleased]` do `CHANGELOG.md`.

## 2. PR e merge no upstream

```bash
git switch -c chore/release-3.7.4
git commit -am "chore: bump para 3.7.4+71"
git push origin chore/release-3.7.4
gh pr create --repo institutoazmina/penhas-app --base main --head wura-io:chore/release-3.7.4
```

Aguarde o merge antes de seguir.

## 3. Rodar o workflow

Pela UI: **Actions → Distribute app → Run workflow**, com
`environment = production` e `platform = android` (ou `all` para iOS junto).

Ou:

```bash
gh workflow run distribute.yml \
  --repo institutoazmina/penhas-app --ref main \
  -f environment=production -f platform=android
```

O mesmo workflow faz o staging (`-f environment=staging`): Android vai para o
Firebase App Distribution e iOS para o TestFlight do app de teste (ver
[testflight-testes.md](testflight-testes.md)). Para mandar a build Android só
para alguns testadores, use `-f android_testers=a@x.com,b@y.com`.

Dispare sempre pelo upstream — pelo fork o pipeline falha.

Acompanhe:

```bash
gh run watch <run-id> --repo institutoazmina/penhas-app
```

Leva ~10 min. No sucesso o log traz `Successfully finished the upload to
Google Play`, e o AAB entra em Produção como **rascunho**.

## 4. Promover no Play Console

1. **Testar e lançar → Produção**
2. Na versão em **Rascunho**, clique em **Editar versão**
3. Confira `versionCode` e `versionName`
4. Preencha as **Notas da versão**
5. **Próxima** → resolva o que aparecer em **Resumo do erro**
6. Escolha a **porcentagem de lançamento**
7. **Iniciar lançamento para produção**

Depois, em **Publicar visão geral**: se houver mudanças pendentes, clique em
**Enviar mudanças para revisão**. Com publicação gerenciada ativa, após a
aprovação clique em **Publicar alterações**.

Revisão do Google: 1 a 7 dias. Alertas de conformidade do Play só se encerram
quando a release chega à produção — rascunho não conta.
