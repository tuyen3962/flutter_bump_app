import 'package:flutter_bump_app/data/model/request/update_profile_request.dart';
import 'package:flutter_bump_app/data/model/user.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class IAccountRepository extends IBaseRepository {
  Future<User?> getUserProfile();
  Future<User?> updateUserProfile(UpdateProfileRequest request);
  Future<void> logout();
}
