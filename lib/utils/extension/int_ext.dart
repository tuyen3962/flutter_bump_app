import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';

extension IntExtension on int? {
  String get currency {
    if (this == null) {
      return '0';
    }
    return NumberFormat('#,###').format(this);
  }

  String get distanceFilter {
    if (this == null) {
      // return LocaleKeys.choose_distance.tr();
    }
    if (this == 20) {
      return 'under_distance_default'.tr(args: [' $this']);
    }
    if (this == -1) {
      return 'no_limit'.tr();
    }
    return 'under_distance'.tr(args: [' $this']);
  }
}

extension DoubleExtension on double? {
  String get currency {
    if (this == null) {
      return '0';
    }
    return NumberFormat('#,###').format((this ?? 0).toInt());
  }

  String get routeDistance {
    final km = this?.toInt() ?? 0;
    if (km > 0) {
      return '${km}km';
    } else {
      final m = ((this ?? 0) - km).toStringAsFixed(2).replaceFirst('0.', '');
      return '${m}m';
    }
  }
}
