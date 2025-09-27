import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';

class EnterNameHighlightDialog extends StatefulWidget {
  const EnterNameHighlightDialog(
      {super.key, required this.onHighlightNameChanged});

  final Function(String) onHighlightNameChanged;

  static Future<void> show(BuildContext context,
      {required Function(String) onHighlightNameChanged}) async {
    await showDialog(
        context: context,
        builder: (context) => EnterNameHighlightDialog(
            onHighlightNameChanged: onHighlightNameChanged));
  }

  @override
  State<EnterNameHighlightDialog> createState() =>
      _EnterNameHighlightDialogState();
}

class _EnterNameHighlightDialogState extends State<EnterNameHighlightDialog> {
  final TextEditingController _highlightNameController =
      TextEditingController();

  @override
  void dispose() {
    _highlightNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: padding(all: 16),
        padding: padding(all: 24),
        decoration: BoxDecoration(
            color: appTheme.alpha, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name Your Highlight',
                  style: AppStyle.bold18(),
                ),
                GestureDetector(
                  onTap: context.maybePop,
                  child: Container(
                    padding: padding(all: 4),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: appTheme.gray400,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Input field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Highlight Name',
                  style: AppStyle.medium14(color: appTheme.gray700),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _highlightNameController,
                  autofocus: true,
                  style: AppStyle.regular16(),
                  decoration: InputDecoration(
                    hintText: 'Enter highlight name...',
                    hintStyle: AppStyle.regular16(color: appTheme.gray400),
                    filled: true,
                    fillColor: appTheme.alpha,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: appTheme.gray300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: appTheme.gray300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: appTheme.blue500, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: context.maybePop,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: appTheme.gray700,
                        side: BorderSide(color: appTheme.gray300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppStyle.medium16(color: appTheme.gray700),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _highlightNameController,
                    builder: (context, value, child) => SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: value.text.trim().isNotEmpty
                            ? () {
                                widget.onHighlightNameChanged(value.text);
                                context.maybePop();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appTheme.blue500,
                          foregroundColor: appTheme.alpha,
                          disabledBackgroundColor: appTheme.gray300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Create',
                          style: AppStyle.medium16(color: appTheme.alpha),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
