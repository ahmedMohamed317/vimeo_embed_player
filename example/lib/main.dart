import 'package:flutter/material.dart';
import 'package:vimeo_embed_player/vimeo_embed_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: VimeoEmbedPlayer(
          vimeoId: '397912933',
        ),
      ),
    );
  }
}
