import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/idle_entity.dart';
import 'package:flutter_demo/idle_detail_page.dart';
import 'package:flutter_demo/widget/common_widget.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:transition/transition.dart';

class IdleListPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<IdleListPage> {
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
    var isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black38 : Color(0xFFF5F5F5),
      appBar: commonAppBar(title: "闲置"),
      body: SmartRefresher(
        enablePullUp: enablePullUp,
        controller: _refreshController,
        header: MaterialClassicHeader(color: Colors.amber),
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
          childAspectRatio: (MediaQuery.of(context).size.width / 2 - 30) / (150+ 3 + 30 + 15 + 10 + 12 + 6  + 12),
          mainAxisSpacing: 15,
          crossAxisSpacing: 10
        ), itemBuilder: (context, index){
          var imageUrl = _idleList[index]?.cover;
           return Container(
             decoration: BoxDecoration(

                 color: isDark ? Colors.black : Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black12,
                     blurRadius: 6.0,
                     spreadRadius: 0,
                     offset: Offset(1, 1), // shadow direction: bottom right
                   )
                 ],
                 borderRadius: BorderRadius.circular(5)),
             padding: EdgeInsets.only(bottom: 10),
             child: InkWell(
               onTap: (){
                 Navigator.push(context, Transition(child: IdleDetailPage(id: "${_idleList[index]?.id}", title: "${_idleList[index]?.title}" ,), transitionEffect: TransitionEffect.RIGHT_TO_LEFT));
               },
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                     child: ProgressiveImage(
                       fit: BoxFit.cover,
                       placeholder: NetworkImage("$imageUrl"),
                       thumbnail: NetworkImage("$imageUrl"),
                       image: NetworkImage("$imageUrl"),
                       height: 150,
                       width: double.infinity,
                     ),

                   ),

                   const SizedBox(height: 3),

                   Padding(padding: EdgeInsets.symmetric(horizontal: 7), child:Text("${_idleList[index]?.title}",
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(color: isDark ?  Colors.grey : Colors.black, fontSize: 14,),) ),


                  Padding(padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                      child: RichText(
                        text: TextSpan(
                          text: "¥",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                          children: [
                            TextSpan(
                              text: "${_idleList[index]?.price}",
                              style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.w600)
                            )
                          ]
                        ),
                      )),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 7), child:Text("${_idleList[index]?.address}",style: TextStyle(color: isDark ?  Colors.grey : Colors.black87, fontSize: 11),)),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3), child: Text("${_idleList[index]?.relativeTime}•${_idleList[index]?.author?.username}",
                       style: TextStyle(color:isDark ?  Colors.grey : Colors.black38, fontSize: 11),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,),

          )],
               ),
             ),
           );
        }, itemCount: _idleList.length, padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),),
      ),
    );
  }
}
