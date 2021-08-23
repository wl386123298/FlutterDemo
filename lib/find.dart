import 'package:flutter/material.dart';
import 'package:flutter_demo/home.dart';
import 'package:flutter_demo/tab/hot.dart';
import 'package:flutter_demo/tab/new.dart';
import 'package:flutter_demo/tab/recommend.dart';
import 'package:flutter_demo/widget/common_widget.dart';

class FindPage extends StatefulWidget {
  FindPage({Key key}):super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  var _tabList = ["一言", "热门", "最新"];
  List<Widget> _tabViewList = [RecommendPage(), HotPage(),NewPage(key: PageStorageKey("new"),)];

  PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: _tabList.length, child: Scaffold(
      appBar: commonAppBar(
          title: "发现",
          bottom: TabBar(
              indicatorColor: Colors.amber,
              indicatorWeight: 3,
              isScrollable: true,
              tabs: _tabList.map((e) => Tab(
                text: "$e",
              ))
                  .toList())),
      body: PageStorage(bucket: _bucket, child: TabBarView(children: _tabViewList))
    ));
  }
}
