class Album {
  String name;
  DateTime year;
  Artist artist;
  List<Song> songs;

  Album({this.name, this.year, this.artist, this.songs});

  String get artistName => artist.name;
}

class Artist {
  String name;

  Artist({this.name});
}

class Song {
  String name, path, genre;
}