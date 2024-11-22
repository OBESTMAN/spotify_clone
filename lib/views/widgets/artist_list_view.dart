import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/providers/artist_provider.dart';

class ArtistListView extends StatefulWidget {
  @override
  _ArtistListViewState createState() => _ArtistListViewState();
}

class _ArtistListViewState extends State<ArtistListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final provider = context.read<ArtistProvider>();

    // Check if we are close to the bottom and if we should load more items
    if (!provider.isLoading &&
        provider.artists.length < 30 &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100) {
      // Fetch more artists
      final currentLength = provider.artists.length;
      provider.fetchArtists(provider.currentQuery, currentLength.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final artistProvider = context.watch<ArtistProvider>();
    final artists = artistProvider.artists;
    final isLoading = artistProvider.isLoading;

    if (artists.isEmpty && isLoading) {
      // Initial shimmer effect when there are no items loaded
      return _buildShimmerEffect();
    }

    if (artists.isEmpty) {
      // Show empty state message
      return const Center(
        child: Text(
          "No artists found",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: artists.length + (isLoading ? 1 : 0), // Add extra item for the loader
      itemBuilder: (context, index) {
        if (index < artists.length) {
          // Regular artist item
          final artist = artists[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(artist.imageUrl),
                ),
                const SizedBox(width: 20),
                Text(
                  artist.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          );
        } else {
          // Loading indicator at the end of the list
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildShimmerEffect() {
    // Shimmer effect for initial loading
    return ListView.builder(
      itemCount: 6, // Number of shimmer items to show
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            children: [
              // Circle for avatar
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 20),
              // Rectangle for text
              Container(
                height: 16,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
