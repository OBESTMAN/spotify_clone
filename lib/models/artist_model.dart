class ArtistModel {
  final String name;
  final String imageUrl;

  ArtistModel({
    required this.name,
    required this.imageUrl,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      name: json['name'],
      imageUrl: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['url']
          : null, // Provide a default value if no image is available
    );
  }
}
