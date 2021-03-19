class BannerEntity {
  String id;
  String aid;
  int carousel_id;
  int close_at;
  String cover;
  int created_at;
  int order;
  int send_at;
  String summary;
  String title;
  String type;
  int updated_at;

  BannerEntity(
      {this.id,
      this.aid,
      this.carousel_id,
      this.close_at,
      this.cover,
      this.created_at,
      this.order,
      this.send_at,
      this.summary,
      this.title,
      this.type,
      this.updated_at});

  factory BannerEntity.fromJson(Map<String, dynamic> json) {
    return BannerEntity(
      id: json['_id'],
      aid: json['aid'],
      carousel_id: json['carousel_id'],
      close_at: json['close_at'],
      cover: json['cover'],
      created_at: json['created_at'],
      order: json['order'],
      send_at: json['send_at'],
      summary: json['summary'],
      title: json['title'],
      type: json['type'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['aid'] = this.aid;
    data['carousel_id'] = this.carousel_id;
    data['close_at'] = this.close_at;
    data['cover'] = this.cover;
    data['created_at'] = this.created_at;
    data['order'] = this.order;
    data['send_at'] = this.send_at;
    data['summary'] = this.summary;
    data['title'] = this.title;
    data['type'] = this.type;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
