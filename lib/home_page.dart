import 'package:flutter/material.dart';
import 'package:music_player/MusicInheritedWidget/mp_inherited.dart';
import 'package:music_player/data/song_data.dart';
import 'dart:io';
import 'package:music_player/now_playing.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inherited = MPInherited.of(context);
    SongData songData = inherited.songData;
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
        centerTitle: true,
      ),
      body: inherited.isLoading?
            CircularProgressIndicator():
            ListView.builder(
                itemCount: songData.songs.length,
                itemBuilder: (context,index) {
                  var s = songData.songs[index];
                  return ListTile(
                      leading: Hero(
                        tag: s.title,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: s.albumArt!=null?
                                    Image.file(File.fromUri(Uri.parse(s.albumArt)),fit: BoxFit.cover,):
                                    Icon(Icons.music_note),
                          ),
                        ),
                      ),
                      title: Text(s.title),
                      subtitle: Text(s.artist),
                    onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => NowPlaying(title: s.title,image: s.albumArt,)
                        ));
                    },
                  );
                }
            ),
    );
  }
}
