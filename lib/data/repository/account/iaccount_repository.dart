import 'package:flutter_bump_app/data/model/user.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class IAccountRepository extends IBaseRepository {
  Future<User?> getUserProfile();
  Future<User?> updateUserProfile(User user);
}
