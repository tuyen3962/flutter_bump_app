import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';

void showLogoutConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: appTheme.alpha,
        child: Container(
          padding: padding(all: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: appTheme.red50,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Icon(
                  Icons.logout,
                  size: 32,
                  color: appTheme.red500,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Log Out',
                style: AppStyle.bold20(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Are you sure you want to log out of your account?',
                style: AppStyle.regular16(color: appTheme.gray600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
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
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appTheme.red500,
                          foregroundColor: appTheme.alpha,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Log Out',
                          style: AppStyle.medium16(color: appTheme.alpha),
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
    },
  );
}
