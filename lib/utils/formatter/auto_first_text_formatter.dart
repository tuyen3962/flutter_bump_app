import 'package:flutter/services.dart';
import 'package:flutter_bump_app/utils/extension/string_ext.dart';

class AutoFirstText {
  static String addFirstText(String firstText, String text) {
    if (firstText.isEmpty) return text;
    final startText = firstText.replaceAll(' ...', '').clearSpace;
    if (!text.startsWith(startText)) {
      text = '$startText: $text';
    } else if (text.startsWith(startText)) {
      final originalText = text.replaceFirst(startText, '').clearSpace;
      if (originalText.isEmpty) {
        text = '';
      }
    } else if (text.startsWith('$startText: ')) {
      final originalText = text.replaceFirst('$startText: ', '').clearSpace;
      if (originalText.isEmpty) {
        text = '';
      }
    }
    return text;
  }

  static String removeFirstText(String startText, String text) {
    if (startText.isNotEmpty) {
      text = text.clearSpace
          .replaceFirst(startText.replaceAll(' ...', '').clearSpace, '');
    }
    if (text.startsWith(': ')) {
      return text.substring(2);
    }
    return text;
  }
}

class AutoFirstTextFormatter extends TextInputFormatter {
  final String firstText;

  AutoFirstTextFormatter({this.firstText = ''});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = AutoFirstText.addFirstText(firstText, newValue.text);
    // if (!text.startsWith(startText)) {
    //   text = '$startText $text';
    // } else if (text.startsWith(startText)) {
    //   final originalText = text.replaceFirst(startText, '').clearSpace;
    //   if (originalText.isEmpty) {
    //     text = '';
    //   }
    // }
    return TextEditingValue(
        text: text,
        selection:
            TextSelection.fromPosition(TextPosition(offset: text.length)));
  }
}
