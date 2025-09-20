import 'package:flutter_bump_app/data/remote/request/auth/google_mobile_login_request.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class IAuthRepository extends IBaseRepository {
  Future<bool> googleMobileLogin(GoogleMobileLoginRequest request);
}
