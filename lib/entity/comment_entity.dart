class CommentEntity {
    int aid;
    Author author;
    String content;
    String content_format;
    int height;
    int id;
    int is_like;
    int liketimes;
    int parent_id;
    String path;
    String relativeTime;
    List<Reply> reply;
    int reply_id;
    int self;
    int status;
    String to_uid;
    String totalReply;
    int updated_at;
    String user_id;
    int width;

    CommentEntity({this.aid, this.author, this.content, this.content_format, this.height, this.id, this.is_like, this.liketimes, this.parent_id, this.path, this.relativeTime, this.reply, this.reply_id, this.self, this.status, this.to_uid, this.totalReply, this.updated_at, this.user_id, this.width});

    factory CommentEntity.fromJson(Map<String, dynamic> json) {
        return CommentEntity(
            aid: json['aid'],
            author: json['author'] != null ? Author.fromJson(json['author']) : null,
            content: json['content'],
            content_format: json['content_format'],
            height: json['height'],
            id: json['id'],
            is_like: json['is_like'],
            liketimes: json['liketimes'],
            parent_id: json['parent_id'],
            path: json['path'],
            relativeTime: json['relativeTime'],
            reply: json['reply'] != null ? (json['reply'] as List).map((i) => Reply.fromJson(i)).toList() : null,
            reply_id: json['reply_id'],
            self: json['self'],
            status: json['status'],
            to_uid: json['to_uid'],
            totalReply: "${json['totalReply']}",
            updated_at: json['updated_at'],
            user_id: json['user_id'],
            width: json['width'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['aid'] = this.aid;
        data['content'] = this.content;
        data['content_format'] = this.content_format;
        data['height'] = this.height;
        data['id'] = this.id;
        data['is_like'] = this.is_like;
        data['liketimes'] = this.liketimes;
        data['parent_id'] = this.parent_id;
        data['path'] = this.path;
        data['relativeTime'] = this.relativeTime;
        data['reply_id'] = this.reply_id;
        data['self'] = this.self;
        data['status'] = this.status;
        data['to_uid'] = this.to_uid;
        data['totalReply'] = this.totalReply;
        data['updated_at'] = this.updated_at;
        data['user_id'] = this.user_id;
        data['width'] = this.width;
        if (this.author != null) {
            data['author'] = this.author.toJson();
        }

        if (this.reply != null) {
            data['reply'] = this.reply.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Reply {
    int aid;
    AuthorX author;
    String content;
    String content_format;
    int height;
    int id;
    int is_like;
    int liketimes;
    int parent_id;
    String path;
    int quote_id;
    String relativeTime;
    int reply_id;
    int status;
    String to_uid;
    //String touser;
    int updated_at;
    String user_id;
    int width;

    Reply({this.aid, this.author, this.content, this.content_format, this.height, this.id, this.is_like, this.liketimes, this.parent_id, this.path, this.quote_id, this.relativeTime, this.reply_id, this.status, this.to_uid, this.updated_at, this.user_id, this.width});

    factory Reply.fromJson(Map<String, dynamic> json) {
        return Reply(
            aid: json['aid'],
            author: json['author'] != null ? AuthorX.fromJson(json['author']) : null,
            content: json['content'],
            content_format: json['content_format'],
            height: json['height'],
            id: json['id'],
            is_like: json['is_like'],
            liketimes: json['liketimes'],
            parent_id: json['parent_id'],
            path: json['path'],
            quote_id: json['quote_id'],
            relativeTime: json['relativeTime'],
            reply_id: json['reply_id'],
            status: json['status'],
            to_uid: json['to_uid'],
            updated_at: json['updated_at'],
            user_id: json['user_id'],
            width: json['width'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['aid'] = this.aid;
        data['content'] = this.content;
        data['content_format'] = this.content_format;
        data['height'] = this.height;
        data['id'] = this.id;
        data['is_like'] = this.is_like;
        data['liketimes'] = this.liketimes;
        data['parent_id'] = this.parent_id;
        data['path'] = this.path;
        data['quote_id'] = this.quote_id;
        data['relativeTime'] = this.relativeTime;
        data['reply_id'] = this.reply_id;
        data['status'] = this.status;
        data['to_uid'] = this.to_uid;
        data['updated_at'] = this.updated_at;
        data['user_id'] = this.user_id;
        data['width'] = this.width;
        if (this.author != null) {
            data['author'] = this.author.toJson();
        }

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
            identification_title: json['identification_title'] != null ? json['identification_title']: "",
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

class AuthorX {
    String avatar_path;
    int group;
    String id;
    int identification;
    Object identification_title;
    String introduce;
    List<Object> user_auth_rule;
    String username;

    AuthorX({this.avatar_path, this.group, this.id, this.identification, this.identification_title, this.introduce, this.user_auth_rule, this.username});

    factory AuthorX.fromJson(Map<String, dynamic> json) {
        return AuthorX(
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