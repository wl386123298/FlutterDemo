import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/article_detail.dart';
import 'package:flutter_demo/entity/banner_entity.dart';
import 'package:flutter_demo/entity/content_entity.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DgtleHomePage extends StatefulWidget {
  @override
  _DgtleHomePageState createState() => _DgtleHomePageState();
}

class _DgtleHomePageState extends State<DgtleHomePage> {
  int page = 1;
  List<BannerEntity> _bannerList = [];
  List<ContentEntity> _contentList = [];
  bool isHasLoadMore = true;
  RefreshController _refreshController = new RefreshController(initialRefresh: false);

  ValueNotifier<List<ContentEntity>> _contentValueList = ValueNotifier([]);

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var dio = new Dio();
    Response bannerResponse = await dio.get("https://opser.api.dgtle.com/v1/carousel/2");

    List<BannerEntity> bannerList = [];
    if (bannerResponse?.data?.toString()?.isNotEmpty == true) {
      List<dynamic> list = bannerResponse?.data;

      bannerList.clear();
      bannerList.addAll(list.map((e) => BannerEntity.fromJson(e)).toList());
    }

    Response contentResponse = await dio.get("https://opser.api.dgtle.com/v2/app/home?page=$page");
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
    isHasLoadMore = true;


    List<ContentEntity> contentList = [];
    if (contentResponse?.data?.toString()?.isNotEmpty == true) {
      List<dynamic> items = contentResponse?.data["items"];
      items?.forEach((element) {
        contentList.add(ContentEntity.fromJson(element));
      });
    }

    if (page == 1) {
      _contentList = contentList;
      _contentValueList.value = _contentList;
    } else {
      if (contentList.isEmpty) {
        isHasLoadMore = false;
        _refreshController.loadNoData();
      }
      _contentList.addAll(contentList);
      _contentValueList.value = _contentList;

    }
    setState(() {
      _bannerList = bannerList;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          centerTitle: true,
          title: SizedBox(
            height: 30,
            child: Image.asset("images/icon_dgtle.png"),
          ),
        ),
        body: SmartRefresher(
          header: MaterialClassicHeader(
            color: Colors.amber,
          ),
          controller: _refreshController,
          enablePullUp: true,
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
          child: bodyWidget(),
        ));
  }


  Widget bodyWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return SizedBox(
              height: 140,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Swiper(
                  autoplay: true,
                  autoplayDelay: 5000,
                  itemCount: _bannerList.length,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      activeColor: Colors.green,
                      color: Colors.white70,
                      activeSize: 7,
                      size: 5,
                     )
                  ),
                  viewportFraction: 0.8,
                  scale: 0.9,
                  itemBuilder: (context, position) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        "${_bannerList[position].cover ?? ""}",
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
              ));
        } else {
          return ValueListenableBuilder<List<ContentEntity>>(valueListenable: _contentValueList, builder:(context, data, child){
              if(data != null && data.isNotEmpty){
                ContentEntity contentEntity = data[index-1];
                  return Container(
                    margin: EdgeInsets.only(top: 15, left: 12, right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8.0,
                          spreadRadius: 0,
                          offset: Offset(1, 1), // shadow direction: bottom right
                        )
                      ]
                    ),
                    child: InkWell(
                      onTap: () {
                        /*Navigator.push(
                            context,
                            Transition(child: ArticleDetailPage(contentEntity.aid ?? "", contentEntity.type), transitionEffect: TransitionEffect.rightToLeft)
                                .builder());*/

                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>ArticleDetailPage(contentEntity.aid ?? "", contentEntity.type)));
                      },

                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  child: CircleAvatar(backgroundImage: NetworkImage("${contentEntity.author.avatar_path}")),
                                  height: 30,
                                ),
                                const Padding(padding: EdgeInsets.only(left: 3)),
                                Text("${contentEntity.author?.username ?? "佚名"}", style: TextStyle(fontSize: 14, color: Colors.black),)
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),

                            Text("${(contentEntity?.summary ?? "").isEmpty ? contentEntity?.title ?? "" : contentEntity?.summary ?? ""}",
                              style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400)),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            showItemImage(contentEntity),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              children: [
                                const Icon(
                                  Typicons.thumbs_up,
                                  size: 14,
                                  color: Colors.black26,
                                ),
                                const Padding(padding: EdgeInsets.only(left: 3)),
                                Text(
                                  "${contentEntity?.liketimes ?? "1"}",
                                  style: TextStyle(color: Colors.black26, fontSize: 12),
                                ),
                                const Padding(padding: EdgeInsets.only(left: 7)),
                                const Icon(
                                  Iconic.comment,
                                  size: 14,
                                  color: Colors.black26,
                                ),
                                const Padding(padding: EdgeInsets.only(left: 3)),
                                Expanded(
                                  child: Text(
                                    "${contentEntity?.commentnum ?? "1"}",
                                    style: TextStyle(color: Colors.black26, fontSize: 12),
                                  ),
                                ),
                                Text(
                                  "${contentEntity.relativeTime ?? "1分钟前"}",
                                  style: TextStyle(color: Colors.black26, fontSize: 12),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
              }else{
                return Container();
              }
          });

          //ContentEntity contentEntity = _contentList[index - 1];

        }
      },
      itemCount: _contentList.length,
    );
  }

  Widget showItemImage(ContentEntity contentEntity) {
    if ((contentEntity?.cover ?? "").isNotEmpty) {
      String coverUrl = contentEntity?.cover?.replaceAll("960", "350");
      return Container(
        width: double.infinity,
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: ProgressiveImage(
            fit: BoxFit.cover,
            placeholder:  CachedNetworkImageProvider("$coverUrl"),
            thumbnail: CachedNetworkImageProvider("$coverUrl"),
            image: CachedNetworkImageProvider("$coverUrl"),
            height: double.infinity,
            width: double.infinity,
          )

          /*CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: "${contentEntity?.cover ?? ""}",
            errorWidget: (context, url ,error)=>Image.asset("images/icon_loading_image.png"),
          )*/,
        ),
      );
    }

    if (contentEntity?.imgs_url?.isNotEmpty == true) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1, crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 3),
        itemBuilder: (context, position) {
          return Container(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: "${contentEntity?.imgs_url[position]?.replaceAll("600", "200")}",
                    errorWidget:(context, url ,error)=>Image.asset("images/icon_loading_image.png") ,
                  ),
                ),
                Positioned(
                  child: position == 2
                      ? Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(3), bottomRight: Radius.circular(3))),
                          child: Text(
                            "${contentEntity.imgs_url?.length}",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
                      : Container(),
                  bottom: 0,
                  right: 0,
                )
              ],
            ),
          );
        },
        itemCount: (contentEntity.imgs_url?.length ?? 0) > 3 ? 3 : contentEntity.imgs_url?.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      );
    }

    return Container();
  }
}
