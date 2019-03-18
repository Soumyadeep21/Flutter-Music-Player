import 'package:flutter/material.dart';
import 'dart:io';

class NowPlaying extends StatefulWidget {

  final image,title;

  const NowPlaying({Key key, this.image, this.title}) : super(key: key);


  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {

//  final background = const Color(0xff010538);
  final background = Colors.black;
  double value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Hero(
                    tag: widget.title,
                    child: widget.image!=null?
                    Image.file(File.fromUri(Uri.parse(widget.image)),fit: BoxFit.cover,):
                    Image.asset("assets/music.jpg",fit: BoxFit.cover,),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(gradient: LinearGradient(
                      colors: [background,background.withOpacity(.4)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                  )
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Slider(
                      activeColor: Colors.greenAccent,
                      onChanged: (newValue){
                        setState(() {
                          value = newValue;
                        });
                      },
                      value: value,
                    ),
                    Row(
                      children: <Widget>[
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.skip_previous),
                          onPressed: (){},
                        ),
                        Spacer(),
                        FloatingActionButton(
                          onPressed: (){},
                          child: Icon(Icons.pause),
                          backgroundColor: Colors.pink,
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.skip_next),
                          onPressed: (){},
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )],
    )
    );
  }
}
