import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/contacts_list.dart';
import 'package:flutter_demo/find.dart';
import 'package:flutter_demo/me.dart';
import 'package:flutter_demo/widget/dgtle_home.dart';
import 'package:lazy_indexed_stack/lazy_indexed_stack.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {
  int _currentIndex = 0;
  var _pageList = [DgtleHomePage(), IdleListPage(), FindPage(key: PageStorageKey("find"),), MePage()];


  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark ? Colors.black87 : Colors.white,
        unselectedIconTheme: IconThemeData(color: isDark ? Colors.grey : Colors.black54),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        fixedColor: Colors.green,
        selectedFontSize: 12,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home ,), label: "首页"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart), label: "闲置"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.compass), label: "发现"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_solid), label: "我")
        ],
      ),
      body: LazyIndexedStack(
        reuse: false,
        itemBuilder: (context, index){
          return _pageList[index];
        },
        index: _currentIndex,
        itemCount: _pageList.length,
      ),
    );
  }
}
