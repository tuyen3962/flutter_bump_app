import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/widget/image_asset_custom.dart';
import 'package:flutter_bump_app/widget/textfield/text_field_node.dart';
import 'package:flutter_bump_app/widget/textfield/title_text_field.dart';
import 'package:flutter_bump_app/widget/textfield/widget/obscure_password_icon.dart';

class FormTextFieldCustom extends StatefulWidget {
  const FormTextFieldCustom(
      {super.key,
      required this.formHandler,
      this.separatePadding,
      this.textFieldPadding,
      this.scrollPhysics,
      this.textStyle,
      this.hintStyle,
      this.showLabel = true,
      this.inputBorder,
      this.showRequired = true,
      this.showHint = false,
      this.errorBorder,
      this.passwordIconPadding,
      this.prefixIconColor,
      this.titleStyle});

  final FormTextFieldHandler formHandler;
  final double? separatePadding;
  final EdgeInsets? textFieldPadding;
  final TextStyle? titleStyle;
  final ScrollPhysics? scrollPhysics;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool showLabel;
  final InputBorder? inputBorder;
  final InputBorder? errorBorder;
  final bool showRequired;
  final EdgeInsets? passwordIconPadding;
  final bool showHint;
  final Color? prefixIconColor;

  @override
  State<FormTextFieldCustom> createState() => _FormTextFieldCustomState();
}

class _FormTextFieldCustomState extends State<FormTextFieldCustom> {
  late FormTextFieldHandler formHandler;

  @override
  void initState() {
    super.initState();
    formHandler = widget.formHandler;
    for (final handler in formHandler.handlers) {
      handler.textCtrl.addListener(() {
        if (formHandler.errorFormText.value.isNotEmpty) {
          formHandler.errorForm = '';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: formHandler.errorFormText,
      builder: (context, errorFormText, child) => ValueListenableBuilder(
        valueListenable: formHandler.formValidated,
        builder: (context, formValidated, _) => ValueListenableBuilder(
          valueListenable: formHandler.isFormError,
          builder: (context, isFormError, _) => ListView.separated(
            shrinkWrap: true,
            physics: widget.scrollPhysics,
            padding: padding(),
            itemCount: formHandler.handlers.length,
            separatorBuilder: (context, index) => SizedBox(
                height: formHandler.handlers[index].notShowInForm
                    ? 0
                    : widget.separatePadding ?? 0),
            itemBuilder: (context, index) {
              final handler = formHandler.handlers[index];
              if (handler.notShowInForm) return const SizedBox();
              if (formHandler.passwordFieldNotifier.containsKey(index)) {
                final passwordNotifier =
                    formHandler.passwordFieldNotifier[index];
                return ValueListenableBuilder<bool>(
                  valueListenable: passwordNotifier!,
                  builder: (context, isObscure, _) => TitleTextField(
                    topPadding: 4.h,
                    fieldNode: handler,
                    showLabel: widget.showLabel,
                    useMaterialLabel: widget.showLabel,
                    inputBorder: widget.inputBorder,
                    showRequired: widget.showRequired,
                    errorInputBorder: widget.errorBorder,
                    titleStyle: widget.titleStyle,
                    textStyle: widget.textStyle,
                    hintStyle: widget.hintStyle,
                    isRequired: handler.isRequired,
                    inputFormatters: handler.inputFormatters,
                    includeDenyEmoji: handler.includeDenyEmoji,
                    showHint: widget.showHint,
                    hintText: handler.hintText,
                    title: handler.title,
                    textFieldPadding: widget.textFieldPadding,
                    inputType: handler.inputType,
                    validatedForm: formValidated,
                    obscureText: isObscure,
                    inputAction:
                        handler.nextNode != null ? TextInputAction.next : null,
                    errorFormText: errorFormText,
                    isFormError: isFormError,
                    // paddingTextBottom: 4,
                    prefix: handler.prefixIconPath.isEmpty
                        ? null
                        : Padding(
                            padding: padding(left: 16, right: 12),
                            child: ImageAssetCustom(
                                imagePath: handler.prefixIconPath,
                                width: 24,
                                color: widget.prefixIconColor,
                                height: 24),
                          ),
                    prefixIconConstraints: handler.prefixIconPath.isEmpty
                        ? null
                        : const BoxConstraints(maxHeight: 24, maxWidth: 60),

                    containVietnam: true,
                    maxLine: 1,
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ObscurePasswordIcon(
                            onTap: () => passwordNotifier.value =
                                !passwordNotifier.value,
                            isObscure: isObscure),
                      ],
                    ),
                  ),
                );
              } else {
                return TitleTextField(
                  topPadding: 4.h,
                  fieldNode: handler,
                  inputFormatters: handler.inputFormatters,
                  includeDenyEmoji: handler.includeDenyEmoji,
                  hintText: handler.hintText,
                  isFormError: isFormError,
                  title: handler.title,
                  showLabel: widget.showLabel,
                  useMaterialLabel: widget.showLabel,
                  showHint: widget.showHint,
                  showRequired: widget.showRequired,
                  inputBorder: widget.inputBorder,
                  errorInputBorder: widget.errorBorder,
                  textStyle: widget.textStyle,
                  hintStyle: widget.hintStyle,
                  titleStyle: widget.titleStyle,
                  prefix: handler.prefixIconPath.isEmpty
                      ? null
                      : Padding(
                          padding: padding(left: 16, right: 12),
                          child: ImageAssetCustom(
                              imagePath: handler.prefixIconPath,
                              width: 24,
                              color: widget.prefixIconColor,
                              height: 24),
                        ),
                  prefixIconConstraints: handler.prefixIconPath.isEmpty
                      ? null
                      : const BoxConstraints(maxHeight: 24, maxWidth: 60),
                  inputAction:
                      handler.nextNode != null ? TextInputAction.next : null,
                  textFieldPadding: widget.textFieldPadding,
                  inputType: handler.inputType,
                  validatedForm: formValidated,
                  errorFormText: errorFormText,
                  // paddingTextBottom: 4,
                  isRequired: handler.isRequired,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
