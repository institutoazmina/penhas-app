#!/bin/bash

set -e

KEYCHAIN_PATH=$RUNNER_TEMP/app-signing.keychain-db
CERTIFICATE_PATH=$RUNNER_TEMP/build_certificate.p12

base64 -d <<< "$BUILD_CERTIFICATE_B64" > $CERTIFICATE_PATH
base64 -d <<< "$IOS_BUILD_FILES" | tar xzf -
base64 -d <<< "$APPLE_API_KEY_B64" > $WORKING_DIR/app-store-api-key.json

security create-keychain -p '' $KEYCHAIN_PATH
security import $CERTIFICATE_PATH -t agg -k $KEYCHAIN_PATH -P "$PROVISIONING_PASSWORD" -A

security list-keychains -s $KEYCHAIN_PATH
security default-keychain -s $KEYCHAIN_PATH
security unlock-keychain -p '' $KEYCHAIN_PATH
security set-key-partition-list -S apple-tool:,apple: -s -k '' $KEYCHAIN_PATH
