import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:minum_music_app/models/song.dart'; // Assuming your Song model is here

class PlaylistProvider extends ChangeNotifier {
  // playlist of songs
  final List<Song> _playlist = [
    Song(
      songName: "Gharama",
      artistName: "P Clement",
      albumArtImagePath: "assets/images/pastor.png",
      audioPath: "assets/songs/Paul_Clement_-_Neema_Ya_Mungu___Official_Video__(48k).mp3",
    ),
    //song 2
    Song(
      songName: "Mrs Me",
      artistName: "Msodoki",
      albumArtImagePath: "assets/images/msodoki1.png",
      audioPath: "assets/songs/Msodoki_Young_Killer_-_Ngosha__Official_Music_Video_(0).m4a",
    ),
    //song 3
    Song(
      songName: "Wait ",
      artistName: "Rapcha ",
      albumArtImagePath: "assets/images/msodoki1.png",
      audioPath: "assets/songs/Rapcha_-_Wait__Performance_Visual_(48k).mp3",
    ),
  ];

  // current Song playing index
  int? _currentSongIndex;

  // Getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // A U D I O P L A Y E R
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // Initially not playing
  bool _isPlaying = false;

  // Constructor
  PlaylistProvider() {
    listenToDurationAndPosition(); // Corrected listener setup
    listenToSongCompletion(); 
         // New listener for song completion
  }

  // Play the song
  void play() async {
    if (_currentSongIndex == null) {
      // If no song is selected, start with the first one
      if (_playlist.isNotEmpty) {
        _currentSongIndex = 0;
      } else {
        print("Playlist is empty. Cannot play.");
        return;
      }
    }

    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // Stop any currently playing audio
    await _audioPlayer.play(AssetSource(path)); // Play the new asset
    _isPlaying = true;
    notifyListeners();
  }

  // Pause the song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Resume the song
  void resume() async {
    await _audioPlayer.resume(); // Use .resume() or .play() to resume
    _isPlaying = true;
    notifyListeners();
  }

  // Pause or resume (toggle)
  void pauseOrResume() async {
    if (_isPlaying) { // Use the _isPlaying state
      pause();
    } else {
      resume();
    }
  }

  // Seek the position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Play next
  void playNextSong() {
    if (_playlist.isEmpty) return;

    if (_currentSongIndex == null) {
      currentSongIndex = 0; // Start from the beginning if no song is selected
    } else if (_currentSongIndex! < _playlist.length - 1) {
      currentSongIndex = _currentSongIndex! + 1; // Go to the next song
    } else {
      currentSongIndex = 0; // Loop back to the first song if at the end
    }
  }

  // Play previous
  void playPreviousSong() async {
    if (_playlist.isEmpty) return;

    // If more than 3 seconds into the song, restart the current song
    if (_currentDuration.inSeconds > 3) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex == null || _currentSongIndex! == 0) {
        currentSongIndex = _playlist.length - 1; // Loop back to the last song
      } else {
        currentSongIndex = _currentSongIndex! - 1; // Go to the previous song
      }
    }
  }

  // list of durations (Corrected Listener Setup)
  void listenToDurationAndPosition() {
    // Listen to total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // Listen to current position
    _audioPlayer.onPositionChanged.listen((newPosition) { // <-- CORRECTED: Use onPositionChanged
      _currentDuration = newPosition;
      notifyListeners();
    });
  }

  // Listen for song completion
  void listenToSongCompletion() {
    _audioPlayer.onPlayerComplete.listen((event) { // <-- CORRECTED: Use onPlayerComplete
      _isPlaying = false; // Set playing state to false
      notifyListeners(); // Notify listeners to update play/pause button etc.
      playNextSong(); // Automatically play the next song
    });
  }

  // Dispose audio player
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Setters
  set currentSongIndex(int? newIndex) {
    // Update current song index
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); // Play the newly selected song
    } else {
      _audioPlayer.stop(); // Stop if no song is selected
      _isPlaying = false;
      _currentDuration = Duration.zero; // Reset current duration
      _totalDuration = Duration.zero;   // Reset total duration
    }

    // Update UI
    notifyListeners();
  }
}