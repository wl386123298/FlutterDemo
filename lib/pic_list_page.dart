import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/pic_list_entity.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:transition/transition.dart';

import 'gallery_photo_view.dart';

/// 创建时间：2021/11/12
/// 作者：wliang
/// 描述：

class PicListPage extends StatefulWidget {
  @override
  _PicListPageState createState() => _PicListPageState();
}

class _PicListPageState extends State<PicListPage> {
  RefreshController refreshController = new RefreshController();
  int page = 1;
  bool isHasLoadMore = true;
  ValueNotifier<List<PicListEntity>> picListNotifier = new ValueNotifier([]);
  List<PicListEntity> picList = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      child: SmartRefresher(
        header: MaterialClassicHeader(color: Colors.amber,),
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: picList.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context,  Transition(
                      child: GalleryPhotoViewWrapper(
                        galleryItems: [picList[index].attachment?.pic_url],
                        initialIndex: index,
                        backgroundDecoration: BoxDecoration(color: Colors.black),
                      ), transitionEffect: TransitionEffect.SCALE));
                },
                child: ProgressiveImage(
                  fit: BoxFit.cover,
                  height: 400,
                  placeholder: NetworkImage("${picList[index].attachment?.pic_url}"),
                  thumbnail: NetworkImage("${picList[index].attachment?.pic_url}}"),
                  image: NetworkImage("${picList[index].attachment?.pic_url}"),
                  //height: height.toDouble() ,
                  width: double.infinity,
                ),
              );
            },
            staggeredTileBuilder: (index) {
              var isHorizontal = (picList[index]?.attachment?.width ?? 0) >= (picList[index]?.attachment?.height??0);

              var screenWidth =  MediaQuery.of(context).size.width /2 - 20;

              var height = isHorizontal ? 200 : ((picList[index]?.attachment?.height ??0) * screenWidth)/ (picList[index]?.attachment?.width ?? 0);

              return StaggeredTile.extent(2, height.toDouble());
            }),
      )
    ));
  }


  void loadData() async{
    var url = "https://opser.api.dgtle.com/v1/whale/index?page=$page&status=0";
    Dio dio = new Dio();
    var response = await dio.get(url);
    refreshController.loadComplete();
    refreshController.refreshCompleted();
    isHasLoadMore = true;

    List<dynamic> list = response.data['items'];

    var pictureList = list.map((e) => PicListEntity.fromJson(e)).toList();

    if(page == 1){
      picList = pictureList;
    }else{
      picList.addAll(pictureList);
    }

    if(list.isEmpty){
      refreshController.loadNoData();
      isHasLoadMore = false;
    }

    setState(() {

    });


  }

  void _onRefresh() {
    page = 1;
    loadData();
  }

  void _onLoading() {
     if(isHasLoadMore){
       isHasLoadMore = false;
       page ++;
       loadData();
     }
  }
}
