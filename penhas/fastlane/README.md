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

### android distribute_android_beta

```sh
[bundle exec] fastlane android distribute_android_beta
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

### ios beta

```sh
[bundle exec] fastlane ios beta
```



### ios update_profile

```sh
[bundle exec] fastlane ios update_profile
```



### ios sync_device_info

```sh
[bundle exec] fastlane ios sync_device_info
```



### ios distribute_iOS_beta

```sh
[bundle exec] fastlane ios distribute_iOS_beta
```

Distribute to iOS beta testers

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
