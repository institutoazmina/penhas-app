# Build e Deploy

## Visão Geral

Este documento detalha o processo de build e deploy do aplicativo PenhaS para as plataformas Android e iOS. O projeto utiliza Fastlane para automatizar grande parte do processo de distribuição.

## Configuração Inicial

### Fastlane

O projeto já possui configuração do Fastlane. Para instalar as dependências:

```bash
# Instalar Fastlane
gem install fastlane

# Ou via Bundler (recomendado)
bundle install

# Verificar instalação
fastlane --version
```

### Estrutura Fastlane

```
penhas-app/
├── fastlane/
│   ├── Fastfile       # Configurações globais
│   └── Pluginfile     # Plugins utilizados
├── android/
│   └── fastlane/
│       ├── Appfile    # Configurações Android
│       └── Fastfile   # Lanes Android
└── ios/
    └── fastlane/
        ├── Appfile    # Configurações iOS
        ├── Deliverfile # Metadados App Store
        └── Fastfile   # Lanes iOS
```

## Build Android

### 1. Configuração de Assinatura

#### Criar Keystore

```bash
keytool -genkey -v -keystore penhas-release.keystore \
  -alias penhas -keyalg RSA -keysize 2048 -validity 10000
```

#### Configurar `android/key.properties`

```properties
storePassword=sua_senha_aqui
keyPassword=sua_senha_aqui
keyAlias=penhas
storeFile=../penhas-release.keystore
```

#### Configurar `android/app/build.gradle`

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### 2. Build Manual

#### APK (Android Package)

```bash
# Build APK para testes
fvm flutter build apk --release \
  --dart-define=PENHAS_BASE_URL=https://api.penhas.com.br

# APK split por arquitetura (menor tamanho)
fvm flutter build apk --split-per-abi --release \
  --dart-define=PENHAS_BASE_URL=https://api.penhas.com.br
```

#### AAB (Android App Bundle)

```bash
# Build AAB para Play Store
fvm flutter build appbundle --release \
  --dart-define=PENHAS_BASE_URL=https://api.penhas.com.br
```

### 3. Build via Fastlane

```bash
cd android

# Build APK
fastlane build_apk

# Build Bundle
fastlane build_bundle

# Distribuir via Firebase
fastlane firebase_distribute

# Deploy para Play Store
fastlane release_distribute
```

### 4. Configuração Play Store

#### Service Account

