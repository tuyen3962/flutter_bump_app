import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bump_app/data/model/device_model.dart';
import 'package:flutter_bump_app/utils/extension/string_ext.dart';

class DeviceInfoUtil {
  static Future<DeviceModel> getDeviceInfo() async {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      return DeviceModel(
        deviceId: deviceInfo.id,
        platform: 'android',
        version: deviceInfo.model.clearEmojiAndVietnamese,
        // deviceName: deviceInfo.product.clearEmojiAndVietnamese,
        // systemName: ''
        // systemName:
        //     '${deviceInfo.board.clearEmojiAndVietnamese} ${deviceInfo.device.clearEmojiAndVietnamese} ${deviceInfo.manufacturer.clearEmojiAndVietnamese}'
      );
    } else {
      final deviceInfo = await DeviceInfoPlugin().iosInfo;
      return DeviceModel(
        deviceId: deviceInfo.identifierForVendor ?? '',
        platform: 'ios',
        version: deviceInfo.systemVersion,
        // deviceName: deviceInfo.name.clearEmojiAndVietnamese,
        // systemName: deviceInfo.utsname.sysname.clearEmojiAndVietnamese
      );
    }
  }
}
