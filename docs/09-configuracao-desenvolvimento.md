# Configuração do Ambiente de Desenvolvimento

## Visão Geral

Este guia detalha o processo de configuração do ambiente de desenvolvimento para o aplicativo PenhaS. Siga os passos cuidadosamente para garantir que todas as dependências e ferramentas estejam corretamente instaladas.

## Pré-requisitos

### Sistema Operacional
- **macOS**: Recomendado para desenvolvimento iOS e Android
- **Linux**: Ubuntu 20.04+ ou distribuições similares para Android
- **Windows**: Windows 10+ com WSL2 para melhor compatibilidade

### Ferramentas Essenciais

1. **Git**
   ```bash
   # macOS
   brew install git
   
   # Linux
   sudo apt-get install git
   
   # Windows
   # Baixar de https://git-scm.com/
   ```

2. **VS Code** (Recomendado)
   - Download: https://code.visualstudio.com/
   - Extensões recomendadas:
     - Flutter
     - Dart
     - Flutter Coverage
     - Coverage Gutters
     - GitLens
     - Error Lens

## Instalação do Flutter

### 1. FVM (Flutter Version Management)

O projeto usa FVM para gerenciar versões do Flutter:

```bash
# macOS/Linux
curl -fsSL https://fvm.app/install.sh | bash

# Windows (PowerShell como Admin)
choco install fvm

# Verificar instalação
fvm --version
```

### 2. Instalar Flutter via FVM

```bash
# Navegar até o diretório do projeto
cd penhas-app

# Instalar a versão do Flutter especificada no projeto
fvm install

# Usar a versão instalada
fvm use

# Verificar instalação
fvm flutter --version
```

### 3. Configurar PATH (Opcional)

Para usar `flutter` ao invés de `fvm flutter`:

```bash
# macOS/Linux - adicionar ao ~/.bashrc ou ~/.zshrc
export PATH="$PATH:$HOME/fvm/default/bin"

# Windows - adicionar às variáveis de ambiente
# %USERPROFILE%\fvm\default\bin
```

## Configuração Android

### 1. Android Studio

1. Download: https://developer.android.com/studio
2. Durante instalação, certifique-se de instalar:
   - Android SDK
   - Android SDK Command-line Tools
   - Android SDK Build-Tools
   - Android SDK Platform-Tools

### 2. Configurar Android SDK

```bash
# Verificar instalação
fvm flutter doctor -v

# Aceitar licenças Android
fvm flutter doctor --android-licenses
```

### 3. Configurar Variáveis de Ambiente

```bash
# macOS/Linux - adicionar ao ~/.bashrc ou ~/.zshrc
export ANDROID_HOME=$HOME/Library/Android/sdk  # macOS
export ANDROID_HOME=$HOME/Android/Sdk          # Linux
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

### 4. Criar Emulador Android

1. Abrir Android Studio
2. Tools → AVD Manager
3. Create Virtual Device
4. Recomendado: Pixel 4, API 30+

## Configuração iOS (macOS apenas)

### 1. Xcode

```bash
# Instalar Xcode da App Store
# Após instalação:
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch

# Instalar ferramentas adicionais
xcode-select --install
```

### 2. CocoaPods

```bash
# Instalar CocoaPods
sudo gem install cocoapods

# Ou via Homebrew
brew install cocoapods

# Instalar pods do projeto
cd ios
pod install
cd ..
```

### 3. Configurar Simulador iOS

```bash
# Listar simuladores disponíveis
xcrun simctl list devices

# Abrir simulador
open -a Simulator

# Ou via Flutter
fvm flutter devices
```

## Configuração do Projeto

### 1. Clonar Repositório

```bash
git clone https://github.com/seu-usuario/penhas.git
cd penhas/penhas-app
```

### 2. Instalar Dependências

```bash
# Instalar versão do Flutter
fvm install

# Baixar dependências do projeto
fvm flutter pub get

# Gerar código (freezed, json_serializable, etc)
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Configurar Firebase

#### Instalar Firebase CLI

```bash
# macOS
brew install firebase-cli

# Linux/Windows
npm install -g firebase-tools

# Login
firebase login
```

#### Instalar FlutterFire CLI

```bash
# Instalar globalmente
dart pub global activate flutterfire_cli

# Adicionar ao PATH se necessário
export PATH="$PATH:$HOME/.pub-cache/bin"
```

#### Configurar Firebase no Projeto

```bash
# Configurar para desenvolvimento
flutterfire configure -y \
    --project=penhas-v3-dev \
    --out=lib/firebase_options.dart \
    --platforms=android,ios \
    --android-package-name=dev.penhas.com.br \
    --ios-bundle-id=dev.penhas.alphacode.com.br

# Para produção, usar projeto diferente
flutterfire configure -y \
    --project=penhas-v3 \
    --out=lib/firebase_options_prod.dart \
    --platforms=android,ios \
    --android-package-name=penhas.com.br \
    --ios-bundle-id=br.com.penhas
```

### 4. Configurar Google Maps

#### Obter Chave API

