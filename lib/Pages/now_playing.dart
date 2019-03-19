import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:music_player/data/song_data.dart';

enum PlayerState {playing , paused , stopped}

class NowPlaying extends StatefulWidget {

  final Song song;
  final SongData songData;
  final bool nowPlayTap;

  const NowPlaying({Key key, this.song, this.songData, this.nowPlayTap}) : super(key: key);


  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {

  final background = Colors.black;
  MusicFinder audioPlayer;
  PlayerState playerState;
  Duration duration;
  Duration position;
  Song song;

  @override
  void initState() {
    super.initState();
    loadPlayer();
  }

  get durationText => duration!=null ? duration.toString().split('.').first:"";
  get positionText => position!=null ? position.toString().split('.').first:"";

  void loadPlayer() async{
    if(audioPlayer == null)
      audioPlayer = widget.songData.audioPlayer;
    setState(() {
      song = widget.song;
      if(widget.nowPlayTap == false || widget.nowPlayTap == null){
        if(playerState != PlayerState.stopped) {
          stop();
        }
      }
      play(song);
    });

    audioPlayer.setDurationHandler((d){
      setState(() {
        duration = d;
      });
    });

    audioPlayer.setPositionHandler((p){
      setState(() {
        position = p;
      });
    });

    audioPlayer.setCompletionHandler((){
      setState(() {
        position = duration;
        song = widget.songData.nextSong();
        play(song);
      });
    });

    audioPlayer.setErrorHandler((error){
      playerState = PlayerState.stopped;
      duration = Duration(seconds: 0);
      position = Duration(seconds: 0);
    });
  }

  Future play(Song s) async{
    int result = await audioPlayer.play(s.uri,isLocal: true);
    if(result == 1)
      setState(() {
        playerState = PlayerState.playing;
        song = s;
      });
  }

  Future stop() async{
    int result = await audioPlayer.stop();
    if(result == 1)
      setState(() {
        playerState = PlayerState.stopped;
      });
  }

  Future pause() async{
    int result = await audioPlayer.pause();
    if(result == 1)
      setState(() {
        playerState = PlayerState.paused;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: song.title,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: song.albumArt != null ?
                    Image.file(File.fromUri(Uri.parse(song.albumArt)),fit: BoxFit.cover,):
                    Image.asset("assets/music.jpg",fit: BoxFit.cover,),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [background,background.withOpacity(.6),background.withOpacity(.4)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
              )
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
              ),
              Spacer(),
              Center(child: Text(song.title,style: TextStyle(fontSize: 17.0,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),),
              Center(child: Text(song.artist,style: TextStyle(fontSize: 15.0,fontStyle: FontStyle.italic),),),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Slider(
                    activeColor: Colors.greenAccent,
                    inactiveColor: Colors.orange,
                    value: position!=null?position.inMilliseconds.toDouble():0,
                    onChanged: (double value){
                      audioPlayer.seek((value/1000).roundToDouble());
                    },
                    min: 0.0,
                    max: duration!=null?duration.inMilliseconds.toDouble():0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Row(
                  children: <Widget>[
                    Text(positionText),
                    Spacer(),
                    Text(durationText)
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.skip_previous),
                      onPressed: (){
                        stop();
                        play(widget.songData.prevSong());
                      }
                  ),
                  Spacer(),
                  FloatingActionButton(
                      onPressed: (){
                        if(playerState == PlayerState.playing)
                          pause();
                        else
                          play(song);
                      },
                      child: Icon(playerState == PlayerState.playing ? Icons.pause : Icons.play_arrow),
                      backgroundColor: Colors.pink,
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.skip_next),
                      onPressed: (){
                        stop();
                        play(widget.songData.nextSong());
                      }
                  ),
                  Spacer(),
                ],
              ),
              Spacer()
            ],
          )
        ],
      ),
    );
  }
}
