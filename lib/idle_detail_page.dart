import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/idle_detail_entity.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:transition/transition.dart';

import 'gallery_photo_view.dart';

/// 创建时间：2021/11/2
/// 作者：wliang
/// 描述：

class IdleDetailPage extends StatefulWidget {
  final String id;
  final String title;

  IdleDetailPage({this.id, this.title});

  @override
  _IdleDetailPageState createState() => _IdleDetailPageState();
}

class _IdleDetailPageState extends State<IdleDetailPage> {
  
  @override
  void initState() {
    super.initState();
  }

  //load the data
  Future<IdleDetailEntity> loadData() async {
    Dio dio = new Dio();
    var response = await dio.get("https://opser.api.dgtle.com/v1/sale/detail/${widget.id}?expand=is_favourite,likelist,is_like");

    return Future.value(IdleDetailEntity.fromJson(response.data));

  }
  
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: ()=> Navigator.pop(context),
          child: Icon(Icons.arrow_back_rounded , size: 20, color: isDark ? Colors.grey : Colors.black87,),
        ),
        title: Text("闲置"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(builder: (_ ,data){
          IdleDetailEntity info = data.data;
          if (data.hasData) {
          return Container(
            child: ListView(
              padding: EdgeInsets.all( 15),
              children: [

                Row(
                  children: [
                    CircleAvatar(backgroundImage: CachedNetworkImageProvider(info?.author?.avatar_path), radius: 20,),
                    const SizedBox(width: 10,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${info?.author?.username}",style: TextStyle(fontSize: 14, color: isDark ? Colors.grey : Colors.black87)),
                        const SizedBox(height: 8,),
                        Text("${info?.relativeTime}" ,style: TextStyle(fontSize: 12, color: isDark ? Colors.grey : Colors.black54),),
                      ],
                    )),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("¥${info?.price}", style: TextStyle(fontSize: 17, color: Colors.red, fontWeight: FontWeight.w600),),
                        const SizedBox(height: 5,),
                        Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10,  vertical: 5),
                          height: 30 ,
                          width: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(40)
                          ),
                          child: Text("联系他", style: TextStyle(color: isDark ? Colors.white70 : Colors.white, fontSize: 12),),
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10,),

                Text("成色：${info.quality <= 2 ? "几乎全新": info?.quality == 3 ? "非常好" : "一般"}", style: TextStyle(fontSize: 12, color:isDark ? Colors.grey :  Colors.black38),),
                const SizedBox(height: 2),
                Text("所在地：${info?.address}", style: TextStyle(fontSize: 12, color:isDark ? Colors.grey : Colors.black38),),
                const SizedBox(height: 2),
                Text("运费：${info?.freight??'无'}", style: TextStyle(fontSize: 12, color:isDark ? Colors.grey : Colors.black38),),

                const SizedBox(height: 10),

                Text("${info?.content??'无'}", style: TextStyle(fontSize: 17, color: isDark ? Colors.grey : Colors.black87 , height: 1.5),),

                const SizedBox(height: 15,),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(info?.img?.length ?? 0, (index){
                    var isHorizontal = (info?.img[index]?.width ?? 0) >= (info?.img[index]?.height??0);

                    var screenWidth =  MediaQuery.of(context).size.width - 30;

                    var height = isHorizontal ? 400 : ((info?.img[index]?.height ??0) * screenWidth)/ (info?.img[index]?.width ?? 0);

                    return InkWell(
                      onTap: (){
                        Navigator.push(context,  Transition(
                            child: GalleryPhotoViewWrapper(
                              galleryItems: info?.img?.map((e) => e.path)?.toList(),
                              initialIndex: index,
                              backgroundDecoration: BoxDecoration(color: Colors.black),
                            ), transitionEffect: TransitionEffect.SCALE));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: ProgressiveImage(
                              fit: BoxFit.cover,
                              placeholder: NetworkImage("${info.img[index]?.path}"),
                              thumbnail: NetworkImage("${info.img[index]?.path}"),
                              image: NetworkImage("${info.img[index]?.path}"),
                              height: height.toDouble() ,
                              width: double.infinity,
                            )),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          );
          } else {
            return CupertinoActivityIndicator(radius: 16);
          }
        }, future: loadData(),),
      ),
    );
  }
  

}
