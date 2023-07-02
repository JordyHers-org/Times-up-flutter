#!/usr/bin/env sh

case $FLAVOR in
  development)
      flutterfire configure --project=times-up-flutter-dev \
        --android-package-name=com.jordyhers.times_up_flutter \
        --out=lib/firebase_options_dev.dart \
        --platforms=android \
        -y
      ;;
  *)
    ;;
esac


dart format --fix lib/firebase_options_dev.dart
