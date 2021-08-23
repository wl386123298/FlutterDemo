import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/entity/article_detail_content_entity.dart';
import 'package:flutter_demo/entity/comment_entity.dart';
import 'package:flutter_demo/gallery_photo_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:transition/transition.dart';

class ArticleDetailPage extends StatelessWidget {
  final String id;
  final String type;

  final String defaultImageUrl =
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201704%2F27%2F20170427155254_Kctx8.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1618021408&t=ef9f6502bee1e3b1d1bd94bb6a4c5d10";

  final ValueNotifier<ArticleDetailContentEntity> _detailNotice = ValueNotifier(null);

  ArticleDetailPage(this.id, this.type) {
    getData();
  }

  void getData() async {
    Dio dio = new Dio();

    var url = "https://opser.api.dgtle.com/v1/feeds/inst/${id}?expand=is_focus,is_like";

    if ("14" == type) {
      url = "https://opser.api.dgtle.com/v1/news/detail/${id}?expand=likelist,is_like,is_favourite,like";
    }

    if (type == "1") {
      url = "https://opser.api.dgtle.com/v1/article/view/${id}?expand=is_like,is_favourite,likelist,is_focus";
    }

    print("url::::$url");
    Response contentResponse = await dio.get(url);
    var _detailEntity;
    if (contentResponse?.data?.toString()?.isNotEmpty == true) {
      _detailEntity = ArticleDetailContentEntity.fromJson(contentResponse?.data ?? "");
    }

    if (_detailEntity != null) {
      _detailNotice.value = _detailEntity;
    }
  }

  Future<List<CommentEntity>> getComment() async {
    Dio dio = new Dio();
    Response commentResponse = await dio.get("https://opser.api.dgtle.com/v1/comments/${id}/${type}");
    List<CommentEntity> commentList = [];
    if (commentResponse?.data?.toString()?.isNotEmpty == true) {
      List<dynamic> dataList = commentResponse?.data["items"];
      dataList?.forEach((element) {
        commentList.add(CommentEntity.fromJson(element));
      });
    }

    return Future.value(commentList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        leading: Container(
          child: Image.asset("images/icon_dgtle.png"),
          padding: EdgeInsets.only(left: 10),
        ),
        leadingWidth: 110,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avatarView(),
            Container(
              child: ValueListenableBuilder<ArticleDetailContentEntity>(
                  valueListenable: _detailNotice,
                  builder: (context, data, widget) {
                    return data != null
                        ? HtmlWidget(
                            "${data.content}",
                            webView: true,
                            textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400, height: 1.8),
                            onTapImage: (imageData) {
                              Navigator.push(context, Transition(child: GalleryPhotoViewWrapper(
                                              galleryItems: imageData.sources.map((e) => e.url).toList(),
                                              initialIndex: 0,
                                              backgroundDecoration: BoxDecoration(color: Colors.black)))
                                      .builder());
                            },
                          )
                        : Container();
                  }),
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            ),
            galleryView(),
            Container(
                child: Text("最新评论", style: TextStyle(color: Color(0xFF222222), fontSize: 16, fontWeight: FontWeight.w500)),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12)),
            commentView(),
            Container(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget avatarView() {
    return ValueListenableBuilder(
        valueListenable: _detailNotice,
        builder: (context, data, child) {
          return data != null
              ? Container(
                  child: ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage("${data?.author?.avatar_path ?? "$defaultImageUrl"}")),
                      title: Text("${data?.author?.username ?? ""}", style: TextStyle(color: Colors.black45, fontSize: 14)),
                      subtitle: Text("${data?.relativeTime ?? ""}来自${data?.tel_type ?? "小霸王学习机"}", style: TextStyle(color: Colors.black45, fontSize: 13)),
                      trailing: Container(
                        height: 28,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Color(0xFF67abff))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.add,
                              color: Color(0xFF67abff),
                              size: 14,
                            ),
                            Text("关注", style: TextStyle(color: Color(0xFF67abff), fontSize: 12))
                          ],
                        ),
                      )),
                )
              : Container();
        });
  }

  Widget galleryView() {
    return ValueListenableBuilder<ArticleDetailContentEntity>(
        valueListenable: _detailNotice,
        builder: (context, data, child) {
          return data != null && data.imgs_url?.isNotEmpty == true
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ValueListenableBuilder<ArticleDetailContentEntity>(
                      valueListenable: _detailNotice,
                      builder: (context, data, child) {
                        return data != null
                            ? GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 3),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            Transition(
                                                child: GalleryPhotoViewWrapper(
                                              galleryItems: data.imgs_url?.map((e) => e.path)?.toList(),
                                              initialIndex: index,
                                              backgroundDecoration: BoxDecoration(color: Colors.black),
                                            )).builder());
                                      },
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(3),
                                          child: ProgressiveImage(
                                            fit: BoxFit.cover,
                                            placeholder: NetworkImage("${data.imgs_url[index]?.path}"),
                                            thumbnail: NetworkImage("${data.imgs_url[index]?.path}"),
                                            image: NetworkImage("${data.imgs_url[index]?.path}"),
                                            height: 200,
                                            width: 200,
                                          )));

                                  /*CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "${data.imgs_url[index]?.path}",
                              errorWidget: (context, url, error) => Image.asset("images/icon_loading_image.png"))));
*/
                                },
                                itemCount: data.imgs_url?.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              )
                            : Container();
                      }))
              : Container();
        });
  }

  Widget commentView() {
    return FutureBuilder<List<CommentEntity>>(
      builder: (context, snapshot) {
        return snapshot.hasData && snapshot.data?.isNotEmpty == true
            ? ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.black12,
                    indent: 70,
                  );
                },
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      dense: true,
                      leading: SizedBox(
                          height: 40,
                          width: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: "${snapshot.data[index]?.author?.avatar_path ?? ""}",
                              errorWidget: (context, url, error) => Image.network(defaultImageUrl),
                              fit: BoxFit.cover,
                            ),
                          )

                          /*CircleAvatar(
              backgroundImage: NetworkImage("${_commentList[index]?.author?.avatar_path ?? ""}"),
            ),*/
                          ),
                      title: Text(
                        "${snapshot.data[index]?.author?.username}",
                        style: TextStyle(color: Color(0xFF888888), fontSize: 12),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 3)),
                          Text(
                            "${snapshot.data[index]?.relativeTime}",
                            style: TextStyle(color: Colors.black38, fontSize: 10),
                          ),
                          Padding(padding: EdgeInsets.only(top: 3)),
                          Text(
                            "${snapshot.data[index]?.content ?? ""}",
                            style: TextStyle(color: Color(0xFF333333), fontSize: 14, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              )
            : Container();
      },
      future: getComment(),
    );
  }
}
