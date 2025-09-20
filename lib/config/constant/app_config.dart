import 'package:flutter_config/flutter_config.dart';

class AppConfig {
  static String API_URL = FlutterConfig.get('API_URL');
  static String clientId = FlutterConfig.get('CLIENT_ID');
}
