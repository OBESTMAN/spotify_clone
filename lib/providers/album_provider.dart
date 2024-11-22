import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../services/album_service.dart';

class AlbumProvider with ChangeNotifier {
  List<AlbumModel> _albums = [];
  bool _isLoading = false;

  List<AlbumModel> get albums => _albums;
  bool get isLoading => _isLoading;

  Future<void> fetchAlbums(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _albums = await AlbumService().searchAlbums(query);
    } catch (error) {
      _albums = [];
      debugPrint("Error fetching albums: $error");
    }

    _isLoading = false;
    notifyListeners();
  }
}
