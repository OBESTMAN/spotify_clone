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
    // Extract artist names as a comma-separated string
    final List<dynamic> artists = json['artists'] ?? [];
    final String artistName = artists.isNotEmpty
        ? artists.map((artist) => artist['name']).join(', ')
        : 'Unknown Artist';

    // Extract the release year
    final String releaseDate = json['release_date'] ?? 'Unknown';
    final String releaseYear =
    releaseDate.length >= 4 ? releaseDate.substring(0, 4) : 'Unknown';

    return AlbumModel(
      id: json['id'] as String,
      title: json['name'] as String,
      artistName: artistName,
      coverUrl: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]['url']
          : '', // Fallback to empty string if no images are available
      releaseYear: releaseYear,
    );
  }
}
