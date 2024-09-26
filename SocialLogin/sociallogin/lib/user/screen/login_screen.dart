import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sociallogin/common/component/custom_text_form_field.dart';
import 'package:sociallogin/common/const/colors.dart';
import 'package:sociallogin/common/const/login_platform.dart';
import 'package:sociallogin/common/layout/default_layout.dart';
import 'package:sociallogin/helper/login_helper.dart';
import 'package:sociallogin/user/model/user_model.dart';
import 'package:sociallogin/user/provider/user_me_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static String get routeName => 'login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  LoginPlatform _loginPlatform = LoginPlatform.NONE;

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);
    
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(height: 16.0),
                _SubTitle(),
                Image.asset(
                  'asset/image/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 2 * 1,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요.',
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요.',
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: state is UserModelLoading
                      ? null
                      : () async {
                          ref.read(userMeProvider.notifier).login(
                                username: username,
                                password: password,
                              );

                          // ID:비밀번호
                          // final rawString = '$username:$password';
                          //
                          // Codec<String, String> stringToBase64 = utf8.fuse(base64);
                          //
                          // String token = stringToBase64.encode(rawString);
                          //
                          // final resp = await dio.post(
                          //   'http://$ip/auth/login',
                          //   options: Options(
                          //     headers: {
                          //       'authorization': 'Basic $token',
                          //     },
                          //   ),
                          // );
                          //
                          // final refreshToken = resp.data['refreshToken'];
                          // final accessToken = resp.data['accessToken'];
                          //
                          // final storage = ref.read(secureStorageProvider);
                          //
                          // await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                          // await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
                          //
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) => RootTab(),
                          //   ),
                          // );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    // primary: PRIMARY_COLOR,
                  ),
                  child: Text(
                    '로그인',
                  ),
                ),
                TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    // primary: Colors.black,
                  ),
                  child: Text(
                    '회원가입',
                  ),
                ),
                ElevatedButton(
                  onPressed: state is UserModelLoading
                      ? null
                      : () async {
                          final googleLoginHelper = new GoogleLoginHelper();
                          final googleToken = await googleLoginHelper.login();
                          _loginPlatform = LoginPlatform.GOOGLE;

                          ref.read(userMeProvider.notifier).socialLogin(
                            socialAccessToken: googleToken,
                            platform: _loginPlatform,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    // primary: PRIMARY_COLOR,
                  ),
                  child: Text(
                    'Google Sign In',
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        // kakaoLogin();
                      } catch (error) {
                        print('카카오 로그인 실패 $error');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        )),
                    child: const Text('카카오 로그인'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: _loginPlatform != LoginPlatform.NONE
//               ? _logoutButton()
//               : Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _loginButton(
//                       'google_logo',
//                       googleLogin,
//                     ),
//                     _loginButton(
//                       'kakao_logo',
//                       kakaoLogin,
//                     )
//                   ],
//                 )),
//     );
//   }

//   Widget _loginButton(String path, VoidCallback onTap) {
//     return Card(
//       elevation: 5.0,
//       shape: const CircleBorder(),
//       clipBehavior: Clip.antiAlias,
//       child: Ink.image(
//         image: AssetImage('asset/image/$path.png'),
//         width: 60,
//         height: 60,
//         child: InkWell(
//           borderRadius: const BorderRadius.all(
//             Radius.circular(35.0),
//           ),
//           onTap: onTap,
//         ),
//       ),
//     );
//   }

//   Widget _logoutButton() {
//     return ElevatedButton(
//       onPressed: signOut,
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(
//           const Color(0xff0165E1),
//         ),
//       ),
//       child: const Text('로그아웃'),
//     );
//   }
// }
