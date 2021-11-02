
import 'article_detail_content_entity.dart';

/// 创建时间：2021/11/2 
/// 作者：wliang
/// 描述：

class IdleDetailEntity {
    String consPrice;
    String address;
    String freight;
    Author author;
    int category_id;
    int commentnum;
    String content;
    String cover;
    int digest;
    int favtimes;
    int id;
    List<Img> img;
    List<String> imgs_url;
    int is_focus;
    int is_self;
    int liketimes;
    String price;
    int product_id;
    int quality;
    String relativeTime;
    int status;
    String tag_id;
    String title;
    int updated_at;
    int viewnum;

    IdleDetailEntity({this.consPrice, this.address, this.freight , this.author, this.category_id, this.commentnum, this.content, this.cover, this.digest, this.favtimes, this.id, this.img, this.imgs_url, this.is_focus, this.is_self, this.liketimes, this.price, this.product_id, this.quality, this.relativeTime, this.status, this.tag_id, this.title, this.updated_at, this.viewnum});

    factory IdleDetailEntity.fromJson(Map<String, dynamic> json) {
        return IdleDetailEntity(
            consPrice: json['const'],
            address: json['address'],
            author: json['author'] != null ? Author.fromJson(json['author']) : null,
            category_id: json['category_id'],
            commentnum: json['commentnum'],
            content: json['content'],
            cover: json['cover'],
            digest: json['digest'],
            favtimes: json['favtimes'],
            id: json['id'],
            img: json['img'] != null ? (json['img'] as List).map((i) => Img.fromJson(i)).toList() : null,
            imgs_url: json['imgs_url'] != null ? new List<String>.from(json['imgs_url']) : null,
            is_focus: json['is_focus'],
            is_self: json['is_self'],
            liketimes: json['liketimes'],
            price: json['price'],
            product_id: json['product_id'],
            quality: json['quality'],
            relativeTime: json['relativeTime'],
            status: json['status'],
            tag_id: json['tag_id'],
            title: json['title'],
            updated_at: json['updated_at'],
            viewnum: json['viewnum'],
            freight: json['freight']
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['consPrice'] = this.consPrice;
        data['address'] = this.address;
        data['category_id'] = this.category_id;
        data['commentnum'] = this.commentnum;
        data['content'] = this.content;
        data['cover'] = this.cover;
        data['digest'] = this.digest;
        data['favtimes'] = this.favtimes;
        data['id'] = this.id;
        data['is_focus'] = this.is_focus;
        data['is_self'] = this.is_self;
        data['liketimes'] = this.liketimes;
        data['price'] = this.price;
        data['product_id'] = this.product_id;
        data['quality'] = this.quality;
        data['relativeTime'] = this.relativeTime;
        data['status'] = this.status;
        data['tag_id'] = this.tag_id;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        data['viewnum'] = this.viewnum;
        if (this.author != null) {
            data['author'] = this.author.toJson();
        }
        if (this.img != null) {
            data['img'] = this.img.map((v) => v.toJson()).toList();
        }
        if (this.imgs_url != null) {
            data['imgs_url'] = this.imgs_url;
        }
        data['freight'] = this.freight;
        return data;
    }
}

class Img {
    int height;
    int id;
    String path;
    int width;

    Img({this.height, this.id, this.path, this.width});

    factory Img.fromJson(Map<String, dynamic> json) {
        return Img(
            height: json['height'],
            id: json['id'],
            path: json['path'],
            width: json['width'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['height'] = this.height;
        data['id'] = this.id;
        data['path'] = this.path;
        data['width'] = this.width;
        return data;
    }
}
