import 'package:flutter/material.dart';
import 'package:minum_music_app/componets/drawer.dart';
import 'package:minum_music_app/models/playlist_provider.dart';
import 'package:minum_music_app/models/song.dart';
import 'package:minum_music_app/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Get the playlist provider instance
  // This will be initialized in initState
  late PlaylistProvider playlistProvider;

  @override
  void initState() {
    super.initState();

    // Access the PlaylistProvider using Provider.of
    // listen: false because we only need to access its methods,
    // not rebuild this widget when the provider changes.
    playlistProvider = Provider.of<PlaylistProvider>(
      context,
      listen: false,
    );
  }

  // Method to navigate to the song playing screen
  void goToSong(int songIndex) {
    // Update the current song index in the provider
    playlistProvider.currentSongIndex = songIndex;

    // Navigate to the song playing screen (assuming you have one)
    // You would typically push a new route here.
    // For example:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongPage(), // Replace with your actual song page widget
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("P L A Y L I S T"), // Use const for static text
        centerTitle: true, // Center the title for better aesthetics
      ),
      drawer: const MyDrawer(), // Assuming MyDrawer is a StatelessWidget or uses const
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          // Get the playlist from the provider
          final List<Song> playlist = value.playlist;

          // Return ListView UI
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final Song song = playlist[index];
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(
                  song.albumArtImagePath,
                  // width: 50, // Give a specific width for consistency
                  // height: 50, // Give a specific height
                  // fit: BoxFit.cover, // Ensure the image covers the area
                ),
                onTap: () => goToSong(index), // Call the method when tapped
              );
            },
          );
        },
      ),
    );
  }
}
