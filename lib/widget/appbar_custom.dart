import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/lang/locale_keys.g.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/gen/assets.gen.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/widget/circle_item.dart';

class AppBarCustom extends StatefulWidget {
  final Function? onBack;
  final String? title;
  final List<Widget>? actions;
  final bool? showBack;
  final bool? centerTitle;
  final double? height;
  final bool? hasDivider;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? backColor;
  final EdgeInsets? padding;
  final bool isBackIcon;
  final Widget? backIcon;
  final Widget? titleView;

  const AppBarCustom({
    Key? key,
    this.onBack,
    this.title,
    this.padding,
    this.actions,
    this.showBack = true,
    this.centerTitle = true,
    this.height,
    this.hasDivider = false,
    this.backgroundColor,
    this.titleStyle,
    this.backColor,
    this.isBackIcon = true,
    this.backIcon,
    this.titleView,
  }) : super(key: key);

  @override
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  back() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else {
      context.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appNameText = Text(LocaleKeys.notification_text.tr(),
        style: AppStyle.medium12(color: appTheme.whiteText.withOpacity(.8)));
    return Container(
      color: widget.backgroundColor,
      width: double.infinity,
      padding: padding(horizontal: 16, vertical: 12),
      child: Stack(alignment: Alignment.centerLeft, children: [
        if (widget.showBack ?? true) ...[
          if (widget.backIcon != null)
            widget.backIcon ?? const SizedBox()
          else if (widget.isBackIcon)
            GestureDetector(
              onTap: back,
              child: Transform.rotate(
                angle: pi,
                child: Assets.icons.arrowRight.svg(
                    width: 32.w,
                    height: 32.w,
                    color: widget.backColor ?? appTheme.background),
              ),
            )
          else
            CircleItem(
                onTap: back,
                padding: padding(all: 6),
                backgroundColor: appTheme.whiteText.withOpacity(.16),
                child: Icon(Icons.close, color: appTheme.whiteText, size: 20)),
        ],
        Padding(
          padding: (widget.showBack ?? true)
              ? widget.padding ?? padding(horizontal: 24)
              : padding(),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: (widget.centerTitle ?? false)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                widget.centerTitle ?? false
                    ? Center(child: appNameText)
                    : appNameText,
                widget.titleView ??
                    Text(
                      widget.title ?? '',
                      style: widget.titleStyle ?? AppStyle.bold18(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: (widget.centerTitle ?? false)
                          ? TextAlign.center
                          : TextAlign.left,
                    ),
              ]),
        ),
        if ((widget.actions ?? []).isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.actions ?? [],
          )
        ]
      ]),
    );
  }
}
