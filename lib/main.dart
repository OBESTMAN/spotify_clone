import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/artist_provider.dart';
import './providers/album_provider.dart';
import './providers/view_option_provider.dart';
import './views/main_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArtistProvider()),
        ChangeNotifierProvider(create: (_) => AlbumProvider()),
        ChangeNotifierProvider(create: (_) => ViewOptionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}
