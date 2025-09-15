import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bump_app/config/constant/emoji_unicode.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/utils/formatter/auto_first_text_formatter.dart';
import 'package:flutter_bump_app/widget/textfield/text_field_node.dart';
import 'package:flutter_bump_app/widget/textfield/widget/clear_icon_text.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField(
      {Key? key,
      this.fieldNode,
      this.title,
      this.controller,
      this.obscureText = false,
      this.suffixIcon,
      this.textFieldPadding,
      this.topPadding,
      this.isRequired = false,
      this.hintText = '',
      this.titleStyle,
      this.inputType = TextInputType.text,
      this.canEdit = true,
      this.content = '',
      this.includeDenyEmoji = true,
      this.onEditingComplete,
      this.validatedForm = false,
      this.isFormError = false,
      this.errorFormText = '',
      this.minLine,
      this.maxLine,
      this.prefix,
      this.inputFormatters = const [],
      this.containVietnam = false,
      this.onTap,
      this.filledColor,
      this.prefixIconConstraints,
      this.node,
      this.inputAction,
      this.radius,
      this.textFieldConstraints,
      this.showLabel = true,
      this.showRequired = true,
      this.hintStyle,
      this.otherViewInField,
      this.errorInputBorder,
      this.inputBorder,
      this.useMaterialLabel = true,
      this.showHint = false,
      this.labelStyle,
      this.emptyText,
      this.maxLength,
      this.textStyle})
      : super(key: key);

  final String? title;
  final TextEditingController? controller;
  final TextFieldHandler? fieldNode;
  final bool obscureText;
  final Widget? suffixIcon;
  final EdgeInsets? textFieldPadding;
  final double? topPadding;
  final bool isRequired;
  final TextInputType inputType;
  final String hintText;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool canEdit;
  final bool validatedForm;
  final String errorFormText;
  final bool isFormError;
  final String content;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter> inputFormatters;
  final bool includeDenyEmoji;
  final FocusNode? node;
  final Widget? prefix;
  final int? maxLine;
  final int? minLine;
  final bool containVietnam;
  final VoidCallback? onTap;
  final double? radius;
  final BoxConstraints? prefixIconConstraints;
  final TextInputAction? inputAction;
  final BoxConstraints? textFieldConstraints;
  final bool showRequired;
  final Widget? otherViewInField;
  final bool showLabel;
  final InputBorder? inputBorder;
  final InputBorder? errorInputBorder;
  final bool useMaterialLabel;
  final TextStyle? labelStyle;
  final Color? filledColor;
  final bool showHint;
  final String? emptyText;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return _buildValueListenerView(
      (isEmpty, isValid, customError) {
        final hasError = isFormError ||
            ((!isValid || isEmpty) && validatedForm) ||
            customError.isNotEmpty;
        final errorText = customError.isNotEmpty
            ? customError
            : isFormError
                ? errorFormText
                : isEmpty
                    ? emptyText ??
                        "empty_error"
                            .tr(args: [fieldNode?.title ?? title ?? ''])
                    : fieldNode?.errorText
                        ?.call(fieldNode?.textCtrl.text ?? controller?.text);
        return Padding(
          padding: padding(top: topPadding),
          child: GestureDetector(
              onTap: onTap,
              child: Stack(
                children: [
                  fieldNode != null
                      ? ValueListenableBuilder(
                          valueListenable: fieldNode!.canEditNotifier,
                          builder: (context, editable, child) =>
                              _buildTextField(editable,
                                  hasError: hasError, errorText: errorText),
                        )
                      : _buildTextField(
                          fieldNode?.canEditNotifier.value ?? canEdit,
                          hasError: hasError,
                          errorText: errorText),
                  Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: otherViewInField ?? const SizedBox()),
                ],
              )),
        );
      },
    );
  }

  Widget _buildTextField(bool canEdit,
      {bool hasError = false, String? errorText}) {
    final hint = fieldNode?.hintText ?? hintText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!useMaterialLabel) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(fieldNode?.title ?? title ?? '',
                  style: labelStyle ?? AppStyle.normal14()),
              SizedBox(width: 4.w),
              if (showRequired && (fieldNode?.isRequired ?? isRequired))
                Text(
                  "*",
                  style: labelStyle?.copyWith(color: appTheme.errorColor) ??
                      AppStyle.regular14(color: appTheme.errorColor),
                  textAlign: TextAlign.end,
                )
            ],
          ),
          SizedBox(height: 4.h)
        ],
        TextField(
          key: fieldNode?.textFieldKey,
          obscureText: obscureText,
          controller: fieldNode?.textCtrl ?? controller,
          keyboardType: inputType,
          onEditingComplete: onEditingComplete,
          textInputAction: inputAction,
          onTap: onTap,
          autofocus: false,
          // enableSuggestions: false,
          autocorrect: false,
          inputFormatters: [
            ...inputFormatters,
            if (fieldNode?.maxLength != null || maxLength != null) ...[
              LengthLimitingTextInputFormatter(
                  fieldNode?.maxLength ?? maxLength),
            ],
            if (inputType == TextInputType.phone ||
                inputType == TextInputType.number) ...[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            if ((fieldNode?.autoAddFirstText ?? false) &&
                (fieldNode?.firstText ?? fieldNode?.hintText ?? '')
                    .isNotEmpty) ...[
              AutoFirstTextFormatter(
                  firstText: fieldNode?.firstText ?? fieldNode?.hintText ?? '')
            ],
            // if (!containVietnam) ...[
            // FilteringTextInputFormatter.deny(vietnamesePattern),
            // ],
            if (includeDenyEmoji) ...formatterEmojiDeny,
          ],
          focusNode: fieldNode?.node ?? node,
          style: textStyle ?? AppStyle.regular16(),
          maxLines: maxLine,
          minLines: minLine,
          readOnly: !canEdit,
          // cursorColor: appTheme.stateInfoB200,
          cursorWidth: 1.5,
          decoration: InputDecoration(
            // label: !showLabel
            //     ? null
            //     : (fieldNode?.title ?? title) != null
            //         ? Row(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               Text(fieldNode?.title ?? title ?? '',
            //                   style: labelStyle ?? AppStyle.regular14()),
            //               SizedBox(width: 4.w),
            //               if (showRequired &&
            //                   (fieldNode?.isRequired ?? isRequired))
            //                 Text(
            //                   "*",
            //                   style: labelStyle ??
            //                       AppStyle.regular14(
            //                           color: appTheme.errorColor),
            //                   textAlign: TextAlign.end,
            //                 )
            //             ],
            //           )
            //         : null,
            isDense: false,
            errorText: hasError ? errorText : null,
            errorStyle: AppStyle.regular12(color: appTheme.errorColor),
            contentPadding: textFieldPadding ?? padding(all: 12),
            floatingLabelStyle: AppStyle.regular12(),
            prefixIcon: prefix,
            prefixIconConstraints: prefixIconConstraints,
            hintText: showHint
                ? hint
                : showLabel
                    ? fieldNode?.title ?? title ?? hint
                    : null,
            labelStyle: hintStyle ??
                // titleStyle ??
                AppStyle.normal14(color: appTheme.primaryColor),
            hintStyle: hintStyle ??
                AppStyle.regular16(color: appTheme.background)
                    .copyWith(color: appTheme.hintColor),
            suffixIcon: suffixIcon ??
                ClearIconText(controller: fieldNode?.textCtrl ?? controller),
            errorMaxLines: 3,
            fillColor: filledColor ?? appTheme.backgroundTextField,
            filled: true,
            constraints: textFieldConstraints,
            errorBorder: errorInputBorder ??
                border.copyWith(
                    borderSide: BorderSide(color: appTheme.errorColor)),
            border: inputBorder ?? border,
            focusedBorder:
                inputBorder ?? border.copyWith(borderSide: BorderSide()),
            enabledBorder: inputBorder ?? border,
            focusedErrorBorder: errorInputBorder ?? border,
          ),
        ),
        if (((fieldNode?.textCtrl ?? controller) != null) &&
                (fieldNode?.showMaxLength ?? true) &&
                fieldNode?.maxLength != null ||
            maxLength != null)
          ValueListenableBuilder(
              valueListenable: (fieldNode?.textCtrl ?? controller)!,
              builder: (context, value, child) => Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: padding(vertical: 4),
                    child: Text(
                      "${value.text.length}/${fieldNode?.maxLength ?? maxLength ?? 0}",
                      style: AppStyle.regular12(),
                    ),
                  )))
      ],
    );
  }

  Widget _buildValueListenerView(
      Widget Function(bool isEmpty, bool isValid, String customError)
          viewBuilder) {
    if (fieldNode != null) {
      return ValueListenableBuilder<bool>(
        valueListenable: fieldNode!.emptyError,
        builder: (context, isEmpty, child) => ValueListenableBuilder<bool>(
          valueListenable: fieldNode!.isValidNotifier,
          builder: (context, value, child) => ValueListenableBuilder(
              valueListenable: fieldNode!.customErrorNotifier,
              builder: (context, error, child) =>
                  viewBuilder(isEmpty, value, error)),
        ),
      );
    }

    return viewBuilder(false, false, '');
  }

  OutlineInputBorder get border => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), borderSide: BorderSide());
}
