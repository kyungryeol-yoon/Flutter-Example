import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

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
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      print('accessToken = ${googleSignInAuthentication.accessToken}');
      print('name = ${googleSignInAccount.displayName}');
      print('email = ${googleSignInAccount.email}');
      print('id = ${googleSignInAccount.id}');

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
