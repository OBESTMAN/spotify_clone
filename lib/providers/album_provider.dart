import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../services/album_service.dart';

class AlbumProvider with ChangeNotifier {
  List<AlbumModel> _albums = [AlbumModel(id: "id", title: "title", artistName: "artistName", coverUrl: "https://images.unsplash.com/photo-1616663395403-2e0052b8e595?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", releaseYear: "2019")];
  bool _isLoading = false;

  List<AlbumModel> get albums => _albums;
  bool get isLoading => _isLoading;

  Future<void> fetchAlbums(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      //_albums = await AlbumService().searchAlbums(query);
     _albums =  [AlbumModel(id: "id", title: "title", artistName: "artistName", coverUrl: "https://images.unsplash.com/photo-1616663395403-2e0052b8e595?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", releaseYear: "releaseYear")];
    } catch (error) {
      _albums = [];
      debugPrint("Error fetching albums: $error");
    }

    _isLoading = false;
    notifyListeners();
  }
}
