import 'package:flutter_bump_app/data/model/request/update_profile_request.dart';
import 'package:flutter_bump_app/data/model/user.dart';
import 'package:flutter_bump_app/data/remote/user_api.dart';
import 'package:flutter_bump_app/data/repository/account/iaccount_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IAccountRepository)
class AccountRepository extends IAccountRepository {
  final UserApi userApi;

  AccountRepository(this.userApi);

  @override
  Future<User?> getUserProfile() async {
    final response = await userApi.getUserProfile();
    if (response.isSuccess) {
      return response.data!;
    }
    return null;
  }

  @override
  Future<User?> updateUserProfile(UpdateProfileRequest request) async {
    final response = await userApi.updateUserProfile(request);
    return response.data;
  }
}
