#!/bin/bash

# New app name
NEW_NAME="Akkha Rik Lipi Sipal"

# Update Android app name
sed -i '' "s/<string name=\"app_name\">.*<\/string>/<string name=\"app_name\">$NEW_NAME<\/string>/g" android/app/src/main/res/values/strings.xml
sed -i '' "s/android:label=\"[^\"]*\"/android:label=\"$NEW_NAME\"/g" android/app/src/main/AndroidManifest.xml

# Update iOS app name
plutil -replace CFBundleDisplayName -string "$NEW_NAME" ios/Runner/Info.plist
plutil -replace CFBundleName -string "$NEW_NAME" ios/Runner/Info.plist

# Optional: update app name in pubspec.yaml
sed -i '' "s/Kid's Play/$NEW_NAME/g" pubspec.yaml

echo "✅ App renamed to '$NEW_NAME' for Android and iOS."

