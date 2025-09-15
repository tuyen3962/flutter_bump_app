import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bump_app/config/constant/emoji_unicode.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/widget/textfield/text_field_node.dart';

class TextAreaField extends StatelessWidget {
  const TextAreaField(
      {Key? key,
      required this.fieldNode,
      this.title,
      this.textFieldPadding,
      this.isRequired = false,
      this.hintText = '',
      this.titleStyle,
      this.inputType = TextInputType.multiline,
      this.content = '',
      this.includeDenyEmoji = true,
      this.onEditingComplete,
      this.validatedForm = false,
      this.isFormError = false,
      this.errorFormText = '',
      this.minLine,
      this.maxLine,
      this.inputFormatters = const [],
      this.containVietnam = false,
      this.onTap,
      this.inputAction,
      this.showLabel = true,
      this.showRequired = true,
      this.hintStyle,
      this.canEdit = true,
      this.labelStyle,
      this.topPadding = 0,
      this.suffix,
      this.backgroundColor,
      this.emptyText,
      this.inputBorder,
      this.suffixIcon,
      this.textStyle})
      : super(key: key);

  final String? title;
  final TextFieldHandler fieldNode;
  final EdgeInsets? textFieldPadding;
  final bool isRequired;
  final TextInputType inputType;
  final String hintText;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool validatedForm;
  final String errorFormText;
  final bool isFormError;
  final String content;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter> inputFormatters;
  final bool includeDenyEmoji;
  final int? maxLine;
  final int? minLine;
  final bool containVietnam;
  final VoidCallback? onTap;
  final TextInputAction? inputAction;
  final bool showRequired;
  final bool showLabel;
  final TextStyle? labelStyle;
  final double topPadding;
  final Widget? suffix;
  final Color? backgroundColor;
  final bool canEdit;
  final String? emptyText;
  final InputBorder? inputBorder;
  final Widget? suffixIcon;

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
                    ? emptyText ?? "empty_error".tr(args: [fieldNode.title])
                    : fieldNode.errorText?.call(fieldNode.textCtrl.text);
        return Padding(
          padding: padding(top: topPadding),
          child: GestureDetector(
              onTap: onTap,
              child: ValueListenableBuilder(
                valueListenable: fieldNode.canEditNotifier,
                builder: (context, editable, child) => _buildTextField(editable,
                    hasError: hasError, errorText: errorText),
              )),
        );
      },
    );
  }

  InputBorder get border =>
      inputBorder ??
      OutlineInputBorder(
          borderSide: BorderSide(color: appTheme.background),
          borderRadius: BorderRadius.circular(16));

  Widget _buildTextField(bool canEdit,
      {bool hasError = false, String? errorText}) {
    final hint = fieldNode.hintText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fieldNode.title.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(fieldNode.title, style: labelStyle ?? AppStyle.regular14()),
              SizedBox(width: 4.w),
              if (showRequired && (fieldNode.isRequired))
                Text(
                  "*",
                  style: labelStyle?.copyWith(color: appTheme.errorColor) ??
                      AppStyle.regular14(color: appTheme.errorColor),
                  textAlign: TextAlign.end,
                )
            ],
          ),
        SizedBox(height: 4.h),
        Stack(
          children: [
            TextField(
              key: fieldNode.textFieldKey,
              controller: fieldNode.textCtrl,
              keyboardType: inputType,
              onEditingComplete: onEditingComplete,
              // textInputAction: inputAction ?? TextInputAction.,
              inputFormatters: [
                ...inputFormatters,
                // if (fieldNode.maxLength != null) ...[
                LengthLimitingTextInputFormatter(fieldNode.maxLength ?? 1000),
                // ],
                // if (!containVietnam) ...[
                //   FilteringTextInputFormatter.deny(vietnamesePattern),
                // ],
                if (includeDenyEmoji) ...formatterEmojiDeny,
              ],
              focusNode: fieldNode.node,
              style: textStyle ?? AppStyle.regular16(),
              maxLines: maxLine,
              autofocus: false,
              minLines: minLine,
              enabled: canEdit,
              // cursorColor: appTheme,
              cursorWidth: 1.5,
              decoration: InputDecoration(
                // isDense: false,
                filled: true,
                fillColor: backgroundColor ?? appTheme.background,
                errorText: hasError ? errorText : null,
                errorStyle: AppStyle.regular12(color: appTheme.errorColor),
                contentPadding:
                    textFieldPadding ?? padding(vertical: 8, horizontal: 12),
                hintText: hint,
                hintStyle: hintStyle ??
                    AppStyle.regular16(color: appTheme.backgroundTextField)
                        .copyWith(color: appTheme.hintColor),
                errorMaxLines: 3,
                errorBorder: border.copyWith(
                    borderSide: BorderSide(color: appTheme.errorColor)),
                border: border,
                focusedBorder: border,
                enabledBorder: border,
                focusedErrorBorder: border,
                suffix: suffixIcon,
                enabled: canEdit,
              ),
            ),
            Positioned(
                right: textFieldPadding?.right ?? 12,
                top: textFieldPadding?.top ?? 8,
                child: suffix ?? const SizedBox())
          ],
        ),
        if ((fieldNode.showMaxLength) && fieldNode.maxLength != null)
          ValueListenableBuilder(
              valueListenable: fieldNode.textCtrl,
              builder: (context, value, child) => Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: padding(vertical: 4),
                    child: Text(
                      "${value.text.length}/${fieldNode.maxLength}",
                      style: AppStyle.regular12(
                          color: appTheme.backgroundContainer),
                    ),
                  )))
      ],
    );
  }

  Widget _buildValueListenerView(
      Widget Function(bool isEmpty, bool isValid, String customError)
          viewBuilder) {
    return ValueListenableBuilder<bool>(
      valueListenable: fieldNode.emptyError,
      builder: (context, isEmpty, child) => ValueListenableBuilder<bool>(
        valueListenable: fieldNode.isValidNotifier,
        builder: (context, value, child) => ValueListenableBuilder(
            valueListenable: fieldNode.customErrorNotifier,
            builder: (context, error, child) =>
                viewBuilder(isEmpty, value, error)),
      ),
    );
  }
}
