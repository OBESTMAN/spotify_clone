import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../services/album_service.dart';

class AlbumProvider with ChangeNotifier {
  List<AlbumModel> _albums = [];
  bool _isLoading = false;
  String _currentQuery = '';
  bool _hasMoreItems = true;

  List<AlbumModel> get albums => _albums;
  bool get isLoading => _isLoading;
  bool get hasMoreItems => _hasMoreItems;
  String get currentQuery => _currentQuery;

  Future<void> fetchAlbums(String query, String offset) async {
    // If it's a new search, reset everything
    if (offset == '0') {
      _albums = [];
      _hasMoreItems = true;
      _currentQuery = query;
    }

    // Don't fetch if we're already loading or there are no more items
    if (_isLoading || !_hasMoreItems) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newAlbums = await AlbumService().searchAlbums(query, offset);

      // If we get fewer items than the page size (20), there are no more items
      if (newAlbums.length < 20) {
        _hasMoreItems = false;
      }

      // For new searches (offset = 0), replace the list
      // For pagination (offset > 0), append to the list
      _albums = offset == '0'
          ? newAlbums
          : [..._albums, ...newAlbums];
    } catch (error) {
      debugPrint("Error fetching albums: $error");
      if (offset == '0') _albums = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void resetState() {
    _albums = [];
    _isLoading = false;
    _currentQuery = '';
    _hasMoreItems = true;
    notifyListeners();
  }
}