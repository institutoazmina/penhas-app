#  Feature Toggles

Para criar ou modificar as [feature toggles](https://pt.wikipedia.org/wiki/Feature_toggle) do projeto, é preciso acessar o [Remote Config](https://firebase.google.com/docs/remote-config), onde as toggles são definidas.

No momento, as toggles são diferenciadas por app (dev ou produção) e também plataforma (iOS ou Android).

Após a criação (ou mudança) da toggle, o dado é atualizado para a usuária a partir de uma hora (no mínimo).

Este valor `(minimumFetchInterval)` pode ser diminuído durante o desenvolvimento de uma feature, mas deve ser mantido quando mergeado em `main` ou `develop`.

É preciso que a usuária tenha acesso a internet e que reinicie o app para obter o novo valor da toggle.

## Carregamento das toggles

O carregamento das toggles ocorre [seguindo a estratégia descrita na documentação do Firebase](https://firebase.google.com/docs/remote-config/loading?hl=pt-br#strategy_3_load_new_values_for_next_startup).

No caso de não ser possível acessar as toggles (por falha de conexão ou outro motivo), valores default são definidos no app `(_remoteConfig.setDefaults)`.

## Como utilizar as toggles

Um exemplo de como utilizar as toggles está disponível em `LoginOfflineToggleFeature`.

Basicamente, utilize `IRemoteConfigService` para acessar o valor da toggle.


Mais informações:

- [Feature Toggles (aka Feature Flags)](https://martinfowler.com/articles/feature-toggles.html)
- [Firebase Remote Config loading Strategies](https://firebase.google.com/docs/remote-config/loading)
- [Entender a Configuração remota em tempo real](https://firebase.google.com/docs/remote-config/real-time?hl=pt-br)
- [Introdução à Configuração remota do Firebase](https://firebase.google.com/docs/remote-config/get-started?hl=pt-br)