class UserInfoEntity {
    String author_desc;
    String avatar_large;
    String company;
    String description;
    int got_digg_count;
    int got_view_count;
    bool isfollowed;
    String job_title;
    int level;
    String user_id;
    String user_name;

    UserInfoEntity({this.author_desc, this.avatar_large, this.company, this.description, this.got_digg_count, this.got_view_count, this.isfollowed, this.job_title, this.level, this.user_id, this.user_name});

    factory UserInfoEntity.fromJson(Map<String, dynamic> json) {
        return UserInfoEntity(
            author_desc: json['author_desc'],
            avatar_large: json['avatar_large'],
            company: json['company'],
            description: json['description'],
            got_digg_count: json['got_digg_count'],
            got_view_count: json['got_view_count'],
            isfollowed: json['isfollowed'],
            job_title: json['job_title'],
            level: json['level'],
            user_id: json['user_id'],
            user_name: json['user_name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['author_desc'] = this.author_desc;
        data['avatar_large'] = this.avatar_large;
        data['company'] = this.company;
        data['description'] = this.description;
        data['got_digg_count'] = this.got_digg_count;
        data['got_view_count'] = this.got_view_count;
        data['isfollowed'] = this.isfollowed;
        data['job_title'] = this.job_title;
        data['level'] = this.level;
        data['user_id'] = this.user_id;
        data['user_name'] = this.user_name;
        return data;
    }
}