1. Acessar [Google Cloud Console](https://console.cloud.google.com)
2. Criar ou selecionar projeto
3. Ativar Maps SDK for Android e iOS
4. Criar credenciais (API Key)
5. Restringir chave por aplicativo

#### Configurar no Projeto

##### Android
```bash
# Criar arquivo android/secrets.properties
echo "GEO_API_KEY=SUA_CHAVE_AQUI" > android/secrets.properties
```

##### iOS
```bash
# Criar arquivo ios/Flutter/Secrets.xcconfig
echo "GEO_API_KEY = SUA_CHAVE_AQUI" > ios/Flutter/Secrets.xcconfig
```

### 5. Configurar VS Code

Criar `.vscode/settings.json`:

```json
{
  "dart.flutterSdkPath": ".fvm/flutter_sdk",
  "search.exclude": {
    "**/.fvm": true,
    "**/*.freezed.dart": true,
    "**/*.g.dart": true
  },
  "files.watcherExclude": {
    "**/.fvm": true
  },
  "[dart]": {
    "editor.formatOnSave": true,
    "editor.formatOnType": true,
    "editor.rulers": [80],
    "editor.selectionHighlight": false,
    "editor.suggest.snippetsPreventQuickSuggestions": false,
    "editor.suggestSelection": "first",
    "editor.tabCompletion": "onlySnippets",
    "editor.wordBasedSuggestions": false
  }
}
```

Criar `.vscode/launch.json`:

```json
{
  "version": "0.0.1",
  "configurations": [
    {
      "name": "Dev",
      "request": "launch",
      "type": "dart",
      "program": "./lib/main.dart",
      "args": [
        "--dart-define=PENHAS_BASE_URL=https://dev-api.penhas.com.br"
      ]
    },
    {
      "name": "Prod",
      "request": "launch",
      "type": "dart",
      "program": "./lib/main.dart",
      "args": [
        "--dart-define=PENHAS_BASE_URL=https://api.penhas.com.br"
      ]
    },
    {
      "name": "Local",
      "request": "launch",
      "type": "dart",
      "program": "./lib/main.dart",
      "args": [
        "--dart-define=PENHAS_BASE_URL=http://localhost:3000"
      ]
    }
  ]
}
```

## Executar o Projeto

### Via Linha de Comando

```bash
# Listar dispositivos disponíveis
fvm flutter devices

# Executar em modo debug
fvm flutter run --dart-define=PENHAS_BASE_URL=https://dev-api.penhas.com.br

# Executar em dispositivo específico
fvm flutter run -d "iPhone 14" --dart-define=PENHAS_BASE_URL=https://dev-api.penhas.com.br

# Hot reload
r  # No terminal onde o app está rodando

# Hot restart
R  # No terminal onde o app está rodando
```

### Via VS Code

1. Abrir projeto no VS Code
2. Selecionar dispositivo na barra inferior
3. F5 ou Debug → Start Debugging
4. Escolher configuração (Dev, Prod, Local)

## Ferramentas de Desenvolvimento

### 1. Flutter Inspector

- Disponível no VS Code e Android Studio
- Visualizar árvore de widgets
- Debugar layouts
- Performance profiling

### 2. DevTools

```bash
# Abrir DevTools
fvm flutter pub global activate devtools
fvm flutter pub global run devtools

# Ou durante execução
# Pressionar 'd' no terminal do flutter run
```

### 3. Code Generation

```bash
# Watch mode para desenvolvimento
fvm flutter pub run build_runner watch --delete-conflicting-outputs

# Build único
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Limpar cache do build_runner
fvm flutter pub run build_runner clean
```

## Problemas Comuns

### 1. Erro de Versão Flutter

```bash
# Limpar FVM cache
fvm remove [version]
fvm install

# Recriar links
fvm use --force
```

### 2. Erro CocoaPods (iOS)

```bash
cd ios
pod deintegrate
pod cache clean --all
pod install
cd ..
```

### 3. Gradle Issues (Android)

```bash
cd android
./gradlew clean
./gradlew build
cd ..
```

### 4. Build Runner Travado

```bash
# Matar processos
pkill -f dart

# Limpar e reconstruir
fvm flutter clean
fvm flutter pub get
fvm flutter pub run build_runner clean
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Scripts Úteis

Criar `scripts/setup.sh`:

```bash
#!/bin/bash

echo "🚀 Configurando projeto PenhaS..."

# Instalar Flutter via FVM
echo "📦 Instalando Flutter..."
fvm install
fvm use

# Instalar dependências
echo "📚 Instalando dependências..."
fvm flutter pub get

# Gerar código
echo "🔨 Gerando código..."
fvm flutter pub run build_runner build --delete-conflicting-outputs

# iOS setup
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "🍎 Configurando iOS..."
  cd ios && pod install && cd ..
fi

# Verificar setup
echo "🔍 Verificando configuração..."
fvm flutter doctor

echo "✅ Setup completo!"
```

Tornar executável:
```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

## Próximos Passos

- Revise [Build e Deploy](10-build-deploy.md) para distribuição
- Consulte [Testes](08-testes.md) para executar testes
- Veja [Resolução de Problemas](12-troubleshooting.md) para mais soluções