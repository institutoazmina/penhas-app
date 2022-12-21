if [[ ${CONFIGURATION} = "Debug" || ${IS_FIREBASE_DISTRIBUTION} = "true" ]]; then
    /usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName \"PenhaS Dev\"" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
    /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier \"dev.penhas.alphacode.com.br\"" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
fi