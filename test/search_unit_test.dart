import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:spotify_clone/models/album_model.dart';
import 'package:spotify_clone/models/artist_model.dart';
import 'package:spotify_clone/services/album_service.dart';
import 'package:spotify_clone/services/artist_service.dart';

import 'search_unit_test.mocks.dart';

@GenerateMocks([http.Client])
void main(){
  group('testSearch', (){
    test('successfully searches albums and returns data', () async {
      final client = MockClient();
      
      when(client.get(Uri.parse('https://api.spotify.com/v1/search?q=${"made"}&type=album&limit=20'))).thenAnswer(
          (_) async => http.Response('{"":""}', 200)
      );

      expect(await AlbumService().searchAlbums("made"), isA<List<AlbumModel>>());
    });

    test('successfully searches artists and returns data', () async {
      final client = MockClient();

      when(client.get(Uri.parse('https://api.spotify.com/v1/search?q=${"wiz"}&type=artist&limit=20'))).thenAnswer(
              (_) async => http.Response('{"":""}', 200)
      );

      expect(await ArtistService().searchArtists("wiz"), isA<List<ArtistModel>>());
    });
  });
}