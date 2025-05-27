import 'package:flutter/material.dart';
import 'package:minum_music_app/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  // playlist of songs
  final List<Song> _playlist = [
    Song(
      songName: "Gharama",
      artistName: "P Clement",
      albumArtImagePath: "assets/images/pastor.png",
      audioPath: "assets/audio/Paul_Clement_-_Neema_Ya_Mungu___Official_Video__(48k).mp3"
    ),
    //song 2
     Song(
      songName: "Mrs Me",
      artistName: "Msodoki",
      albumArtImagePath: "assets/images/msodoki1.png",
      audioPath: "assets/audio/Msodoki_Young_Killer_-_Ngosha__Official_Music_Video_(0).m4a"
    ),
    //song 3
     Song(
      songName: "Wait ",
      artistName: "Rapcha ",
      albumArtImagePath: "assets/images/msodoki1.png",
      audioPath: "assets/audio/Rapcha_-_Wait__Performance_Visual_(48k).mp3"
    ),

  ];
// current Song playing index
int? _currentSongIndex;

// Getters
List<Song> get playlist => _playlist;
int? get currentSongIndex => _currentSongIndex;

//Setters
set currentSongIndex(int? newIndex){

  // update current song index
  _currentSongIndex = newIndex;

  //update UI
  notifyListeners();
}

}