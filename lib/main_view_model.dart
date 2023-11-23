import 'social_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class MainViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;

  MainViewModel(this._socialLogin);

  Future login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await UserApi.instance.me();
    }
  }

  Future logout() async {
    // 로그인 상태를 확인하고 로그아웃 시도
    if (isLogined) {
      await _socialLogin.logout();
      isLogined = false;
      user = null;
    } else {
      print('User is not logged in.');
    }
  }
}

