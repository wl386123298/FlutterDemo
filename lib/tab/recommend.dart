
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/word_entity.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> with AutomaticKeepAliveClientMixin {
  int page = 1;
  bool isHasLoadMore = true;
  RefreshController _refreshController = new RefreshController(initialRefresh: true);
  ValueNotifier<List<WordEntity>> _wordListNotice = new ValueNotifier([]);
  List<WordEntity> _wordList = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    Dio dio = new Dio();
    Response response = await dio.get("https://opser.api.dgtle.com/v1/news/388?page=$page");

    print(response?.data?.toString());
    isHasLoadMore = true;
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();

    List<WordEntity> wordList = [];
    if (response?.data?.toString()?.isNotEmpty == true) {
      (response?.data["items"]).forEach((item) {
        wordList.add(WordEntity.fromJson(item));
      });
    }

    if (page == 1) {
      _wordList = wordList;
      _wordListNotice.value = _wordList;
    } else {
      if (wordList.isEmpty) {
        isHasLoadMore = false;
        _refreshController.loadNoData();
      }

      _wordList.addAll(wordList);
      _wordListNotice.value = _wordList;
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: SmartRefresher(
            header: MaterialClassicHeader(
              color: Colors.amber,
            ),
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: () {
              page = 1;
              getData();
            },
            onLoading: () {
              if (isHasLoadMore) {
                isHasLoadMore = false;
                page++;
                getData();
              }
            },
            child: ListView.builder(itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 160,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: ProgressiveImage(
                          fit: BoxFit.cover,
                          placeholder: NetworkImage("${_wordList[index]?.cover}"),
                          thumbnail: NetworkImage("${_wordList[index]?.cover}"),
                          image: NetworkImage("${_wordList[index]?.cover}"),
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(5)),
                      ),

                      renderDate(_wordList[index].push_at),

                      Center(
                          child: Padding(
                            child: Text(
                              "${_wordList[index]?.content}",
                              style: TextStyle(color: Colors.white, fontSize: 15 , fontWeight: FontWeight.w500),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          )),
                      Positioned(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Text(
                            "——${_wordList[index]?.from}",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                        right: 0,
                        bottom: 0,
                      )
                    ],
                  ),
                );
              },
              itemCount: _wordList.length,
            )));
  }


  Widget renderDate(int timestamp){
    var date =  DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true );
    var month = formatDate(date, [M]).toUpperCase();
    var year = formatDate(date, [yyyy]);
    var day = formatDate(date, [dd]);

    return Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10) ,
      child: Row(children: [
        Text("$day", style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.w500),),
        Padding(padding: EdgeInsets.only(left: 3)),
        Text("$month\n$year",style: TextStyle(color: Colors.white70, fontSize: 13,fontWeight: FontWeight.w500),)
    ],),);
  }

  @override
  bool get wantKeepAlive => true;
}
