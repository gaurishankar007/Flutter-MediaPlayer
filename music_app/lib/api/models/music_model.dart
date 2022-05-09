class Album {
  String? id;
  String? title;

  Album({this.id, this.title});
}

class Song {
  String? id;
  String? tittle;
  Album? album;
  String? music;
  int? players;
  int? likes;

  Song({
    this.id,
    this.tittle,
    this.album,
    this.music,
    this.players,
    this.likes,
  });
}