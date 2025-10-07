// import 'package:flutter_bump_app/base/usecase/base_usecase.dart';
// import 'package:flutter_bump_app/config/service/account_service.dart';
// import 'package:flutter_bump_app/config/service/auth_service.dart';
// import 'package:flutter_bump_app/data/model/user.dart';
// import 'package:flutter_bump_app/data/repository/auth/iauth_repository.dart';
// import 'package:injectable/injectable.dart';

// @lazySingleton
// class SignInGoogleUseCase extends BaseResultUseCase<User> {
//   final AuthService authService;
//   final IAuthRepository authRepository;
//   final AccountService accountService;

//   SignInGoogleUseCase(
//       this.authService, this.authRepository, this.accountService);

//   @override
//   Future<User> call() {
//     return authService.signInWithGoogle();
//   }
// }
