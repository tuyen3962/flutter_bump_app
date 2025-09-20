import 'package:flutter/material.dart';
import 'package:flutter_bump_app/data/model/user.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/widget/image/circle_avatar_custom.dart';

class UserCircleAvatar extends StatelessWidget {
  const UserCircleAvatar({this.account, this.size, super.key});

  final User? account;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 24.w,
      height: size ?? 24.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: appTheme.whiteText),
      ),
      child: CircleAvatarCustom(
          imageUrl: account?.avatar ?? '', size: size ?? 24.w),
    );
  }
}
