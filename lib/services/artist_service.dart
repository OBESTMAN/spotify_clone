import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_clone/models/artist_model.dart';
import 'package:http/http.dart' as http;

class ArtistService {
  final String? _clientId = dotenv.env['CLIENT_ID'];
  final String? _clientSecret = dotenv.env['CLIENT_SECRET'];
  final String? _apiUrl = dotenv.env['API_URL'];

  String? _accessToken;
  DateTime? _tokenExpiration;

  Future<String> _getAccessToken() async {
    // Check if we have a valid token
    if (_accessToken != null &&
        _tokenExpiration != null &&
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
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'grant_type': 'client_credentials'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> tokenData = json.decode(response.body);
        _accessToken = tokenData['access_token'];
        _tokenExpiration = DateTime.now()
            .add(Duration(seconds: tokenData['expires_in']));
        return _accessToken!;
      } else {
        throw Exception('Failed to obtain access token');
      }
    } catch (e) {
      print('Error getting access token: $e');
      rethrow;
    }
  }

  Future<List<ArtistModel>> searchArtists(String query, String offset) async {
    try {
      // Get the access token
      final String accessToken = await _getAccessToken();

      // Construct the search URL
      final url = Uri.parse('$_apiUrl$query&type=artist&offset=$offset&limit=20');

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

        // Safely extract artist items
        final List<dynamic> artistsData = data['artists']?['items'] ?? [];

        // Map JSON to ArtistModel
        return artistsData
            .where((json) => json != null) // Filter out null entries
            .map((json) => ArtistModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load artists: ${response.body}');
      }
    } catch (e) {
      print('Error searching artists: $e');
      rethrow;
    }
  }
}
