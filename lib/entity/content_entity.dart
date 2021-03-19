class ContentEntity {
    String id;
    int agree_num;
    String aid;
    Author author;
    int close_at;
    String commentnum;
    String cover;
    int created_at;
    int disagree_num;
    List<String> imgs_url;
    int is_like;
    String liketimes;
    String membernum;
    int order;
    String relativeTime;
    int send_at;
    String summary;
    String summary_smiley;
    String title;
    String type;
    String url;

    ContentEntity({this.id, this.agree_num, this.aid, this.author, this.close_at, this.commentnum, this.cover, this.created_at, this.disagree_num, this.imgs_url, this.is_like, this.liketimes, this.membernum, this.order, this.relativeTime, this.send_at, this.summary, this.summary_smiley, this.title, this.type, this.url});

    factory ContentEntity.fromJson(Map<String, dynamic> json) {
        return ContentEntity(
            id: json['_id'],
            agree_num: json['agree_num'],
            aid: "${json['aid']}",
            author: json['author'] != null ? Author.fromJson(json['author']) : null,
            close_at: json['close_at'],
            commentnum: "${json['commentnum']}",
            cover: json['cover'] != null ? json['cover'] : null,
            created_at: json['created_at'],
            disagree_num: json['disagree_num'],
            imgs_url: json['imgs_url'] != null ? new List<String>.from(json['imgs_url']) : [],
            is_like: json['is_like'],
            liketimes: "${json['liketimes']}",
            membernum: "${json['membernum']}",
            order: json['order'],
            relativeTime: json['relativeTime'],
            send_at: json['send_at'],
            summary: json['summary'],
            summary_smiley: json['summary_smiley'],
            title: json['title'],
            type: "${json['type']}",
            url: json['url'] != null ? json['url'] : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['agree_num'] = this.agree_num;
        data['aid'] = this.aid;
        data['close_at'] = this.close_at;
        data['commentnum'] = this.commentnum;
        data['created_at'] = this.created_at;
        data['disagree_num'] = this.disagree_num;
        data['is_like'] = this.is_like;
        data['liketimes'] = this.liketimes;
        data['membernum'] = this.membernum;
        data['order'] = this.order;
        data['relativeTime'] = this.relativeTime;
        data['send_at'] = this.send_at;
        data['summary'] = this.summary;
        data['summary_smiley'] = this.summary_smiley;
        data['title'] = this.title;
        data['type'] = this.type;
        if (this.author != null) {
            data['author'] = this.author.toJson();
        }
        if (this.cover != null) {
            data['cover'] = this.cover;
        }

        if (this.imgs_url != null) {
            data['imgs_url'] = this.imgs_url;
        }
        if (this.url != null) {
            data['url'] = this.url;
        }
        return data;
    }
}

class Author {
    String avatar_path;
    int group;
    String id;
    String identification;
    String identification_title;
    String introduce;
    List<String> user_auth_rule;
    String username;

    Author({this.avatar_path, this.group, this.id, this.identification, this.identification_title, this.introduce, this.user_auth_rule, this.username});

    factory Author.fromJson(Map<String, dynamic> json) {
        return Author(
            avatar_path: json['avatar_path'],
            group: json['group'],
            id: "${json['id']}",
            identification: "${json['identification']}",
            identification_title: json['identification_title'],
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
        data['identification_title'] = this.identification_title;
        data['introduce'] = this.introduce;
        data['username'] = this.username;
        if (this.user_auth_rule != null) {
            data['user_auth_rule'] = this.user_auth_rule.map((v) => v?.toString()).toList();
        }
        return data;
    }
}