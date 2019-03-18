import 'package:flutter/material.dart';
import 'package:music_player/data/song_data.dart';

class MPInherited extends InheritedWidget {

  final SongData songData;
  final bool isLoading;

  const MPInherited(this.songData, this.isLoading, {
    Key key,
    @required Widget child,
  })
      : assert(child != null),
        super(key: key, child: child);

  static MPInherited of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MPInherited) as MPInherited;
  }

  @override
  bool updateShouldNotify(MPInherited old) {
    return (songData!=old.songData || isLoading != old.isLoading);
  }
}