import 'package:flutter/material.dart';
import 'package:sociallogin/board/screen/board_screen.dart';

Drawer? renderDrawer() {
  return Drawer(
    child: ListView(
      // 여백 없애기
      padding: EdgeInsets.zero,
      children: [
        // UserAccountsDrawerHeader - 사용자 프로필에 해당하는 부분
        UserAccountsDrawerHeader(
          // currentAccountPicture: CircleAvatar - 현재 사용의 이미지를 원형으로 설정
          currentAccountPicture: CircleAvatar(
            // backgroundImage - 사용자 프로필 사진 설정
            backgroundImage: AssetImage('asset/image/profile/ykr.png'),
          ),
          // otherAccountsPictures : 다른 사용자 프로필 사진 우측 상단에 표시, 여러 개 추가 가능
          otherAccountsPictures: [
            CircleAvatar(
              backgroundImage: AssetImage('asset/image/profile/ktm.png'),
            ),
            CircleAvatar(
              backgroundImage: AssetImage('asset/image/profile/test.png'),
            )
          ],
          accountName: Text(''),
          accountEmail: Text(''),
          // 토글 버튼 추가, 밑으로 펼쳐지며 내용 표시
          onDetailsPressed: () {
            print('OnDetailPressed is clicked');
          },
          // UserAccountsDrawerHeader에 디자인 요소 추가
          decoration: BoxDecoration(
            color: Colors.purple[200],
            // drawer를 둥글게 만듬
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            )
          ),
        ),
        // ListTile : 탭 하거나 길게 누르는 이벤트를 감지할 수 있는 기능을 가지고 있다.
        // leading : 좌측에 아이콘 추가
        // trailing : 우측에 아이콘 추가
        // onTap : onPressed와 거의 동일한 기능
        //  - onPressed는 주로 버튼에 적용, on Tab은 gestureDetector, InkWell 등에 주로 적용
        //  - 길게 누르기, 두 번 탭하기 등 어떤 동작에 반응하는 이벤트를 위함
        //  - ListTile에서 onTab을 사용하는 이유 : 탭 or 길게 누르기 등 액션을 감지할 수 있는 기능을 갖고 있기 때문
        ListTile(
            leading: Icon(Icons.home),
            iconColor: Colors.purple,
            focusColor: Colors.purple,
            title: Text('홈'),
            onTap: () {
              print('Home is clicked');
            },
            trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(Icons.question_answer_rounded),
            iconColor: Colors.purple,
            focusColor: Colors.purple,
            title: Text('게시판'),
            onTap: () {
              print('게시판 is clicked');
            },
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_rounded),
            iconColor: Colors.purple,
            focusColor: Colors.purple,
            title: Text('쇼핑'),
            onTap: () {},
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            leading: Icon(Icons.mark_as_unread_sharp),
            iconColor: Colors.purple,
            focusColor: Colors.purple,
            title: Text('편지함'),
            onTap: () {},
            trailing: Icon(Icons.navigate_next),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Labels"),
          ),
          ListTile(
            leading: Icon(Icons.restore_from_trash),
            iconColor: Colors.purple,
            focusColor: Colors.purple,
            title: Text('휴지통'),
            onTap: () {},
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            iconColor: Colors.purple,
            focusColor: Colors.purple,
            title: Text('설정'),
            onTap: () {},
            trailing: Icon(Icons.navigate_next),
          ),
      ],
    ),
  );
}