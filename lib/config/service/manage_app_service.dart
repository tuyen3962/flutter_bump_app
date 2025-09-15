import 'package:device_apps/device_apps.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';

@injectable
class ManageAppService {
  ManageAppService();

  final _installedApps = BaseStreamController<List<Application>>([]);

  Future<void> getAllInstalledApps() async {
    final apps = await DeviceApps.getInstalledApplications(
        includeSystemApps: true, includeAppIcons: true);
    _installedApps.value = apps;
  }
}
