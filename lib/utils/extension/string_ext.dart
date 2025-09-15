import 'package:dartx/dartx.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/utils/extension/int_ext.dart';

extension StringExt on String {
  String toPhoneNumber({String? prefix}) {
    if (startsWith("0")) {
      return (prefix ?? "+84") + substring(1);
    }
    return "${prefix ?? "+84"}$this";
  }

  int get parseInt {
    return toIntOrNull() ?? 0;
  }

  String get currency {
    final value = parseInt;
    return value.currency;
  }

  int get revertNumberFromCurrency {
    return replaceAll(',', '').toInt();
  }

  int get tryRevertNumberFromCurrency {
    return int.tryParse(replaceAll(',', '')) ?? 0;
  }

  String get clearSpace {
    final newText = trim().replaceAll(spaceRegExp, ' ');
    if (newText.length == 1 && newText == ' ') {
      return '';
    }

    return newText;
  }
}
