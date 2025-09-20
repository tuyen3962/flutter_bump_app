import 'package:dartx/dartx.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/config/constant/emoji_unicode.dart';
import 'package:flutter_bump_app/utils/extension/int_ext.dart';

RegExp vietnamesePattern =
    RegExp(r'[áàảãạăắằẳẵặâấầẩẫậđéèẻẽẹêếềểễệóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựịỉíĩì]');
RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?”]).{8,}$');
RegExp specialCharacter = RegExp(r'[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?”’]');

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
    final newText = trim()
        .replaceAll(spaceRegExp, ' ')
        .replaceAll('。', '')
        .replaceAll('，', ',')
        .replaceAll("”", '"')
        .replaceAll('“', '"');
    if (newText.length == 1 && newText == ' ') {
      return '';
    }
    return newText;
  }

  String get clearEmojiAndVietnamese {
    return replaceAll(vietnamesePattern, '')
        .replaceAll(specialCharacter, '')
        .replaceAll(emojiRegExp, '')
        .replaceAll('ʀ', 'R');
  }

  String get clearEmoji {
    return replaceAll(emojiRegExp, '');
  }

  // String get replaceVietnamese {
  //   return replaceAllMapped(vietnamesePattern, (match) {
  //     return vietnameseMap[match.group(0)] ?? '';
  //   });
  // }

  String get formatTranslateText {
    var text = this.toLowerCase().trim();
    text = '${text[0].toUpperCase()}${text.substring(1)}';
    // final matches = text.allMatches('.');
    // for (final match in matches) {
    //   print(text[match.start]);
    //   print(match.start);
    // }
    var index = 0;

    while (index < text.length) {
      final dotIndex = text.indexOf('.', index);
      index = dotIndex + 1;
      if (dotIndex == -1) {
        break;
      }
      text =
          '${text.substring(0, dotIndex)}${text.substring(dotIndex, dotIndex + 3).toUpperCase()}${text.substring(dotIndex + 3)}';
    }
    return text;
  }

  String get nameOfUrl {
    var name = split('/').last;
    final dotIndex = name.lastIndexOf('.');
    name = name.substring(0, dotIndex);
    return name;
  }

  String get routeName {
    if (isEmpty) return '';

    // Remove 'Route' suffix if present
    var name = endsWith('Route') ? substring(0, length - 5) : this;

    // Split by uppercase letters and join with spaces
    final parts = name.split(RegExp(r'(?=[A-Z])'));

    // Capitalize first letter of each part and join
    return parts
        .map((part) => part.isNotEmpty
            ? '${part[0].toLowerCase()}${part.substring(1)}'
            : '')
        .join('-');
  }

  String get wordAtSelection {
    return split(' ').first;
  }

  bool get isEnglishCharacter {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }
}
