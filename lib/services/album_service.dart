// Album Service
import 'dart:convert';

import 'package:spotify_clone/models/album_model.dart';
import 'package:http/http.dart' as http;

class AlbumService {
  final String _clientId = '3af8e17840684c5bb3325a5e8b8e808d';
  final String _clientSecret = 'e46b037b7f76416ca7e3ac9676f557f7';

  String? _accessToken;
  DateTime? _tokenExpiration;

  Future<String> _getAccessToken() async {
    // Check if we have a valid token
    if (_accessToken != null && _tokenExpiration != null &&
        DateTime.now().isBefore(_tokenExpiration!)) {
      return _accessToken!;
    }

    try {
      // Request new access token
      final String basicAuth =
      base64Encode(utf8.encode('$_clientId:$_clientSecret'));

      final response = await http.post(
          Uri.parse('https://accounts.spotify.com/api/token'),
          headers: {
            'Authorization': 'Basic $basicAuth',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: {'grant_type': 'client_credentials'}
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> tokenData = json.decode(response.body);
        _accessToken = tokenData['access_token'];
        _tokenExpiration = DateTime.now().add(
            Duration(seconds: tokenData['expires_in'])
        );
        return _accessToken!;
      } else {
        throw Exception('Failed to obtain access token');
      }
    } catch (e) {
      print('Error getting access token: $e');
      rethrow;
    }
  }

  Future<List<AlbumModel>> searchAlbums(String query) async {
    print("query => $query");
    try {
      // Get the access token
      final String accessToken = await _getAccessToken();

      // Construct the search URL
      final url = Uri.parse(
          'https://api.spotify.com/v1/search?q=$query&type=album&limit=20');

      // Make the API request
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      // Process the response
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Safely extract album items
        final List<dynamic> albumsData = data['albums']?['items'] ?? [];

        // Map JSON to AlbumModel
        return albumsData
            .where((json) => json != null) // Filter out null entries
            .map((json) => AlbumModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load albums: ${response.body}');
      }
    } catch (e) {
      print('Error searching albums: $e');
      rethrow;
    }
  }
}