import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sociallogin/common/login_platform.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String get routeName => 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  void signInWithGoogle() async {
    try {
      print("test");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("test");
      if (googleUser != null) {
        print('name = ${googleUser.displayName}');
        print('email = ${googleUser.email}');
        print('id = ${googleUser.id}');

        setState(() {
          _loginPlatform = LoginPlatform.google;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  void signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.facebook:
        break;
      case LoginPlatform.google:
        await GoogleSignIn().signOut();
        break;
      case LoginPlatform.kakao:
        break;
      case LoginPlatform.naver:
        break;
      case LoginPlatform.apple:
        break;
      case LoginPlatform.none:
        break;
    }

    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _loginPlatform != LoginPlatform.none
              ? _logoutButton()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _loginButton(
                      'google_logo',
                      signInWithGoogle,
                    ),
                    _loginButton(
                      'kakao_logo',
                      signInWithKakao,
                    )
                  ],
                )),
    );
  }

  Widget _loginButton(String path, VoidCallback onTap) {
    return Card(
      elevation: 5.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Ink.image(
        image: AssetImage('asset/image/$path.png'),
        width: 60,
        height: 60,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(35.0),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return ElevatedButton(
      onPressed: signOut,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff0165E1),
        ),
      ),
      child: const Text('로그아웃'),
    );
  }
}

class KakaoLoginHelper {
  Future<String> getKakaoKeyHash() async {
    var key = await KakaoSdk.origin;
    return key;
  }

  Future<String?> login() async {
    var key = await getKakaoKeyHash();
    log('kakaologinHelper + $key');
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        log('카카오톡으로 로그인 성공 : ${token.toString()}');
        return token.accessToken; //토큰 정보
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();

          log('카카오계정으로 로그인 성공 : ${token.toString()}');
          return token.accessToken; //토큰 정보
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        log('카카오계정으로 로그인 성공 : ${token.toString()}');
        return token.accessToken; //토큰 정보
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
    return null;
  }

  Future<void> logout() async {
    try {
      UserApi.instance.logout();
    } catch (error) {
      print('카카오 로그인 실패 $error');
    }
  }
}

class GoogleLoginHelper {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String?> login() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      print(googleSignInAuthentication.accessToken);

      return googleSignInAuthentication.accessToken;
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout(String? accessToken) async {
    await revokeToken(accessToken!);

    await googleSignIn.signOut();
    print('User signed out');
  }

  Future<void> revokeToken(String token) async {
    final response = await http.post(
      Uri.parse('https://oauth2.googleapis.com/revoke'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: 'token=$token',
    );

    if (response.statusCode == 200) {
      print('Token revoked successfully');
    } else {
      print('Failed to revoke token');
    }
  }
}
