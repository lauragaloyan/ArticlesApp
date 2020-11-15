class Article {
  final int id;
  final String userName;
  final int elapsedTimeInHour;
  final bool isBookmarked;
  final String userImage;
  final String title;
  final String description;
  final List<String> images;

  Article(
      {this.id,
      this.userName,
      this.elapsedTimeInHour,
      this.isBookmarked,
      this.userImage,
      this.title,
      this.description,
      this.images});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      userName: json['userName'] as String,
      elapsedTimeInHour: json['elapsedTimeInHour'] as int,
      isBookmarked: json['bookmarked'],
      userImage: json['userImage'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userName': userName,
        'elapsedTimeInHour': elapsedTimeInHour,
        'bookmarked': isBookmarked,
        'userImage': userImage,
        'title': title,
        'description': description,
        'images': images
      };
}
