import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/auth_service.dart';
import 'package:flutter_bump_app/screen/signin/signin_state.dart';
import 'package:flutter_bump_app/utils/loading.dart';

class SigninCubit extends BaseCubit<SigninState> {
  final AuthService authService;

  SigninCubit({required this.authService}) : super(SigninState());

  // void _checkCurrentUser() {
  //   final currentUser = AuthService.currentUser;
  //   if (currentUser != null) {
  //     emit(state.copyWith(user: currentUser));
  //   }
  // }

  Future<void> signInWithGoogle() async {
    try {
      showLoading();
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final userCredential = await AuthService.signInWithGoogle();

      if (userCredential?.user != null) {
        emit(state.copyWith(
          isLoading: false,
          user: userCredential!.user,
          errorMessage: null,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Đăng nhập bị hủy',
        ));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Đã xảy ra lỗi';

      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage = 'Tài khoản đã tồn tại với thông tin đăng nhập khác';
          break;
        case 'invalid-credential':
          errorMessage = 'Thông tin đăng nhập không hợp lệ';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Phương thức đăng nhập chưa được kích hoạt';
          break;
        case 'user-disabled':
          errorMessage = 'Tài khoản đã bị vô hiệu hóa';
          break;
        case 'user-not-found':
          errorMessage = 'Không tìm thấy tài khoản';
          break;
        case 'wrong-password':
          errorMessage = 'Mật khẩu không đúng';
          break;
        default:
          errorMessage = e.message ?? 'Đã xảy ra lỗi không xác định';
      }

      emit(state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Đã xảy ra lỗi: ${e.toString()}',
      ));
    }
    dismissLoading();
  }
}
