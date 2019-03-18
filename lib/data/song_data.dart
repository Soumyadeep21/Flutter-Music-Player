import 'package:flute_music_player/flute_music_player.dart';

class SongData{

  List<Song> _songs;
  int _currentSongIndex = -1;
  MusicFinder musicFinder = MusicFinder();
  SongData(this._songs);

  List<Song> get songs => _songs;
  int get length => _songs.length;
  int get currentIndex => _currentSongIndex;
  MusicFinder get audioPlayer => musicFinder;

  setCurrentIndex(int index){
    _currentSongIndex = index;
  }

  Song nextSong(){
    if(_currentSongIndex < length - 1)
      _currentSongIndex++;
    if(_currentSongIndex>= length -1)
      return null;
    return _songs[_currentSongIndex];
  }

  Song prevSong(){
    if(_currentSongIndex > 0)
      _currentSongIndex--;
    if(_currentSongIndex <= 0)
      return null;
    return _songs[_currentSongIndex];
  }

}