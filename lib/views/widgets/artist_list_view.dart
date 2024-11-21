import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/artist_provider.dart';

class ArtistListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final artists = context.watch<ArtistProvider>().artists;
    final isLoading = context.watch<ArtistProvider>().isLoading;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
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
                radius: 25.0, // Adjust size as needed
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
}
