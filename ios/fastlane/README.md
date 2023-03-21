fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios build

```sh
[bundle exec] fastlane ios build
```

Build release IPA

### ios release_distribute

```sh
[bundle exec] fastlane ios release_distribute
```

Distribute to iOS beta testers in TestFlight

### ios firebase_distribute

```sh
[bundle exec] fastlane ios firebase_distribute
```

Distribute to iOS beta testers in Firebase

### ios verify_app_store_auth

```sh
[bundle exec] fastlane ios verify_app_store_auth
```

Check if json credentials is valid

### ios firebase_id

```sh
[bundle exec] fastlane ios firebase_id
```

Get Firebase project ID from config file

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
