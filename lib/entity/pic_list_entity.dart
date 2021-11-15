
import 'article_detail_content_entity.dart';

/// 创建时间：2021/11/15 
/// 作者：wliang
/// 描述：

class PicListEntity {
    int aid;
    List<Aid> aid_list;
    Attachment attachment;
    Author author;
    int category_id;
    int commentnum;
    String content;
    int created_at;
    int digest;
    int downnum;
    int favtimes;
    int id;
    int is_favourite;
    int is_like;
    int is_self;
    int liketimes;
    int pic_num;
    int recommend;
    int status;
    int tag_id;
    Type type;
    int updated_at;
    String user_id;
    int viewnum;

    PicListEntity({this.aid, this.aid_list, this.attachment, this.author, this.category_id, this.commentnum, this.content, this.created_at, this.digest, this.downnum, this.favtimes, this.id, this.is_favourite, this.is_like, this.is_self, this.liketimes, this.pic_num, this.recommend, this.status, this.tag_id, this.type, this.updated_at, this.user_id, this.viewnum});

    factory PicListEntity.fromJson(Map<String, dynamic> json) {
        return PicListEntity(
            aid: json['aid'],
            aid_list: json['aid_list'] != null ? (json['aid_list'] as List).map((i) => Aid.fromJson(i)).toList() : null,
            attachment: json['attachment'] != null ? Attachment.fromJson(json['attachment']) : null,
            author: json['author'] != null ? Author.fromJson(json['author']) : null,
            category_id: json['category_id'],
            commentnum: json['commentnum'],
            content: json['content'],
            created_at: json['created_at'],
            digest: json['digest'],
            downnum: json['downnum'],
            favtimes: json['favtimes'],
            id: json['id'],
            is_favourite: json['is_favourite'],
            is_like: json['is_like'],
            is_self: json['is_self'],
            liketimes: json['liketimes'],
            pic_num: json['pic_num'],
            recommend: json['recommend'],
            status: json['status'],
            tag_id: json['tag_id'],
            type: json['type'] != null ? Type.fromJson(json['type']) : null,
            updated_at: json['updated_at'],
            user_id: json['user_id'],
            viewnum: json['viewnum'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['aid'] = this.aid;
        data['category_id'] = this.category_id;
        data['commentnum'] = this.commentnum;
        data['content'] = this.content;
        data['created_at'] = this.created_at;
        data['digest'] = this.digest;
        data['downnum'] = this.downnum;
        data['favtimes'] = this.favtimes;
        data['id'] = this.id;
        data['is_favourite'] = this.is_favourite;
        data['is_like'] = this.is_like;
        data['is_self'] = this.is_self;
        data['liketimes'] = this.liketimes;
        data['pic_num'] = this.pic_num;
        data['recommend'] = this.recommend;
        data['status'] = this.status;
        data['tag_id'] = this.tag_id;
        data['updated_at'] = this.updated_at;
        data['user_id'] = this.user_id;
        data['viewnum'] = this.viewnum;
        if (this.aid_list != null) {
            data['aid_list'] = this.aid_list.map((v) => v.toJson()).toList();
        }
        if (this.attachment != null) {
            data['attachment'] = this.attachment.toJson();
        }
        if (this.author != null) {
            data['author'] = this.author.toJson();
        }
        if (this.type != null) {
            data['type'] = this.type.toJson();
        }
        return data;
    }
}

class Aid {
    int height;
    int id;
    String pic_url;
    int width;

    Aid({this.height, this.id, this.pic_url, this.width});

    factory Aid.fromJson(Map<String, dynamic> json) {
        return Aid(
            height: json['height'],
            id: json['id'],
            pic_url: json['pic_url'],
            width: json['width'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['height'] = this.height;
        data['id'] = this.id;
        data['pic_url'] = this.pic_url;
        data['width'] = this.width;
        return data;
    }
}

class Attachment {
    int height;
    int id;
    String pic_url;
    int width;

    Attachment({this.height, this.id, this.pic_url, this.width});

    factory Attachment.fromJson(Map<String, dynamic> json) {
        return Attachment(
            height: json['height'],
            id: json['id'],
            pic_url: json['pic_url'],
            width: json['width'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['height'] = this.height;
        data['id'] = this.id;
        data['pic_url'] = this.pic_url;
        data['width'] = this.width;
        return data;
    }
}


class Type {
    String cate_name;
    String icon;
    int id;
    int order;
    int status;
    int tag_id;

    Type({this.cate_name, this.icon, this.id, this.order, this.status, this.tag_id});

    factory Type.fromJson(Map<String, dynamic> json) {
        return Type(
            cate_name: json['cate_name'],
            icon: json['icon']??"",
            id: json['id'],
            order: json['order'],
            status: json['status'],
            tag_id: json['tag_id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cate_name'] = this.cate_name;
        data['id'] = this.id;
        data['order'] = this.order;
        data['status'] = this.status;
        data['tag_id'] = this.tag_id;
        if (this.icon != null) {
            data['icon'] = this.icon;
        }
        return data;
    }
}