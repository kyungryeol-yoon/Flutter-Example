import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sociallogin/common/const/data.dart';
import 'package:sociallogin/common/dio/dio.dart';
import 'package:sociallogin/common/const/login_platform.dart';
import 'package:sociallogin/common/model/login_response.dart';
import 'package:sociallogin/common/model/token_response.dart';
import 'package:sociallogin/common/utils/data_utils.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(baseUrl: 'http://$ip/auth', dio: dio);
});

class AuthRepository {
  // http://$ip/auth
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64('$username:$password');

    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {
          'authorization': 'Basic $serialized',
        },
      ),
    );

    log('resp check : $resp');

    return LoginResponse.fromJson(
      resp.data,
    );
  }

  Future<LoginResponse> socialLogin({
    required final socialAccessToken,
    required LoginPlatform platform,
  }) async {
    Map data = {"oAuthProvider": 'GOOGLE', "accessToken": socialAccessToken};

    var body = json.encode(data);
    log('Body Check : $body');

    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {"Content-Type": "application/json"},
      ),
      data: body,
    );
    log('resp Check : $resp');

    final jsonCheck = LoginResponse.fromJson(
      resp.data,
    );

    log('jsonCheck Check : $jsonCheck');
    
    return LoginResponse.fromJson(
      resp.data,
    );
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/token',
      options: Options(
        headers: {
          'refreshToken': 'true',
        },
      ),
    );

    return TokenResponse.fromJson(resp.data);
  }
}
