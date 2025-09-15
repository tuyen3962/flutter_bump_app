import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/utils/reponsive/size_config.dart';
import 'package:flutter_bump_app/utils/util.dart';

extension DateStringExtension on String {
  bool get isTodayDateFormat {
    final splitText = split('/');
    final now = DateTime.now();
    return now.day == int.parse(splitText[0]) &&
        int.parse(splitText[2]) == now.year &&
        now.month == int.parse(splitText[1]);
  }
}

extension DateTimeExtension on DateTime? {
  String? get toHourFormat {
    return this == null
        ? null
        : DateFormat(HOUR_FORMAT).format(this ?? DateTime.now());
  }

  String? get toDayFormat {
    return this == null
        ? null
        : DateFormat(DAY_FORMAT).format(this ?? DateTime.now());
  }

  bool isSameTime(DateTime dateTime) {
    final now = this ?? DateTime.now();
    return now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.hour == dateTime.hour &&
        now.minute == dateTime.minute;
  }

  bool isSameDay(DateTime dateTime) {
    if (this == null) return false;
    return dateTime.day == this!.day &&
        dateTime.month == this!.month &&
        dateTime.year == this!.year;
  }

  bool get isToday {
    if (this == null) return false;
    final now = DateTime.now();
    return now.day == this!.day &&
        now.month == this!.month &&
        now.year == this!.year;
  }

  bool get isBeforeToday {
    if (this == null) return false;
    final now = DateTime.now();
    if (this!.year < now.year) {
      return true;
    } else if (this!.year == now.year) {
      if (this!.month > now.month) {
        return false;
      } else if (this!.month == now.month) {
        return this!.day < now.day;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  bool get isAfterToday {
    if (this == null) return false;
    final now = DateTime.now();
    if (this!.year < now.year) {
      return false;
    } else if (this!.year == now.year) {
      if (this!.month > now.month) {
        return true;
      } else if (this!.month == now.month) {
        return this!.day > now.day;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  Size get screenSize => MediaQuery.of(this).size;
}

extension HomePageExtension on BuildContext {}

extension FocusNodeExtension on FocusNode {
  void unfocusListener(VoidCallback function) {
    addListener(() {
      if (!hasFocus) {
        function();
      }
    });
  }
}

extension Reponsive on num {
  double get w => SizeConfig.instance.getWidth(this) ?? 0;

  double get h => SizeConfig.instance.getHeight(this) ?? 0;

  double get fontSize => SizeConfig.instance.getFontSize(this) ?? 0;
}

EdgeInsets padding({
  double? left,
  double? right,
  double? top,
  double? bottom,
  double? all,
  double? horizontal,
  double? vertical,
}) {
  return SizeConfig.instance.paddingOnly(
        left: all ?? left ?? horizontal,
        right: all ?? right ?? horizontal,
        top: all ?? top ?? vertical,
        bottom: all ?? bottom ?? vertical,
      ) ??
      const EdgeInsets.all(0);
}

const _uuid = Uuid();

String getUuid() {
  return _uuid.v1();
}

MainAppPageState? findRootAncestorState(BuildContext context) {
  return context.findRootAncestorStateOfType<MainAppPageState>();
}

extension DurationExtension on Duration {
  String get timeFormat {
    final minutes = inMinutes;
    final seconds = minutes > 0 ? inSeconds - (minutes * 60) : inSeconds;
    return '${Utils.getTimeString(minutes)}:${Utils.getTimeString(seconds)}';
  }

  String get hourFormat {
    final hours = inHours;
    final minutes = hours > 0 ? inMinutes - (hours * 60) : inMinutes;
    return '$hours giờ ${Utils.getTimeString(minutes)}';
  }

  String get fullTime {
    final hours = inHours;
    final minutes = hours > 0 ? inMinutes - (hours * 60) : inMinutes;
    var seconds = inSeconds;
    // minutes > 0 ? inSeconds - (minutes * 60) : inSeconds
    if (inMinutes > 0) {
      seconds -= inMinutes * 60;
    }
    return '${Utils.getTimeString(hours)}:${Utils.getTimeString(minutes)}:${Utils.getTimeString(seconds)}';
  }

  String get formatHMS {
    final hours = inHours;
    final minutes = hours > 0 ? inMinutes - (hours * 60) : inMinutes;
    var seconds = inSeconds;
    // minutes > 0 ? inSeconds - (minutes * 60) : inSeconds
    if (inMinutes > 0) {
      seconds -= inMinutes * 60;
    }
    if (hours > 0) {
      return '${hours}h${Utils.getTimeString(minutes)}m${Utils.getTimeString(seconds)}';
    } else {
      return '${minutes}m${Utils.getTimeString(seconds)}s';
    }
  }
}
