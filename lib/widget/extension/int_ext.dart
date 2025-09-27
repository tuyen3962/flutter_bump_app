import 'package:easy_localization/easy_localization.dart';

extension IntExtension on int? {
  String get currency {
    if (this == null) {
      return '0';
    }
    return NumberFormat('#,###').format(this);
  }

  String get numberOfLike {
    final count = this ?? 0;
    if (count < 0) {
      return '0';
    }
    if (count < 1000) {
      return '$count';
    } else if (count < 10000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else if (count < 1000000) {
      return '${(count ~/ 1000)}K';
    } else if (count < 1000000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else {
      return '${(count / 1000000000).toStringAsFixed(1)}B';
    }
  }

  String get timer {
    if (this == null) {
      return '00';
    }
    return (this ?? 0).toString().padLeft(2, '0');
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

extension NumExtension on num? {
  String get currency {
    if (this == null) {
      return '0';
    }
    return NumberFormat('#,###').format((this ?? 0).toInt());
  }
}
