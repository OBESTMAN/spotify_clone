import 'dart:convert';
// import 'package:http/http.dart' as http;
import '../models/album_model.dart';

class AlbumService {
  Future<List<AlbumModel>> searchAlbums(String query) async {
    // final url = Uri.parse('https://api.example.com/search/albums?q=$query');
    // final response = await http.get(url);
    //
    // if (response.statusCode == 200) {
    //   final List<dynamic> data = json.decode(response.body);
    //   return data.map((json) => AlbumModel.fromJson(json)).toList();
    // } else {
    //   throw Exception('Failed to load albums');
    // }
    return [];
  }
}
