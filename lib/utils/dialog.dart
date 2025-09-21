import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:permission_handler/permission_handler.dart';

class DialogUtils {
  static showPermissionRequest({
    required String title,
    String content = '',
    VoidCallback? goToSetting,
  }) {
    return showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title, style: AppStyle.medium17()),
              content: Text(content, style: AppStyle.regular13()),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                  child: Text('Cancel',
                      style: AppStyle.regular17(color: appTheme.blue50)),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).maybePop();

                    if (goToSetting != null) {
                      goToSetting();
                    } else {
                      openAppSettings();
                    }
                  },
                  child: Text('Setting',
                      style: AppStyle.regular17(color: appTheme.blue50)),
                )
              ],
            ));
  }

  static Future showCupertinoModal(
      BuildContext context, List<CupertinoAction> actions) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: actions
              .map(
                (action) => CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).maybePop();

                    Future.delayed(const Duration(milliseconds: 50))
                        .then((_) => action.onTap?.call());
                  },
                  child: Text(
                    action.title,
                    style: AppStyle.regular18(
                      color: action.isDangerous
                          ? appTheme.red500
                          : appTheme.blue50,
                    ),
                  ),
                ),
              )
              .toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: Navigator.of(context).maybePop,
            child: Text('Cancel',
                style: AppStyle.regular16(color: appTheme.red500)),
          ),
        );
      },
    );
  }
}

class CupertinoAction {
  final String title;
  final bool isDangerous;
  final VoidCallback? onTap;
  CupertinoAction({
    this.title = '',
    this.isDangerous = false,
    this.onTap,
  });
}
