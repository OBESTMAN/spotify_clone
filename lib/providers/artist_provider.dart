import 'package:flutter/material.dart';
import '../models/artist_model.dart';
import '../services/artist_service.dart';

class ArtistProvider with ChangeNotifier {
  List<ArtistModel> _artists = [];
  bool _isLoading = false;
  String _currentQuery = '';
  bool _hasMoreItems = true;

  List<ArtistModel> get artists => _artists;
  bool get isLoading => _isLoading;
  //bool get hasMoreItems => _hasMoreItems;
  String get currentQuery => _currentQuery;

  Future<void> fetchArtists(String query, String offset) async {
    // If it's a new search, reset everything
    if (offset == '0') {
      _artists = [];
      _hasMoreItems = true;
      _currentQuery = query;
    }

    // Don't fetch if we're already loading or there are no more items
    if (_isLoading || !_hasMoreItems) return;

    _isLoading = true;
    notifyListeners();

    try {

      print("query => " + query);
      print("offset => " + offset);

      final newArtists = await ArtistService().searchArtists(query, offset);

      // If we get fewer items than the page size (20), there are no more items
      if (newArtists.length < 20) {
        _hasMoreItems = false;
      }

      // For new searches (offset = 0), replace the list
      // For pagination (offset > 0), append to the list
      _artists = offset == '0'
          ? newArtists
          : [..._artists, ...newArtists];
    } catch (error) {
      debugPrint("Error fetching artists: $error");
      if (offset == '0') _artists = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void resetState() {
    _artists = [];
    _isLoading = false;
    _currentQuery = '';
    _hasMoreItems = true;
    notifyListeners();
  }
}
