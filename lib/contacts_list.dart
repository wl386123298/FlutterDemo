import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/idle_entity.dart';
import 'package:flutter_demo/widget/common_widget.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContactListPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<ContactListPage> {
  RefreshController _refreshController = new RefreshController(initialRefresh: true);
  int page = 1;
  bool isHasLoadMore = true;
  List<IdleEntity> _idleList = [];
  bool enablePullUp = false;

  @override
  void initState() {
    getData();
    super.initState();
  }


  void getData() async{
    Dio dio = new Dio();
    Response response = await dio.get("https://opser.api.dgtle.com/v1/sale/index/0?page=$page");

    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
    isHasLoadMore = true;
    enablePullUp = true;

    List<IdleEntity> idleList = [];
    if(response?.data?.toString()?.isNotEmpty == true){
      List<dynamic> items =  response?.data["items"];

      items?.forEach((item) {
          idleList.add(IdleEntity.fromJson(item));
      });
    }


    if(page ==1){
      _idleList = idleList;
    }else{
      if(idleList.isEmpty){
        _refreshController.loadNoData();
        isHasLoadMore = false;
      }

      _idleList.addAll(idleList);
    }

    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: commonAppBar(title: "闲置"),
      body: SmartRefresher(
        enablePullUp: enablePullUp,
        controller: _refreshController,
        header: MaterialClassicHeader(color: Colors.amber,),
        onLoading: (){
          if (isHasLoadMore) {
            isHasLoadMore = false;
            page ++;
            getData();
          }
        },
        onRefresh: (){
          page =1;
          getData();
        },
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.82,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10
        ), itemBuilder: (context, index){
          var imageUrl = _idleList[index]?.cover?.replaceAll("600", "300");
           return Container(
             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
             padding: EdgeInsets.only(bottom: 10),
             child: Column(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 ClipRRect(
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                   child: ProgressiveImage(
                     fit: BoxFit.cover,
                     placeholder: NetworkImage("$imageUrl"),
                     thumbnail: NetworkImage("$imageUrl"),
                     image: NetworkImage("$imageUrl"),
                     height: 100,
                     width: double.infinity,
                   ),
                 ),

                 Padding(padding: EdgeInsets.symmetric(horizontal: 7), child:Text("${_idleList[index]?.title}",
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(color: Colors.black87, fontSize: 15,),) ,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 7), child:Text("¥${_idleList[index]?.price}",style: TextStyle(color: Colors.red, fontSize: 15),)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 7), child:Text("${_idleList[index]?.address}",style: TextStyle(color: Colors.black26, fontSize: 12),)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 7), child: Text("${_idleList[index]?.relativeTime}•${_idleList[index]?.author?.username}",
                     style: TextStyle(color: Colors.black26, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,),

          )],
             ),
           );
        }, itemCount: _idleList.length, padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),),
      ),
    );
  }
}
