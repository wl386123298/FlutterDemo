class IdleEntity {
    String address;
    Author author;
    String cover;
    int id;
    int is_like;
    String price;
    String relativeTime;
    String title;

    IdleEntity({this.address, this.author, this.cover, this.id, this.is_like, this.price, this.relativeTime, this.title});

    factory IdleEntity.fromJson(Map<String, dynamic> json) {
        return IdleEntity(
            address: json['address'],
            author: json['author'] != null ? Author.fromJson(json['author']) : null,
            cover: json['cover'],
            id: json['id'],
            is_like: json['is_like'],
            price: json['price'],
            relativeTime: json['relativeTime'],
            title: json['title'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['cover'] = this.cover;
        data['id'] = this.id;
        data['is_like'] = this.is_like;
        data['price'] = this.price;
        data['relativeTime'] = this.relativeTime;
        data['title'] = this.title;
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
    List<dynamic> user_auth_rule;
    String username;

    Author({this.avatar_path, this.group, this.id, this.identification, this.identification_title, this.introduce, this.user_auth_rule, this.username});

    factory Author.fromJson(Map<String, dynamic> json) {
        return Author(
            avatar_path: json['avatar_path'],
            group: json['group'],
            id: json['id'],
            identification: json['identification'],
            identification_title: json['identification_title'],
            introduce: json['introduce'],
            user_auth_rule: json['user_auth_rule'] != null ? (json['user_auth_rule'] as List).map((i) => i).toList() : null,
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
            data['user_auth_rule'] = this.user_auth_rule.map((v) => v.toJson()).toList();
        }
        return data;
    }
}