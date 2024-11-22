import 'package:flutter/material.dart';
import '../models/artist_model.dart';
import '../services/artist_service.dart';

class ArtistProvider with ChangeNotifier {
  List<ArtistModel> _artists = [];
  bool _isLoading = false;

  List<ArtistModel> get artists => _artists;
  bool get isLoading => _isLoading;

  Future<void> fetchArtists(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _artists = await ArtistService().searchArtists(query);
    } catch (error) {
      _artists = [];
      debugPrint("Error fetching artists: $error");
    }

    _isLoading = false;
    notifyListeners();
  }
}
