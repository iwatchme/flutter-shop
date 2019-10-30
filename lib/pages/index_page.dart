import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopdemo/pages/cart_page.dart';
import 'package:shopdemo/pages/category_page.dart';
import 'package:shopdemo/pages/home_page.dart';
import 'package:shopdemo/pages/member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> {
  int _currentindex = 0;

  List<BottomNavigationBarItem> tabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text("会员中心"))
  ];

  List<Widget> bodys = <Widget>[
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  void _changeIndex(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: tabs,
        currentIndex: _currentindex,
        onTap: (index) {
          _changeIndex(index);
        },
      ),
      body: IndexedStack(
        index: _currentindex,
        children:  bodys,
      )
    );
  }
}
