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
}
