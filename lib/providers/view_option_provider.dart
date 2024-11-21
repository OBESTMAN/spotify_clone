import 'package:flutter/material.dart';

enum ViewOption { album, artist }

class ViewOptionProvider with ChangeNotifier {
  ViewOption _viewOption = ViewOption.album; // Default view option is 'Album'

  ViewOption get viewOption => _viewOption;

  void updateView(ViewOption newOption) {
    if (_viewOption != newOption) {
      _viewOption = newOption;
      notifyListeners();
    }
  }
}
