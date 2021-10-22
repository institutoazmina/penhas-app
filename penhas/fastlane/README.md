fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
### pre_build
```
fastlane pre_build
```
Run code generators

----

## Android
### android build
```
fastlane android build
```
Build release APK
### android build_bundle
```
fastlane android build_bundle
```
Build release Bundle
### android distribute_android_beta
```
fastlane android distribute_android_beta
```
Distribute to Android beta testers

----

## iOS
### ios build
```
fastlane ios build
```
Build release IPA
### ios beta
```
fastlane ios beta
```

### ios update_profile
```
fastlane ios update_profile
```

### ios sync_device_info
```
fastlane ios sync_device_info
```

### ios distribute_iOS_beta
```
fastlane ios distribute_iOS_beta
```
Distribute to iOS beta testers

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
