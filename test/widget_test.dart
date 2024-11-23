import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/views/splash_screen.dart';
import 'package:spotify_clone/views/main_screen.dart';
import 'package:spotify_clone/providers/artist_provider.dart';
import 'package:spotify_clone/providers/album_provider.dart';
import 'package:spotify_clone/providers/view_option_provider.dart';
import 'package:spotify_clone/views/widgets/album_grid_view.dart';
import 'package:spotify_clone/views/widgets/artist_list_view.dart';

void main() {
  group('App Navigation Tests', () {
    late ViewOptionProvider mockViewOptionProvider;
    late AlbumProvider mockAlbumProvider;
    late ArtistProvider mockArtistProvider;

    setUp(() {
      // Initialize mock providers
      mockViewOptionProvider = ViewOptionProvider();
      mockAlbumProvider = AlbumProvider();
      mockArtistProvider = ArtistProvider();
    });

    Widget createTestWidget() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<ViewOptionProvider>(
            create: (_) => mockViewOptionProvider,
          ),
          ChangeNotifierProvider<AlbumProvider>(
            create: (_) => mockAlbumProvider,
          ),
          ChangeNotifierProvider<ArtistProvider>(
            create: (_) => mockArtistProvider,
          ),
        ],
        child: const MaterialApp(
          home: SplashScreen(),
        ),
      );
    }

    testWidgets('SplashScreen displays correctly and transitions to MainScreen',
            (WidgetTester tester) async {
          await tester.pumpWidget(createTestWidget());

          // Verify SplashScreen is displayed
          expect(find.byType(SplashScreen), findsOneWidget);
          expect(find.byType(MainScreen), findsNothing);

          // Wait for the SplashScreen duration and animation to complete
          await tester.pumpAndSettle(const Duration(seconds: 4));

          // Verify transition to MainScreen
          expect(find.byType(SplashScreen), findsNothing);
          expect(find.byType(MainScreen), findsOneWidget);
        });

    testWidgets('MainScreen displays search bar and toggle buttons after transition',
            (WidgetTester tester) async {
          await tester.pumpWidget(createTestWidget());

          // Wait for SplashScreen to transition
          await tester.pumpAndSettle(const Duration(seconds: 4));

          // Verify MainScreen components
          expect(find.byType(TextField), findsOneWidget); // Search bar
          expect(find.text("Albums"), findsOneWidget); // Albums toggle
          expect(find.text("Artists"), findsOneWidget); // Artists toggle
        });

    testWidgets('MainScreen toggles between AlbumGridView and ArtistListView',
            (WidgetTester tester) async {
          await tester.pumpWidget(createTestWidget());

          // Wait for SplashScreen to transition
          await tester.pumpAndSettle(const Duration(seconds: 4));

          // Default view should be AlbumGridView
          expect(find.byType(AlbumGridView), findsOneWidget);
          expect(find.byType(ArtistListView), findsNothing);

          // Tap "Artists" to toggle view
          await tester.tap(find.text("Artists"));
          await tester.pumpAndSettle();

          // Verify ArtistListView is displayed
          expect(find.byType(ArtistListView), findsOneWidget);
          expect(find.byType(AlbumGridView), findsNothing);
        });
  });
}