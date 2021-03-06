import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/contacts_list.dart';
import 'package:flutter_demo/find.dart';
import 'package:flutter_demo/me.dart';
import 'package:flutter_demo/widget/dgtle_home.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:lazy_indexed_stack/lazy_indexed_stack.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {
  int _currentIndex = 0;
  var _pageList = [DgtleHomePage(), ContactListPage(), FindPage(key: PageStorageKey("find"),), MePage()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: IconThemeData(color: Colors.black26),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          print(value);
          setState(() {
            _currentIndex = value;
          });
        },
        fixedColor: Colors.green,
        items: [
          BottomNavigationBarItem(icon: Icon(MfgLabs.comment), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Typicons.contacts), label: "闲置"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.compass), label: "发现"),
          BottomNavigationBarItem(icon: Icon(Entypo.user), label: "我")
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