1. Acessar [Google Play Console](https://play.google.com/console)
2. Configurações → Acesso à API → Criar novo projeto
3. Criar conta de serviço
4. Baixar JSON de credenciais
5. Adicionar ao projeto como `android/play-store-credentials.json`

#### Fastlane Appfile

```ruby
# android/fastlane/Appfile
json_key_file("../play-store-credentials.json")
package_name("penhas.com.br")
```

## Build iOS

### 1. Configuração de Certificados

#### Criar Certificados e Provisioning Profiles

```bash
cd ios

# Login na Apple
fastlane fastlane-credentials add \
  --username seu_apple_id@example.com

# Criar certificados
fastlane match development
fastlane match adhoc
fastlane match appstore
```

#### Configurar Match

Criar `ios/fastlane/Matchfile`:

```ruby
git_url("https://github.com/seu-usuario/certificates")
storage_mode("git")
type("development")
app_identifier(["br.com.penhas", "dev.penhas.alphacode.com.br"])
username("seu_apple_id@example.com")
```

### 2. Build Manual

```bash
# Build sem assinatura
fvm flutter build ios --release --no-codesign \
  --dart-define=PENHAS_BASE_URL=https://api.penhas.com.br

# Abrir no Xcode para assinar
open ios/Runner.xcworkspace
```

### 3. Build via Fastlane

```bash
cd ios

# Gerar IPA para testes
fastlane build

# Distribuir via Firebase
fastlane firebase_distribute

# Deploy para TestFlight
fastlane release_distribute
```

### 4. Configuração App Store Connect

#### API Key

1. Acessar [App Store Connect](https://appstoreconnect.apple.com)
2. Usuários e Acesso → Chaves → Gerar chave API
3. Baixar arquivo .p8
4. Criar `ios/AuthKey.json`:

```json
{
  "key_id": "XXXXXXXXXX",
  "issuer_id": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
  "key": "-----BEGIN PRIVATE KEY-----\nMIGTAgEAMBMGByqGSM49...\n-----END PRIVATE KEY-----",
  "duration": 1200,
  "in_house": false
}
```

## Firebase App Distribution

### Configuração

1. Instalar plugin:
```bash
fastlane add_plugin firebase_app_distribution
```

2. Configurar Firebase CLI:
```bash
firebase login
firebase projects:list
```

3. Adicionar testers no [Firebase Console](https://console.firebase.google.com)

### Distribuição Android

```bash
cd android

# Distribuir para grupo de testers
fastlane firebase_distribute

# Distribuir para tester específico
fastlane firebase_distribute tester_email:teste@example.com
```

### Distribuição iOS

```bash
cd ios

# Sincronizar dispositivos
fastlane sync_device_info

# Distribuir
fastlane firebase_distribute
```

## CI/CD com GitHub Actions

### Workflow Android

```yaml
# .github/workflows/android-deploy.yml
name: Android Deploy

on:
  push:
    tags:
      - 'v*'

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Java
      uses: actions/setup-java@v3
      with:
        java-version: '11'
        
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.0.5'
        
    - name: Decode Keystore
      run: |
        echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > android/app/penhas-release.keystore
        echo "${{ secrets.KEY_PROPERTIES }}" > android/key.properties
        
    - name: Build AAB
      run: |
        flutter pub get
        flutter build appbundle --release \
          --dart-define=PENHAS_BASE_URL=${{ secrets.API_URL }}
          
    - name: Upload to Play Store
      uses: r0adkll/upload-google-play@v1
      with:
        serviceAccountJsonPlainText: ${{ secrets.PLAY_STORE_JSON }}
        packageName: penhas.com.br
        releaseFiles: build/app/outputs/bundle/release/app-release.aab
        track: internal
```

### Workflow iOS

```yaml
# .github/workflows/ios-deploy.yml
name: iOS Deploy

on:
  push:
    tags:
      - 'v*'

jobs:
  deploy:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.0.5'
        
    - name: Setup Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: '3.0'
        bundler-cache: true
        
    - name: Decode Certificates
      run: |
        echo "${{ secrets.MATCH_PASSWORD }}" > /tmp/match_password
        echo "${{ secrets.APPLE_API_KEY }}" | base64 -d > ios/AuthKey.json
        
    - name: Install Dependencies
      run: |
        flutter pub get
        cd ios && pod install
        
    - name: Build and Deploy
      run: |
        cd ios
        bundle exec fastlane release_distribute
      env:
        MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
        FASTLANE_PASSWORD: ${{ secrets.FASTLANE_PASSWORD }}
```

## Versionamento

### Semantic Versioning

O projeto segue [Semantic Versioning](https://semver.org/):
- **MAJOR.MINOR.PATCH+BUILD**
- Exemplo: `3.7.2+69`

### Atualizar Versão

```yaml
# pubspec.yaml
version: 3.7.2+69  # version+buildNumber
```

### Script de Versionamento

```bash
#!/bin/bash
# scripts/bump_version.sh

current_version=$(grep "version:" pubspec.yaml | sed 's/version: //')
echo "Current version: $current_version"

read -p "New version (x.y.z): " new_version
read -p "Build number: " build_number

sed -i '' "s/version: .*/version: $new_version+$build_number/" pubspec.yaml

echo "Updated to: $new_version+$build_number"
```

## Configurações de Release

### Android

#### Proguard/R8

```proguard
# android/app/proguard-rules.pro
-keep class com.penhas.** { *; }
-keep class io.flutter.** { *; }
-keep class com.google.firebase.** { *; }
```

#### Build Variants

```gradle
// android/app/build.gradle
android {
    flavorDimensions "environment"
    
    productFlavors {
        dev {
            dimension "environment"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
        }
        
        prod {
            dimension "environment"
        }
    }
}
```

### iOS

#### Build Configurations

No Xcode:
1. Runner → Project → Info
2. Adicionar configurações:
   - Debug-Dev
   - Debug-Prod
   - Release-Dev
   - Release-Prod

#### Schemes

Criar schemes para cada ambiente:
- Runner-Dev
- Runner-Prod

## Monitoramento Pós-Deploy

### Crashlytics

```dart
// Verificar crashes em produção
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  
  // Capturar erros Flutter
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  
  // Capturar erros Dart
  runZonedGuarded(() {
    runApp(MyApp());
  }, FirebaseCrashlytics.instance.recordError);
}
```

### Analytics

Monitorar:
- Taxa de instalação
- Taxa de retenção
- Crashes
- Performance

## Rollback

### Android (Play Store)

1. Console → Release → Production
2. Create new release
3. Add APK/AAB from previous release
4. Roll out

### iOS (App Store)

1. App Store Connect → My Apps
2. Remove current version from sale
3. Resubmit previous version

## Checklist de Release

- [ ] Atualizar versão no `pubspec.yaml`
- [ ] Testar em dispositivos reais
- [ ] Verificar feature toggles
- [ ] Atualizar screenshots (se necessário)
- [ ] Preparar release notes
- [ ] Tag no Git
- [ ] Build de produção
- [ ] Upload para stores
- [ ] Monitorar Crashlytics
- [ ] Comunicar equipe

## Próximos Passos

- Revise [Feature Toggles](11-feature-toggles.md) para configurações remotas
- Consulte [Troubleshooting](12-troubleshooting.md) para problemas comuns
- Veja [Configuração do Ambiente](09-configuracao-desenvolvimento.md) para setup inicial