#!/bin/bash

set -e

if [[ "${PRODUCT_BUNDLE_IDENTIFIER}" == dev.* ]]; then
    /usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName \"PenhaS Dev\"" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
fi
