import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/service/profile_servide.dart';
import 'package:flutter_bump_app/models/brand_model.dart';

import 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final ProfileServide profileServide = locator.get();
  late final AccountService accountService = locator.get();

  HomeCubit() : super(const HomeState()) {
    profileServide.fetchProfile();
  }

  void selectBrand(BrandModel brand) {
    // TODO: implement selectBrand
  }
  void updateVideoUrl(String url) {
    // TODO: implement updateVideoUrl
  }
  void validateVideo() {
    // TODO: implement validateVideo
  }
  void navigateToProfile() {
    // TODO: implement navigateToProfile
  }
  void navigateToActivity() {
    // TODO: implement navigateToActivity
  }
  void showEarningsPopup() {
    // TODO: implement showEarningsPopup
  }
  void retryValidation() {
    // TODO: implement retryValidation
  }
}
