import 'package:flutter/material.dart';
import '../models/artist_model.dart';
import '../services/artist_service.dart';

class ArtistProvider with ChangeNotifier {
  List<ArtistModel> _artists = [ArtistModel(id: "id", name: "name", profileImageUrl: "https://images.unsplash.com/photo-1616663395403-2e0052b8e595?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")];
  bool _isLoading = false;

  List<ArtistModel> get artists => _artists;
  bool get isLoading => _isLoading;

  Future<void> fetchArtists(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      //_artists = await ArtistService().searchArtists(query);
    } catch (error) {
      _artists = [];
      debugPrint("Error fetching artists: $error");
    }

    _isLoading = false;
    notifyListeners();
  }
}
