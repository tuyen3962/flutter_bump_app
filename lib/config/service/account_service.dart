//handle account data in here

import 'package:injectable/injectable.dart';
import 'package:flutter_bump_app/data/local/local_storage.dart';

@injectable
class AccountService {
  final LocalStorage storageService;

  AccountService({required this.storageService});
}
