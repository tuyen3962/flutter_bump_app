import 'package:flutter/material.dart';

extension TextEditingControllerExt on TextEditingController {
  int get startWordIndex {
    String text = this.text;
    TextSelection selection = this.selection;

    // If no selection or cursor is not set, return empty
    if (selection.start < 0 || text.isEmpty) {
      return selection.start;
    }

    // Use the cursor position (or start of selection)
    int cursorPos = selection.start;

    var totalStep = 0;
    // Find the start of the word
    int start = cursorPos;
    while ((start > 0 &&
            start - 1 >= 0 &&
            !text[start - 1].contains(RegExp(r'\s'))) ||
        (totalStep == 0 &&
            start - 1 >= 0 &&
            text[start - 1] == " " &&
            start > 0)) {
      start--;
      totalStep++;
    }

    return start;
  }
}
