import 'package:flutter/material.dart';
import 'package:flutter_demo/pic_list_page.dart';
import 'package:flutter_demo/tab/recommend.dart';
import 'package:flutter_demo/widget/common_widget.dart';

class FindPage extends StatefulWidget {
  FindPage({Key key}):super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  var _tabList = ["一言", "精选", "最新"];
  List<Widget> _tabViewList = [RecommendPage(), PicListPage(key:PageStorageKey("hot") ,) ,PicListPage(key: PageStorageKey("new"), status: -1,)];

  PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: _tabList.length, child: Scaffold(
      appBar: commonAppBar(
          title: "发现",
          bottom: TabBar(
              labelStyle: TextStyle(fontSize: 15 , fontWeight: FontWeight.w500),
              unselectedLabelColor: Colors.black87,
              labelColor: Colors.amber.shade900,
              indicatorColor: Colors.amber.shade900,
              indicatorWeight: 3,
              isScrollable: true,
              automaticIndicatorColorAdjustment: true,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: _tabList.map((e) => Tab(
                text: "$e",
              )).toList())),
      body: PageStorage(bucket: _bucket, child: TabBarView(children: _tabViewList))
    ));
  }
  
}
