class ArticleDetailContentEntity {
    Author author;
    int category_id;
    int commentnum;
    String content;
    String content_format;
    int created_at;
    int digest;
    int favtimes;
    int id;
    List<ImgsUrl> imgs_url;
    int ins_type;
    int is_favourite;
    int is_focus;
    int is_like;
    int liketimes;
    String link;
    int push_at;
    int pushed;
    int quoted;
    int quoted_id;
    int quoted_type;
    int quoted_uid;
    int recommend;
    String relativeTime;
    int shared;
    int status;
    List<TagId> tag_id;
    String tel_type;
    String title;
    int top;
    int updated_at;
    int viewnum;

    ArticleDetailContentEntity({this.author, this.category_id, this.commentnum, this.content, this.content_format, this.created_at, this.digest,  this.favtimes, this.id, this.imgs_url, this.ins_type, this.is_favourite, this.is_focus, this.is_like, this.liketimes, this.link, this.push_at, this.pushed, this.quoted, this.quoted_id, this.quoted_type, this.quoted_uid, this.recommend, this.relativeTime, this.shared, this.status, this.tag_id, this.tel_type, this.title, this.top, this.updated_at, this.viewnum});

    factory ArticleDetailContentEntity.fromJson(Map<String, dynamic> json) {
        return ArticleDetailContentEntity(
            author: json['author'] != null ? Author.fromJson(json['author']) : null,
            category_id: json['category_id'],
            commentnum: json['commentnum'],
            content: json['content'],
            content_format: json['content_format'],
            created_at: json['created_at'],
            digest: json['digest'],
            favtimes: json['favtimes'],
            id: json['id'],
            imgs_url: json['imgs_url'] != null ? json["imgs_url"] is String ? []: (json['imgs_url'] as List).map((i) => ImgsUrl.fromJson(i)).toList() : null,
            ins_type: json['ins_type'],
            is_favourite: json['is_favourite'],
            is_focus: json['is_focus'],
            is_like: json['is_like'],
            liketimes: json['liketimes'],
            link: json['link'],
            push_at: json['push_at'],
            pushed: json['pushed'],
            quoted: json['quoted'],
            quoted_id: json['quoted_id'],
            quoted_type: json['quoted_type'],
            quoted_uid: json['quoted_uid'],
            recommend: json['recommend'],
            relativeTime: json['relativeTime'],
            shared: json['shared'],
            status: json['status'],
            tag_id: json['tag_id'] != null ? json['tag_id'] is String ? [] : (json['tag_id'] as List).map((i) => TagId.fromJson(i)).toList() : null,
            tel_type: json['tel_type'],
            title: json['title'] != null ? json['title'] : "",
            top: json['top'],
            updated_at: json['updated_at'],
            viewnum: json['viewnum'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category_id'] = this.category_id;
        data['commentnum'] = this.commentnum;
        data['content'] = this.content;
        data['content_format'] = this.content_format;
        data['created_at'] = this.created_at;
        data['digest'] = this.digest;
        data['favtimes'] = this.favtimes;
        data['id'] = this.id;
        data['ins_type'] = this.ins_type;
        data['is_favourite'] = this.is_favourite;
        data['is_focus'] = this.is_focus;
        data['is_like'] = this.is_like;
        data['liketimes'] = this.liketimes;
        data['link'] = this.link;
        data['push_at'] = this.push_at;
        data['pushed'] = this.pushed;
        data['quoted'] = this.quoted;
        data['quoted_id'] = this.quoted_id;
        data['quoted_type'] = this.quoted_type;
        data['quoted_uid'] = this.quoted_uid;
        data['recommend'] = this.recommend;
        data['relativeTime'] = this.relativeTime;
        data['shared'] = this.shared;
        data['status'] = this.status;
        data['tel_type'] = this.tel_type;
        data['top'] = this.top;
        data['updated_at'] = this.updated_at;
        data['viewnum'] = this.viewnum;
        if (this.author != null) {
            data['author'] = this.author.toJson();
        }

        if (this.imgs_url != null) {
            data['imgs_url'] = this.imgs_url.map((v) => v.toJson()).toList();
        }

        if (this.tag_id != null) {
            data['tag_id'] = this.tag_id.map((v) => v.toJson()).toList();
        }
        if (this.title != null) {
            data['title'] = this.title;
        }
        return data;
    }
}

class TagId {
    int catalog_id;
    String icon;
    int id;
    String title;

    TagId({this.catalog_id, this.icon, this.id, this.title});

    factory TagId.fromJson(Map<String, dynamic> json) {
        return TagId(
            catalog_id: json['catalog_id'],
            icon: json['icon'],
            id: json['id'],
            title: json['title'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['catalog_id'] = this.catalog_id;
        data['icon'] = this.icon;
        data['id'] = this.id;
        data['title'] = this.title;
        return data;
    }
}

class Author {
    String avatar_path;
    int group;
    String id;
    int identification;
    String identification_title;
    String introduce;
    List<String> user_auth_rule;
    String username;

    Author({this.avatar_path, this.group, this.id, this.identification, this.identification_title, this.introduce, this.user_auth_rule, this.username});

    factory Author.fromJson(Map<String, dynamic> json) {
        return Author(
            avatar_path: json['avatar_path'],
            group: json['group'],
            id: json['id'],
            identification: json['identification'],
            identification_title: json['identification_title'] != null ? json['identification_title'] : "",
            introduce: json['introduce'],
            user_auth_rule: json['user_auth_rule'] != null ? (json['user_auth_rule'] as List).map((i) => i.toString()).toList() : null,
            username: json['username'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['avatar_path'] = this.avatar_path;
        data['group'] = this.group;
        data['id'] = this.id;
        data['identification'] = this.identification;
        data['introduce'] = this.introduce;
        data['username'] = this.username;
        if (this.identification_title != null) {
            data['identification_title'] = this.identification_title;
        }
        if (this.user_auth_rule != null) {
            data['user_auth_rule'] = this.user_auth_rule.map((v) => v.toString()).toList();
        }
        return data;
    }
}

class ImgsUrl {
    int height;
    int id;
    String path;
    int width;

    ImgsUrl({this.height, this.id, this.path, this.width});

    factory ImgsUrl.fromJson(Map<String, dynamic> json) {
        return ImgsUrl(
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