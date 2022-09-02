fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## all

### all publish

```sh
[bundle exec] fastlane all publish
```

Publish Android and iOS Apps

----


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

### android release

```sh
[bundle exec] fastlane android release
```

Deploy a new version to the Play Store

### android publish

```sh
[bundle exec] fastlane android publish
```

Publish APK, pass `is_release:true` to Play Store otherwise will be sent to Firebase

----


## iOS

### ios build

```sh
[bundle exec] fastlane ios build
```

Build release IPA

### ios testflight_distribute

```sh
[bundle exec] fastlane ios testflight_distribute
```

Distribute to iOS beta testers in TestFlight

### ios firebase_distribute

```sh
[bundle exec] fastlane ios firebase_distribute
```

Distribute to iOS beta testers in Firebase

### ios publish

```sh
[bundle exec] fastlane ios publish
```

Publish iOS package, pass `is_release:true` to App Store otherwise will be sent to Firebase

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
