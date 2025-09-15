import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:flutter_bump_app/config/model/account.dart';
import 'package:flutter_bump_app/data/repository/account/iaccount_repository.dart';

@Injectable(as: IAccountRepository)
class AccountRepository extends IAccountRepository {
  @override
  Future<Account?> createAccountModel(
      {String email = '', String fullName = '', String id = ''}) {
    // TODO: implement createAccountModel
    throw UnimplementedError();
  }

  @override
  Future<Account?> getAccountDetail(String id) {
    // TODO: implement getAccountDetail
    throw UnimplementedError();
  }

  @override
  Future<List<Account>> getListAccountByKeyword(String keyword,
      {int page = 1, int limit = 10, List<String> unContainUid = const []}) {
    // TODO: implement getListAccountByKeyword
    throw UnimplementedError();
  }

  @override
  Future<Account?> updateAccountModel(Account account) {
    // TODO: implement updateAccountModel
    throw UnimplementedError();
  }

  @override
  Future<Account?> updateMyProfile(String id, Map<String, dynamic> data) {
    // TODO: implement updateMyProfile
    throw UnimplementedError();
  }

  @override
  Future<Account?> uploadAvatar(String id, File file) {
    // TODO: implement uploadAvatar
    throw UnimplementedError();
  }

  @override
  Future<Account?> uploadBackgroundImage(String id, File file) {
    // TODO: implement uploadBackgroundImage
    throw UnimplementedError();
  }
}
