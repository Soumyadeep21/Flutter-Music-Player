import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/MusicInheritedWidget/mp_inherited.dart';
import 'package:music_player/data/song_data.dart';
import 'dart:io';
import 'package:music_player/Pages/now_playing.dart';
import 'package:page_transition/page_transition.dart';


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
            Center(child:CircularProgressIndicator()):
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
                        songData.setCurrentIndex(index);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => NowPlaying(song: s,songData: songData)
                        ));
                    },
                  );
                }
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Song s = (songData.currentIndex == null || songData.currentIndex < 0) ? songData.songs[0] : songData.songs [songData.currentIndex];
//            Navigator.of(context).push(MaterialPageRoute(
//                builder: (_) => NowPlaying(song: s,songData: songData,nowPlayTap: true,)
//            ));
            Navigator.of(context).push(
                PageTransition(
                    child: NowPlaying(song: s,songData: songData,nowPlayTap: true,),
                    type: PageTransitionType.scale,
                )
            );
          },
          child: Icon(Icons.play_arrow),
          backgroundColor: Colors.yellowAccent,
      ),
    );
  }
}
