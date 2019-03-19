import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/MusicInheritedWidget/mp_inherited.dart';
import 'package:music_player/data/song_data.dart';
import 'package:music_player/Pages/home_page.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  SongData songData;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    loadSongs();
  }

  void loadSongs() async{
    _isLoading = true;
    List<Song> songs;
    print("Loading Songs");
    try{
      songs = await MusicFinder.allSongs();
    }catch(e){
      //print("Error!Cannot get fetch Songs");
    }

    if(!mounted)
      return;

    songs.sort((a,b) => (a.title.compareTo(b.title)));

    setState(() {
      songData = SongData(songs);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MPInherited(songData,_isLoading,child: HomePage(),);
  }
}
