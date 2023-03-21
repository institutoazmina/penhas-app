fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android build_apk

```sh
[bundle exec] fastlane android build_apk
```

Build release APK

### android build_bundle

```sh
[bundle exec] fastlane android build_bundle
```

Build release Bundle

### android firebase_distribute

```sh
[bundle exec] fastlane android firebase_distribute
```

Distribute to Android beta testers

### android release_distribute

```sh
[bundle exec] fastlane android release_distribute
```

Deploy a new version to the Play Store

### android verify_play_store_auth

```sh
[bundle exec] fastlane android verify_play_store_auth
```

Verify if has valid Play Store credentials

### android firebase_id

```sh
[bundle exec] fastlane android firebase_id
```

Get Firebase project ID from config file

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
