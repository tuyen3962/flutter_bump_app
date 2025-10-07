import 'package:flutter_config/flutter_config.dart';

class AppConfig {
  static String API_URL = FlutterConfig.get('API_URL');
  static String clientId = FlutterConfig.get('CLIENT_ID');
  static String privyAppId = FlutterConfig.get('PRIVY_APP_ID');
  static String privyAppClientId = FlutterConfig.get('PRIVY_APP_CLIENT_ID');
  static String privyAppUrlScheme = FlutterConfig.get('APP_URL_SCHEME');
}
