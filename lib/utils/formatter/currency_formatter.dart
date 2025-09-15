import 'package:flutter/services.dart';
import 'package:flutter_bump_app/utils/extension/int_ext.dart';
import 'package:flutter_bump_app/utils/extension/string_ext.dart';

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    final text = newValue.text.replaceAll(',', '');
    var number = text.parseInt;
    var currencyText = '';
    if (number > 0) {
      if (number >= 1000) {
        number = number ~/ 1000;
      }
      currencyText = '${number.currency},000';
    } else {
      currencyText = '';
    }
    // print(currencyText);
    return TextEditingValue(
        text: currencyText,
        selection: TextSelection.collapsed(
            offset: currencyText.length >= 4 ? currencyText.length - 4 : 0));
  }
}

class NumericFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    final text = newValue.text.replaceAll(',', '');

    return TextEditingValue(text: text.currency);
  }
}
