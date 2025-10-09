import 'package:flutter_bump_app/screen/campaign_details/campaign_details_screen.dart';

extension EnumExt on Enum {
  String get text {
    return name.replaceAll('_', ' ').toLowerCase().capitalize();
  }
}
