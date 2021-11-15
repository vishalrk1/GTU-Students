class HomeCategory {
  // final String id;
  final String title;
  final String imgLink;
  final String webLink;

  const HomeCategory({
    // required this.id,
    required this.title,
    required this.imgLink,
    required this.webLink,
  });

  factory HomeCategory.fromJson(Map<String, dynamic> json) {
    return HomeCategory(
      title: json['name'],
      imgLink: json['imageUrl'],
      webLink: json['link'],
    );
  }
}
