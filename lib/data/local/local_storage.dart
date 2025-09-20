import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bump_app/config/service/language_service.dart';

const String keyAccessToken = "_accessToken";
const String keyRefreshToken = "_refreshToken";
const String keyUserId = '_userId';
const String keyUserRole = '_userId';
const String keyLanguageCode = '_languageCode';
const String keyPermissions = '_permission';
const String keyFirstUserApp = '_firstUseApp';
const String keyVerificationId = '_verificationId';
const String keyResendToken = '_resendToken';
const String keyUID = '_uid';
const String keyTokenType = '_tokenType';

abstract class LocalStorage {
  Future<void> cacheAccessToken(String token);
  Future<void> cacheRefreshToken(String refreshToken);
  Future<void> cacheUserID(String userId);
  Future<void> cacheUserRole(String userRole);
  Future<void> cacheLanguageCode(String language);
  Future<void> cacheGroupPermission(List<String> permission);
  Future<void> cacheVerificationId(String verificationId);
  Future<void> cacheResendToken(int? resendToken);
  Future<void> cacheUID(String uid);

  Future<String?> accessToken();
  Future<String?> refreshToken();
  Future<String?> userId();

  List<String> get permission;
  String get languageCode;
  String get userRole;
  String get verificationId;
  int? get resendToken;
  String get uid;
  Future<void> clear();

  Future<void> saveValue<T>(T value, String key);
  T getValue<T>(String key, {T? defaultValue});
  int getValueInt(String key, {int? defaultValue});
  String getValueString(String key, {String defaultValue = ''});
  List<String> getValueListString(String key,
      {List<String> defaultValue = const []});
  bool getValueBool(String key, {bool defaultValue = false});
}

@Singleton(as: LocalStorage)
class LocalStorageImpl extends LocalStorage {
  late final FlutterSecureStorage _flutterSecureStorage;
  late final SharedPreferences sharedPreferences;

  LocalStorageImpl();

  @PostConstruct(preResolve: true)
  Future<void> onInitService() async {
    _flutterSecureStorage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions:
            IOSOptions(accessibility: KeychainAccessibility.first_unlock));

    sharedPreferences = await SharedPreferences.getInstance();
    final isFirstUes = sharedPreferences.getBool(keyFirstUserApp) ?? false;
    if (!isFirstUes) {
      sharedPreferences.setBool(keyFirstUserApp, true);
      await _flutterSecureStorage.deleteAll();
    }
  }

  @override
  Future<void> cacheAccessToken(String token) async {
    sharedPreferences.setString(keyAccessToken, token);
    return await _flutterSecureStorage.write(key: keyAccessToken, value: token);
  }

  @override
  Future<void> cacheRefreshToken(String refreshToken) async {
    return await _flutterSecureStorage.write(
        key: keyRefreshToken, value: refreshToken);
  }

  @override
  Future<void> clear() {
    sharedPreferences.clear();
    sharedPreferences.setBool(keyFirstUserApp, true);
    return _flutterSecureStorage.deleteAll();
  }

  @override
  Future<String?> accessToken() async {
    return await _flutterSecureStorage.read(key: keyAccessToken);
  }

  @override
  Future<String?> refreshToken() async {
    return await _flutterSecureStorage.read(key: keyRefreshToken);
  }

  @override
  Future<void> cacheUserID(String userId) {
    return _flutterSecureStorage.write(key: keyUserId, value: userId);
  }

  @override
  Future<String?> userId() {
    return _flutterSecureStorage.read(key: keyUserId);
  }

  @override
  Future<void> cacheUserRole(String userRole) {
    return sharedPreferences.setString(keyUserRole, userRole);
  }

  @override
  String get userRole => sharedPreferences.getString(keyUserRole) ?? '';

  @override
  Future<void> cacheLanguageCode(String language) async {
    await sharedPreferences.setString(keyLanguageCode, language);
  }

  @override
  String get languageCode =>
      sharedPreferences.getString(keyLanguageCode) ?? vietnamCode;

  @override
  Future<void> cacheGroupPermission(List<String> permission) async {
    await sharedPreferences.setStringList(keyPermissions, permission);
  }

  @override
  List<String> get permission =>
      sharedPreferences.getStringList(keyPermissions) ?? [];

  @override
  Future<void> cacheResendToken(int? resendToken) async {
    if (resendToken == null) {
      sharedPreferences.remove(keyRefreshToken);
      return;
    }
    await sharedPreferences.setInt(keyRefreshToken, resendToken);
  }

  @override
  Future<void> cacheVerificationId(String verificationId) async {
    await sharedPreferences.setString(keyVerificationId, verificationId);
  }

  @override
  int? get resendToken => sharedPreferences.getInt(keyRefreshToken);

  @override
  String get verificationId =>
      sharedPreferences.getString(keyVerificationId) ?? '';

  @override
  Future<void> cacheUID(String uid) async {
    await sharedPreferences.setString(keyUID, uid);
  }

  @override
  String get uid => sharedPreferences.getString(keyUID) ?? '';

  @override
  T getValue<T>(String key, {T? defaultValue}) {
    if (T as bool) {
      return getValueBool(key, defaultValue: defaultValue as bool) as T;
    } else if (T is int) {
      return getValueInt(key, defaultValue: defaultValue as int) as T;
    } else if (T is String) {
      return getValueString(key, defaultValue: defaultValue as String) as T;
    } else if (T is List<String>) {
      return getValueListString(key, defaultValue: defaultValue as List<String>)
          as T;
    } else {
      return defaultValue as T;
    }
  }

  @override
  Future<void> saveValue<T>(T value, String key) {
    if (value is bool) {
      return sharedPreferences.setBool(key, value);
    } else if (value is int) {
      return sharedPreferences.setInt(key, value);
    } else if (value is String) {
      return sharedPreferences.setString(key, value);
    } else if (value is List<String>) {
      return sharedPreferences.setStringList(key, value);
    } else {
      // throw Exception('Type not support');
      return Future.value();
    }
  }

  @override
  bool getValueBool(String key, {bool defaultValue = false}) =>
      sharedPreferences.getBool(key) ?? defaultValue;

  @override
  int getValueInt(String key, {int? defaultValue}) {
    return sharedPreferences.getInt(key) ?? defaultValue ?? 0;
  }

  @override
  List<String> getValueListString(String key,
      {List<String> defaultValue = const []}) {
    return sharedPreferences.getStringList(key) ?? defaultValue;
  }

  @override
  String getValueString(String key, {String defaultValue = ''}) {
    return sharedPreferences.getString(key) ?? defaultValue;
  }
}
