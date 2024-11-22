import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../providers/artist_provider.dart';

class ArtistListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final artists = context.watch<ArtistProvider>().artists;
    final isLoading = context.watch<ArtistProvider>().isLoading;

    if (isLoading) {
      return _buildShimmerEffect();
    }

    if (artists.isEmpty) {
      return const Center(
        child: Text(
          "No artists found",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(artist.imageUrl),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                artist.name,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[700]!,
      child: ListView.builder(
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
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 20),
                // Rectangle for text
                Container(
                  height: 16,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}