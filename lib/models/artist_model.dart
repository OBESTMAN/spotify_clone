class ArtistModel {
  final String id;
  final String name;
  final String profileImageUrl;

  ArtistModel({
    required this.id,
    required this.name,
    required this.profileImageUrl,
  });

  // Factory method to create an instance from a JSON map
  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] ?? '', // Fallback if null
    );
  }
}
