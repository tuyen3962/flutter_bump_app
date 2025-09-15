# source_base

# Config source
Run the following command in your terminal of this source
flutter pub run easy_localization:generate -O lib/config/lang -f keys -o locale_keys.g.dart --source-dir ./assets/lang
flutter pub run build_runner build
