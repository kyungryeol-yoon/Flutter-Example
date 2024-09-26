import 'package:flutter/material.dart';
import 'package:sociallogin/common/layout/custom_drawer.dart';
import 'package:sociallogin/common/layout/render_drawer.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      // drawer: renderDrawer(),
      drawer: const CustomDrawer(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar(){
    if(title == null){
      return null;
    }else{
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        // leading 속성 : 간단한 위젯/아이콘을 appbar 왼쪽에 위치 시키는 역할
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {
        //     print('menu button is clicked');
        //   },
        // ),
        // action : 복수의 아이콘 버튼 등을 오른쪽에 배치
        actions: renderActions(),
        foregroundColor: Colors.black,
      );
    }
  }

  List<Widget>? renderActions() {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          print('shopping cart button is clicked');
        },
      ),
      IconButton(
        icon: Icon(Icons.person),
        onPressed: () {
          print('person button is clicked');
        },
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          print('search button is clicked');
        },
      ),
    ];
  }
}
