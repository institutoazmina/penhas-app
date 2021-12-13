fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### pre_build

```sh
[bundle exec] fastlane pre_build
```

Run code generators

----


## Android

### android build

```sh
[bundle exec] fastlane android build
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

----


## iOS

### ios build

```sh
[bundle exec] fastlane ios build
```

Build release IPA

### ios update_profile

```sh
[bundle exec] fastlane ios update_profile
```

Generates a provisioning profile, saving it in the current folder 

### ios sync_device_info

```sh
[bundle exec] fastlane ios sync_device_info
```

Registers new devices to the Apple Dev Portal

### ios generate_ipa

```sh
[bundle exec] fastlane ios generate_ipa
```

Generate IPA

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

### ios release

```sh
[bundle exec] fastlane ios release
```

Deploy a new version to the App Store

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
