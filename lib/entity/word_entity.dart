class WordEntity {
    int audit;
    String cate_name;
    int category_id;
    String column_id;
    int commentnum;
    String content;
    String cover;
    int created_at;
    int digest;
    int favtimes;
    String from;
    int id;
    String img_source;
    String imgs_url;
    int is_like;
    int liketimes;
    String num;
    int push_at;
    int pushed;
    int recommend;
    String relativeTime;
    int status;
    String tag_id;
    String title;
    String unit;
    int updated_at;
    int viewnum;

    WordEntity({this.audit, this.cate_name, this.category_id, this.column_id, this.commentnum, this.content, this.cover, this.created_at, this.digest, this.favtimes, this.from, this.id, this.img_source, this.imgs_url, this.is_like, this.liketimes, this.num, this.push_at, this.pushed, this.recommend, this.relativeTime, this.status, this.tag_id, this.title, this.unit, this.updated_at, this.viewnum});

    factory WordEntity.fromJson(Map<String, dynamic> json) {
        return WordEntity(
            audit: json['audit'],
            cate_name: json['cate_name'],
            category_id: json['category_id'],
            column_id: json['column_id'],
            commentnum: json['commentnum'],
            content: json['content'],
            cover: json['cover'],
            created_at: json['created_at'],
            digest: json['digest'],
            favtimes: json['favtimes'],
            from: json['from'],
            id: json['id'],
            img_source: json['img_source'],
            imgs_url: json['imgs_url'],
            is_like: json['is_like'],
            liketimes: json['liketimes'],
            num: json['num'],
            push_at: json['push_at'],
            pushed: json['pushed'],
            recommend: json['recommend'],
            relativeTime: json['relativeTime'],
            status: json['status'],
            tag_id: json['tag_id'],
            title: json['title'],
            unit: json['unit'],
            updated_at: json['updated_at'],
            viewnum: json['viewnum'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['audit'] = this.audit;
        data['cate_name'] = this.cate_name;
        data['category_id'] = this.category_id;
        data['column_id'] = this.column_id;
        data['commentnum'] = this.commentnum;
        data['content'] = this.content;
        data['cover'] = this.cover;
        data['created_at'] = this.created_at;
        data['digest'] = this.digest;
        data['favtimes'] = this.favtimes;
        data['from'] = this.from;
        data['id'] = this.id;
        data['img_source'] = this.img_source;
        data['imgs_url'] = this.imgs_url;
        data['is_like'] = this.is_like;
        data['liketimes'] = this.liketimes;
        data['num'] = this.num;
        data['push_at'] = this.push_at;
        data['pushed'] = this.pushed;
        data['recommend'] = this.recommend;
        data['relativeTime'] = this.relativeTime;
        data['status'] = this.status;
        data['tag_id'] = this.tag_id;
        data['title'] = this.title;
        data['unit'] = this.unit;
        data['updated_at'] = this.updated_at;
        data['viewnum'] = this.viewnum;
        return data;
    }
}