import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/utils/dialog.dart';
import 'package:permission_handler/permission_handler.dart' hide ServiceStatus;

class MyPermissionHandler {
  static final _permissionTitleString = {
    Permission.camera: 'Camera',
    Permission.storage: 'Storage',
    Permission.photos: 'Storage',
    Permission.microphone: 'Microphone',
    // Permission.location: LocaleKeys.permission_location_title.tr(),
    // Permission.locationAlways: LocaleKeys.permission_location_always_title.tr(),
  };

  static final _permissionTypeString = {
    // Permission.camera: LocaleKeys.camera_content.tr(),
    // Permission.storage: LocaleKeys.photo_content.tr(),
    // Permission.photos: LocaleKeys.photo_content.tr(),
    // Permission.location: LocaleKeys.permission_location_content
    //     .tr(args: [LocaleKeys.event.tr()]),
    // Permission.locationAlways:
    //     LocaleKeys.permission_location_always_content.tr(),
    // Permission.microphone:
    //     'Allow UniVini to access your microphone to record audio messages',
  };

  static Future<bool> systemRequestPermission(Permission permission) async {
    try {
      final status = await permission.request();
      switch (status) {
        case PermissionStatus.granted:
          return true;
        case PermissionStatus.denied:
          if (Platform.isIOS) {
            return false;
          } else {
            final result = await permission.request();
            return result == PermissionStatus.granted;
          }

        case PermissionStatus.restricted:
        case PermissionStatus.limited:
        case PermissionStatus.permanentlyDenied:
          if (Platform.isIOS) {
            final result = await permission.request();
            return result.isGranted;
          }
          return false;
        case PermissionStatus.provisional:
          print('PermissionStatus.provisional');
          return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> onCheckPermission(Permission permission) async {
    try {
      if (Platform.isAndroid) {
        final result = await permission.status;
        if (result == PermissionStatus.permanentlyDenied) {
          return false;
        }
      }
      final status = await permission.request();
      switch (status) {
        case PermissionStatus.granted:
          return true;
        case PermissionStatus.denied:
        // if (Platform.isIOS) {
        // return false;
        // }
        // else {
        //   final result = await permission.request();
        //   return result == PermissionStatus.granted;
        // }

        case PermissionStatus.restricted:
        case PermissionStatus.limited:
        case PermissionStatus.permanentlyDenied:
          return false;
        case PermissionStatus.provisional:
          print('PermissionStatus.provisional');
          return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future requestPermission(Permission permission,
      {VoidCallback? goToSetting,
      bool isGuider = false,
      String? content}) async {
    return DialogUtils.showPermissionRequest(
        title: _permissionTitleString[permission] ?? '',
        content: content ??
            (isGuider && permission == Permission.location && Platform.isIOS
                ? 'LocaleKeys.permission_ios_location_content.tr()'
                : _permissionTypeString[permission] ?? ''),
        goToSetting: goToSetting);
  }
}
