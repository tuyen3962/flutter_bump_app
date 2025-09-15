import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';
import 'package:flutter_bump_app/data/local/local_storage.dart';
import 'package:flutter_bump_app/main.dart';

const vietnamCode = 'vi';
const englishCode = 'en';
const vietnam = Locale('vi', "VN");
const english = Locale('en', "US");

const List<Locale> supportedLocales = <Locale>[english, vietnam];

extension LocaleExtension on Locale {
  String get text {
    if (languageCode == vietnamCode) {
      return 'vietnam'.tr();
    }
    return 'english'.tr();
  }
}

@singleton
class LanguageService {
  final LocalStorage localStorage;

  LanguageService({required this.localStorage}) {
    final code = localStorage.languageCode;
    _languageStream = BaseStreamController(_getLocaleByCode(code));
  }

  BaseStreamController<Locale> get language => _languageStream;
  late final BaseStreamController<Locale> _languageStream;

  void onSaveLanguage(String code) {
    localStorage.cacheLanguageCode(code);
    _languageStream.value = _getLocaleByCode(code);
    navigatorKey.currentContext!.setLocale(_getLocaleByCode(code));
  }

  Locale _getLocaleByCode(String code) {
    if (code == vietnamCode) {
      return vietnam;
    }

    return english;
  }
}
