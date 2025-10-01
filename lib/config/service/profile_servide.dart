import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/data/model/request/update_profile_request.dart';
import 'package:flutter_bump_app/data/repository/account/iaccount_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProfileServide {
  final AccountService accountService;
  final IAccountRepository accountRepository;

  ProfileServide({
    required this.accountService,
    required this.accountRepository,
  });

  Future<void> fetchProfile() async {
    final userInfo = await accountRepository.getUserProfile();
    accountService.setAccount(userInfo);
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    final updatedUser = await accountRepository.updateUserProfile(request);
    accountService.setAccount(updatedUser);
  }
}
