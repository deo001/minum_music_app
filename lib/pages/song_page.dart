import 'package:flutter/material.dart';
import 'package:minum_music_app/componets/neu_box.dart';
import 'package:minum_music_app/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  // Helper to format duration for display (e.g., 0:00, 3:45)
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, playlistProvider, child) { // Renamed 'value' to 'playlistProvider' for clarity

        // IMPORTANT: Handle the case where no song is selected or playlist is empty.
        // This prevents an error if currentSongIndex is null or out of bounds.
        if (playlistProvider.currentSongIndex == null || playlistProvider.playlist.isEmpty) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: AppBar(
              title: const Text("Song Page"),
            ),
            body: const Center(
              child: Text("No song selected or playlist is empty."),
            ),
          );
        }

        // Get playlist and current song
        final playlist = playlistProvider.playlist;
        final currentSong = playlist[playlistProvider.currentSongIndex!]; // Use ! after the null check

        // Return The Scaffold UI
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: const Text("Song Page"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // album artwork
                NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        // Use the albumArtImagePath from your Song model
                        child: Image.asset(currentSong.albumArtImagePath),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded( // <--- ADDED Expanded to prevent overflow
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context).colorScheme.inversePrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis, // <--- Added for long names
                                  ),
                                  Text(
                                    currentSong.artistName,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                    overflow: TextOverflow.ellipsis, // <--- Added for long names
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // song duration and progress
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // Slider for current position
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8), // <--- Made thumb visible
                          overlayShape: SliderComponentShape.noOverlay,
                          activeTrackColor: Theme.of(context).colorScheme.primary,
                          inactiveTrackColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        ),
                        child: Slider(
                          min: 0.0,
                          max: playlistProvider.totalDuration.inSeconds.toDouble(),
                          value: playlistProvider.currentDuration.inSeconds.toDouble().clamp(0.0, playlistProvider.totalDuration.inSeconds.toDouble()),
                          onChanged: (double value) {
                            // Can be empty if you only want to seek on onChangeEnd
                          },
                          onChangeEnd: (double value) {
                            playlistProvider.seek(Duration(seconds: value.toInt()));
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // start time (current duration)
                          Text(_formatDuration(playlistProvider.currentDuration)), // <--- CORRECTED: Use provider value
                          //shuffle icon
                          IconButton(
                            icon: const Icon(Icons.shuffle),
                            onPressed: () {
                              // TODO: Implement shuffle logic in PlaylistProvider
                            },
                          ),
                          //repeat icon
                          IconButton(
                            icon: const Icon(Icons.repeat),
                            onPressed: () {
                              // TODO: Implement repeat logic in PlaylistProvider
                            },
                          ),
                          //end time (total duration)
                          Text(_formatDuration(playlistProvider.totalDuration)), // <--- CORRECTED: Use provider value
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // playback controls
                Row(
                  children: [
                    Expanded(
                      // previous button
                      child: GestureDetector(
                        onTap: playlistProvider.playPreviousSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Play/Pause button
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: playlistProvider.pauseOrResume,
                        child: NeuBox(
                          child: Icon(
                            playlistProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Next button
                    Expanded(
                      child: GestureDetector(
                        onTap: playlistProvider.playNextSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}