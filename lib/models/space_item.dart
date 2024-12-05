class SpaceItem {
  final int id;
  final String title;
  final String summary;
  final String url;
  final String imageUrl;
  final String publishedAt;

  SpaceItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
  });

  factory SpaceItem.fromJson(Map<String, dynamic> json) {
    return SpaceItem(
      id: json['id'],
      title: json['title'],
      summary: json['summary'],
      url: json['url'],
      imageUrl: json['image_url'] ?? '',
      publishedAt: json['published_at'],
    );
  }

  get source => null;
}
