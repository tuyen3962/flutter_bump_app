import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static late final _permissionTitleString = {
    Permission.camera: 'Camera',
    Permission.storage: 'Storage',
    Permission.photos: 'Storage'
  };

  static late final _permissionTypeString = {
    Permission.camera: 'camera',
    Permission.storage: 'gallery',
    Permission.photos: 'gallery',
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
          if (Platform.isIOS) {
            return false;
          } else {
            final result = await permission.request();
            return result == PermissionStatus.granted;
          }

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

  static requestPermission(Permission permission) async {
    // final result = await DialogUtils.showConfirmDialog(
    //     title: 'request_perrmission_title',
    //     content:
    //         'Vui lòng cấp quyền ${_permissionTitleString[permission] ?? ''} để truy cập vào ${_permissionTypeString[permission] ?? ''}');
    // if (result ?? false) {
    //   openAppSettings();
    // }
  }
}
