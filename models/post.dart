class Post {
  int? id;
  String? slug;
  String? url;
  String? title;
  String? content;
  String? image;
  String? thumbnail;
  String? status;
  String? category;
  String? publishedAt;
  String? updatedAt;
  int? userId;

  Post(
      {this.id,
      this.slug,
      this.url,
      this.title,
      this.content,
      this.image,
      this.thumbnail,
      this.status,
      this.category,
      this.publishedAt,
      this.updatedAt,
      this.userId});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    url = json['url'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    status = json['status'];
    category = json['category'];
    publishedAt = json['publishedAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['url'] = this.url;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['thumbnail'] = this.thumbnail;
    data['status'] = this.status;
    data['category'] = this.category;
    data['publishedAt'] = this.publishedAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    return data;
  }
}