import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/utils/extension/string_ext.dart';
import 'package:flutter_bump_app/utils/formatter/auto_first_text_formatter.dart';

typedef OnFormValid = Future<void> Function(Map<String, dynamic> map);

class TextFieldHandler {
  final textFieldKey = GlobalKey();

  final String? firstText;
  final bool Function(String value)? isFieldValid;
  final String Function(String value)? convertString;
  final textCtrl = TextEditingController();
  final node = FocusNode();
  final List<TextInputFormatter> inputFormatters;
  final String Function(String?)? errorText;
  final String initializeText;
  final bool includeDenyEmoji;
  final bool isPassword;
  final String title;
  final String hintText;
  final TextInputAction textInputAction;
  final TextInputType inputType;
  final String field;
  final bool isRequired;
  final bool notShowInForm;
  late final ValueNotifier<bool> canEditNotifier;
  final int? maxLength;
  FocusNode? nextNode = null;
  final bool showMaxLength;
  final String prefixIconPath;
  final bool autoAddFirstText;

  final isValidNotifier = ValueNotifier(true);
  final emptyError = ValueNotifier(false);
  final _customError = ValueNotifier('');

  ValueNotifier<String> get customErrorNotifier => _customError;
  set customError(String value) {
    _customError.value = value;
  }

  String get customError => _customError.value;

  bool get isValid => isValidNotifier.value;

  bool get isEmptyError => emptyError.value;

  String get text {
    var newText = textCtrl.text;
    if (autoAddFirstText) {
      newText = AutoFirstText.removeFirstText(firstText ?? hintText, newText);
    }
    return newText;
  }

  set isValid(bool value) {
    isValidNotifier.value = value;
  }

  set text(String value) {
    textCtrl.text = value;
  }

  void setWithFirstText(String value) {
    textCtrl.text = AutoFirstText.addFirstText(firstText ?? hintText, value);
  }

  bool get canEdit => canEditNotifier.value;

  set canEdit(bool value) {
    canEditNotifier.value = value;
  }

  TextFieldHandler({
    required this.field,
    this.notShowInForm = false,
    bool? canEdit,
    this.maxLength,
    this.convertString,
    this.isFieldValid,
    VoidCallback? onListenText,
    this.prefixIconPath = '',
    this.isRequired = false,
    this.showMaxLength = true,
    VoidCallback? onUnfocusListener,
    this.errorText,
    this.initializeText = '',
    this.inputFormatters = const [],
    this.includeDenyEmoji = true,
    this.isPassword = false,
    this.title = '',
    this.hintText = '',
    this.textInputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.autoAddFirstText = false,
    this.firstText,
    VoidCallback? onFocusListener,
  }) {
    if (initializeText.clearSpace.isNotEmpty) {
      textCtrl.text = autoAddFirstText
          ? AutoFirstText.addFirstText(firstText ?? hintText, initializeText)
          : initializeText;
    }
    canEditNotifier = ValueNotifier<bool>(canEdit ?? true);
    node.addListener(() {
      if (node.hasFocus) {
        onFocusListener?.call();
      } else {
        if (isFieldValid != null) {
          isValidNotifier.value = isFieldValid?.call(textCtrl.text) ?? true;
        }
        if (onUnfocusListener != null) {
          onUnfocusListener();
        }
        if (isRequired) {
          emptyError.value = textCtrl.text.isEmpty;
        }
        // if (customError.isNotEmpty) {
        //   customError = '';
        // }
      }
    });
    // node.unfocusListener(() {

    // });
    textCtrl.addListener(() {
      if (onListenText != null) {
        onListenText();
      }
      isValidNotifier.value = true;
      customError = '';
    });
  }

  void validateField() {
    customError = '';
    var newText = textCtrl.text;
    newText = newText.replaceAll(spaceRegExp, ' ');
    if (newText.length == 1 && newText == ' ') {
      newText = '';
    }
    textCtrl.text = newText;
    if (isRequired) {
      emptyError.value = textCtrl.text.isEmpty;
      isValidNotifier.value = !emptyError.value;
    }
    if (textCtrl.text.isEmpty && !isRequired) {
      return;
    }
    if (isFieldValid != null) {
      isValidNotifier.value = isFieldValid?.call(textCtrl.text) ?? true;
    }
  }

  void dispose() {
    canEditNotifier.dispose();
    emptyError.dispose();
    textCtrl.dispose();
    node.dispose();
    isValidNotifier.dispose();
  }

  void requestFocus() {
    node.requestFocus();
  }

  void unFocus() {
    node.unfocus();
  }
}

class FormTextFieldHandler {
  final List<TextFieldHandler> handlers;
  final OnFormValid validateForm;
  late Map<int, ValueNotifier<bool>> passwordFieldNotifier;
  final formValidated = ValueNotifier(false);
  final isFormError = ValueNotifier(false);
  final errorFormText = ValueNotifier('');

  set errorForm(String val) {
    errorFormText.value = val;
    isFormError.value = val.isNotEmpty;
  }

  FormTextFieldHandler({required this.handlers, required this.validateForm}) {
    passwordFieldNotifier = {};
    for (var i = 0; i < handlers.length; i++) {
      if (handlers[i].isPassword) {
        passwordFieldNotifier.putIfAbsent(i, () => ValueNotifier(true));
      }
      if (i + 1 < handlers.length) {
        handlers[i].nextNode = handlers[i + 1].node;
      }
    }
  }

  void onSubmit() async {
    formValidated.value = true;
    onSetFormEditable(false);
    final map = <String, String>{};

    var isValid = true;
    for (final handler in handlers) {
      handler.validateField();
      if (handler.emptyError.value || !handler.isValidNotifier.value) {
        isValid = false;
      }
      map.putIfAbsent(
          handler.field,
          () =>
              handler.convertString?.call(handler.textCtrl.text) ??
              handler.textCtrl.text);
    }
    if (!isValid) {
      onSetFormEditable(true);
      return;
    }

    try {
      await validateForm(map);
    } catch (e) {
      print(e);
    }
    onSetFormEditable(true);
  }

  void onSetFormEditable(bool canEdit) {
    if (handlers.isEmpty) return;
    for (final field in handlers) {
      if (field.canEdit != canEdit) {
        field.canEdit = canEdit;
      }
    }
  }

  void dispose() {
    if (passwordFieldNotifier.isNotEmpty) {
      for (final val in passwordFieldNotifier.values) {
        val.dispose();
      }
    }
    for (final field in handlers) {
      field.dispose();
    }
  }
}
