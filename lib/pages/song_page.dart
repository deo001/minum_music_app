import 'package:flutter/material.dart';
import 'package:minum_music_app/componets/neu_box.dart';
import 'package:minum_music_app/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value,child)=> Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text("Song Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          children: [
            // app bar
        
            // album artwork
            NeuBox(
              child: Column(
                children: [
                  ClipRRect(
                  
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/images/piano.png"),
                    ),
               Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Gharama",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                    Text("P Clement"),
                  ],
                ),
                Icon(Icons.favorite,
                color: Colors.red,)
              ],  
            ),
                ],
              ),
                
            ),
        
            // song duration


        
            //playback controls
            
          ],
        ),
      ),
    ),
    );
  }
}