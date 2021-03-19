import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/user_info_entity.dart';
import 'package:flutter_demo/widget/common_widget.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  TextEditingController _textEditingController = TextEditingController();
  List<UserInfoEntity> dataList = [];
  int page = 0;
  bool isHasLoadMore = true;
  RefreshController _refreshController = new RefreshController();

  @override
  void initState() {
    print("index page");
    getData();
    super.initState();
  }

  void getData() async {
    Dio dio = new Dio();
    var response = await dio.get("https://api.juejin.cn/user_api/v1/author/recommend?category_id=&cursor=${page * 20}&limit=20");

    List<UserInfoEntity> userInfoList = [];

    _refreshController.loadComplete();
    _refreshController.refreshCompleted();

    if (response.data != null && response.data["err_no"] == 0) {
      isHasLoadMore = response.data["has_more"];
      List<dynamic> dataList = response.data["data"];
      if (!isHasLoadMore) {
        _refreshController.loadNoData();
      }

      dataList.asMap().forEach((key, value) {
        userInfoList.add(UserInfoEntity.fromJson(value));
      });
    }

    setState(() {
      if (page == 0) {
        dataList = userInfoList;
      } else {
        dataList.addAll(userInfoList);
      }
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "微信", actions: [
        Icon(
          CupertinoIcons.add_circled,
          color: Colors.black54,
        )
      ]),
      body: SmartRefresher(
          header: MaterialClassicHeader(
            color: Theme.of(context).accentColor,
          ),
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () {
            page = 0;
            getData();
          },
          onLoading: () {
            if (isHasLoadMore) {
              isHasLoadMore = false;
              page++;
              getData();
            }
          },
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
                indent: 20,
                color: Colors.black12,
              );
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                    margin: EdgeInsets.all(7),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Theme.of(context).accentColor)),
                    child: TextField(
                        controller: _textEditingController,
                        autocorrect: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          hintText: 'Enter Your Search Content Here...',
                          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Octicons.search,
                            size: 14,
                            color: Colors.grey,
                          ),
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                          filled: true,
                          fillColor: Colors.white70,
                        )));
              } else {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 7),
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black12, width: 0.5), borderRadius: BorderRadius.circular(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            dataList[index - 1].avatar_large ?? "",
                            fit: BoxFit.cover,
                          ),
                        )),
                    title: Text("${dataList[index - 1].user_name ?? ""}"),
                    subtitle: Text("${dataList[index - 1].job_title ?? ""}\n${dataList[index - 1].description ?? ""}"),
                  ),
                );
              }
            },
            itemCount: dataList.length,
          )),
    );
  }
}
