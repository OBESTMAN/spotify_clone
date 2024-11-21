import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/album_provider.dart';

class AlbumGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final albums = context.watch<AlbumProvider>().albums;
    final isLoading = context.watch<AlbumProvider>().isLoading;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (albums.isEmpty) {
      return const Center(
        child: Text(
          "No albums found",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: Image.network(album.coverUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              album.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              album.artistName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white54),
            ),
          ],
        );
      },
    );
  }
}