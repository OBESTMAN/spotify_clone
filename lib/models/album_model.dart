class AlbumModel {
  final String id;
  final String title;
  final String artistName;
  final String coverUrl;
  final String releaseYear;

  AlbumModel({
    required this.id,
    required this.title,
    required this.artistName,
    required this.coverUrl,
    required this.releaseYear,
  });

  // Factory method to create an instance from a JSON map
  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'] as String,
      title: json['title'] as String,
      artistName: json['artistName'] as String,
      coverUrl: json['coverUrl'] ?? '', // Fallback if null
      releaseYear: json['releaseYear'] ?? 'Unknown', // Fallback if null
    );
  }
}
