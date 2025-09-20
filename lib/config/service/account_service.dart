//handle account data in here

import 'package:flutter_bump_app/base/stream/base_stream_controller.dart';
import 'package:flutter_bump_app/data/local/local_storage.dart';
import 'package:flutter_bump_app/data/model/user.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccountService {
  final LocalStorage storageService;

  final BaseStreamController<User?> _myAccount =
      BaseStreamController<User?>(null);

  BaseStreamController<User?> get myAccount => _myAccount;

  bool get isLoggedIn => _myAccount.value != null;

  AccountService({required this.storageService});

  void setAccount(User? account) {
    _myAccount.value = account;
  }
}
