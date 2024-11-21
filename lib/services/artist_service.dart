import 'dart:convert';
// import 'package:http/http.dart' as http;
import '../models/artist_model.dart';

class ArtistService {
  Future<List<ArtistModel>> searchArtists(String query) async {
    // final url = Uri.parse('https://api.example.com/search/artists?q=$query');
    // final response = await http.get(url);
    //
    // if (response.statusCode == 200) {
    //   final List<dynamic> data = json.decode(response.body);
    //   return data.map((json) => ArtistModel.fromJson(json)).toList();
    // } else {
    //   throw Exception('Failed to load artists');
    // }
    return [];
  }
}
