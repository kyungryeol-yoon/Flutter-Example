import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sociallogin/common/component/pagination_list_view.dart';
import 'package:sociallogin/common/const/colors.dart';
import 'package:sociallogin/common/const/data.dart';
import 'package:sociallogin/user/model/user_model.dart';
import 'package:sociallogin/user/provider/user_me_provider.dart';
import 'package:sociallogin/user/repository/user_me_repository.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userInfo = userMeProvider;
    final userInfo = ref.read(userMeProvider);
    // String? id = (userInfo as UserModel).userId;
    // String? username = (userInfo as UserModel).name;
    // String? profile = (userInfo as UserModel).profile;

    // log('id : $id');
    // log('user : $username');
    // log('profile : $profile');

    return Center(
      child: SingleChildScrollView(
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text((userInfo as UserModel).userId),
                Text((userInfo as UserModel).name),
                _UserInfo(),
                ElevatedButton(
                  onPressed: () {
                    ref.read(userMeProvider.notifier).logout();
                  },
                  child: Text('로그아웃'),
                ),
              ],
            )
          )
        )
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'USER',
          style: TextStyle(
            fontSize: 16,
            color: BODY_TEXT_COLOR,
          ),
        ),
        Text(
          'EMAIL',
          style: TextStyle(
            fontSize: 16,
            color: BODY_TEXT_COLOR,
          ),
        ),
      ],
    );
  }
}