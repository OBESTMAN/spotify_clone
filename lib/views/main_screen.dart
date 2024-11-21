import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/view_option_provider.dart';
import '../providers/artist_provider.dart';
import '../providers/album_provider.dart';
import 'widgets/album_grid_view.dart';
import 'widgets/artist_list_view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewOption = context.watch<ViewOptionProvider>().viewOption;
    final isAlbumView = viewOption == ViewOption.album;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Adjust height if needed
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 16, bottom: 16), // Add padding
          color: Colors.black,
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35, // Increase font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Artists, albums...",
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(CupertinoIcons.search, color: Colors.black),
              ),
              onChanged: (query) {
                if (isAlbumView) {
                  context.read<AlbumProvider>().fetchAlbums(query);
                } else {
                  context.read<ArtistProvider>().fetchArtists(query);
                }
              },
            ),
            const SizedBox(height: 30),

            // Toggle buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildToggleButton(context, "Albums", ViewOption.album),
                const SizedBox(width: 8),
                _buildToggleButton(context, "Artists", ViewOption.artist),
              ],
            ),
            const SizedBox(height: 30),

            // Dynamic content: Album GridView or Artist ListView
            Expanded(
              child: isAlbumView ? AlbumGridView() : ArtistListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(BuildContext context, String title, ViewOption option) {
    final isSelected = context.watch<ViewOptionProvider>().viewOption == option;

    return GestureDetector(
      onTap: () {
        context.read<ViewOptionProvider>().updateView(option);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
