import 'package:dartx/dartx.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_bump_app/utils/util.dart';

import '../../main.dart';

extension StringNulDateTimeExt on String? {
  DateTime? get tryParseMillisecond {
    if ((this ?? '').isNotEmpty) {
      return DateTime.fromMillisecondsSinceEpoch(this!.toInt()).toLocal();
    }
    return null;
  }

  String get fromNowTime {
    final dateTime = (this ?? '').convertDateTime;
    if (dateTime == null) return '';
    final duration = DateTime.now().difference(dateTime);
    if (duration.inDays >= 3) {
      return dateTime.ddMMyy;
    }
    return Jiffy.parseFromDateTime(dateTime).fromNow();
  }
}

extension StringDateTimeExt on String {
  DateTime toDateTime() {
    return DateTime.parse(this);
  }

  String toLocal() {
    final DateTime dateTime = DateTime.parse(this).toLocal();
    return dateTime.toIso8601String();
  }

  DateTime get toLocalDT {
    if (isEmpty) return DateTime.now();
    final time = int.tryParse(this);
    if (time != null) {
      return DateTime.fromMillisecondsSinceEpoch(time).toLocal();
    }
    return DateTime.parse(this).toLocal();
  }

  DateTime? get convertDateTime {
    return DateTime.tryParse(this)?.toLocal();
  }

  String get HH_mm {
    final DateTime dateTime = DateTime.parse(this).toLocal();
    return DateFormat('HH:mm').format(dateTime);
  }

  String get dd_MM_yyy {
    final DateTime dateTime = DateTime.parse(this).toLocal();
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  String get ddMMyy {
    final DateTime dateTime = DateTime.parse(this).toLocal();
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  String get ddMMyyTime {
    final DateTime dateTime = DateTime.parse(this).toLocal();
    return DateFormat('dd/MM/yyyy, HH:mm').format(dateTime);
  }

  String get EEEE_dd_MM_yyyy {
    final DateTime dateTime = DateTime.parse(this).toLocal();
    return DateFormat('EEEE, dd/MM/yyyy',
            navigatorKey.currentContext!.locale.languageCode)
        .format(dateTime);
  }

  String get eeee_mmmm_d {
    final DateTime dateTime = DateTime.parse(this).toLocal();
    return DateFormat(
            'EEEE, MMMM d', navigatorKey.currentContext!.locale.languageCode)
        .format(dateTime);
  }

  String get age {
    final today = DateTime.now();
    final date = toLocalDT;
    final diff = today.year - date.year;
    return diff.toString();
  }
}

extension DateTimeExt2 on DateTime {
  String get weekDayLocale {
    switch (weekday) {
      case 1:
        return 'mon'.tr();
      case 2:
        return 'tue'.tr();
      case 3:
        return 'wed'.tr();
      case 4:
        return 'thur'.tr();
      case 5:
        return 'fri'.tr();
      case 6:
        return 'sat'.tr();
      case 7:
        return 'sun'.tr();
      default:
        return '';
    }
  }

  String get dayFormat => Utils.getTimeString(day);

  String get messageDate {
    if (isToday) {
      return 'Today $HH_mm';
    } else {
      return DateFormat("MMMM, dd yyyy HH:mm",
              navigatorKey.currentContext!.locale.languageCode)
          .format(this);
    }
  }

  String get monthLocale {
    switch (month) {
      case 1:
        return 'jan'.tr();
      case 2:
        return 'feb'.tr();
      case 3:
        return 'mar'.tr();
      case 4:
        return 'Apr'.tr();
      case 5:
        return 'may'.tr();
      case 6:
        return 'jun'.tr();
      case 7:
        return 'jul'.tr();
      case 8:
        return 'aug'.tr();
      case 9:
        return 'sep'.tr();
      case 10:
        return 'oct'.tr();
      case 11:
        return 'nov'.tr();
      case 12:
        return 'dec'.tr();
      default:
        return '';
    }
  }

  DateTime get startDay {
    return DateTime(year, month, day, 0, 0);
  }

  DateTime get endDay {
    return DateTime(year, month, day, 23, 59);
  }

  String get HH_mm {
    return DateFormat('HH:mm', navigatorKey.currentContext!.locale.languageCode)
        .format(this);
  }

  String get hh_mm {
    var isMorning = true;
    if (hour > 12) {
      isMorning = false;
    }
    return '${DateFormat('hh:mm', navigatorKey.currentContext!.locale.languageCode).format(this)} ${isMorning ? 'AM' : 'PM'}';
  }

  String get dd_MM_yyy {
    return DateFormat(
            'dd-MM-yyyy', navigatorKey.currentContext!.locale.languageCode)
        .format(this);
  }

  String get EE_dd_MM_yyy {
    return DateFormat(
            'EE,MMM dd, yy', navigatorKey.currentContext!.locale.languageCode)
        .format(this);
  }

  String get ddMMyy {
    return DateFormat(
            'dd/MM/yyyy', navigatorKey.currentContext!.locale.languageCode)
        .format(this);
  }

  String get ddMM {
    return DateFormat('dd/MM', navigatorKey.currentContext!.locale.languageCode)
        .format(this);
  }

  String get EEEE_dd_MM_yyyy {
    return DateFormat('EEEE, dd/MM/yyyy',
            navigatorKey.currentContext!.locale.languageCode)
        .format(this);
  }

  String get EEEE_dd_MM_yyy {
    return DateFormat("EEEE , dd-MM-yyyy",
            navigatorKey.currentContext!.locale.languageCode)
        .format(this);
  }

  String get MMM_DD_TIME {
    // final text = DateFormat(
    //         "MMM dd hh:mm", navigatorKey.currentContext!.locale.languageCode)
    //     .format(this);
    final text = DateFormat("dd-MM-yyyy hh:mm",
            navigatorKey.currentContext!.locale.languageCode)
        .format(this);
    if (hour > 12) {
      return '$text PM';
    } else {
      return '$text AM';
    }
  }

  bool get isBeforeNow {
    final now = DateTime.now();
    if (now.year == year) {
      if (now.month == month) {
        return now.day > day;
      } else if (now.month < month) {
        return true;
      } else {
        return false;
      }
    } else if (now.year < year) {
      return true;
    }
    return false;
  }

  bool isNotSameDay(DateTime time) {
    if (time.year == year) {
      if (time.month == month) {
        return time.day != day;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  bool isSame(DateTime time) {
    return year == time.year &&
        month == time.month &&
        day == time.day &&
        hour == time.hour &&
        minute == time.minute;
  }

  DateTime get tomorrow {
    return add(const Duration(days: 1));
  }

  DateTime get startDayOfWeek {
    int currentDayOfWeek = weekday;

    int daysToSubtract = (currentDayOfWeek % 7);

    DateTime startOfWeek = date.subtract(Duration(days: daysToSubtract));

    if (currentDayOfWeek == DateTime.sunday) {
      startOfWeek = date;
    }

    return startOfWeek;
  }

  DateTime get endDayOfWeek {
    int currentDayOfWeek = weekday;

    int daysToAdd = (6 - currentDayOfWeek % 7);

    DateTime endOfWeek = date.add(Duration(days: daysToAdd));

    if (currentDayOfWeek == DateTime.saturday) {
      endOfWeek = date;
    }

    return endOfWeek;
  }

  String get age {
    final today = DateTime.now();
    final diff = today.year - year;
    return diff.toString();
  }
}

extension DurationExt on Duration {
  String format() {
    final minutes = inMinutes.remainder(60);
    return "${inHours < 10 ? "0$inHours" : inHours}:${minutes < 10 ? "0$minutes" : minutes}";
  }
}
