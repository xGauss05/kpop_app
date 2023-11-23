class Artist {
  final String artistName;
  final String realName;
  final int age;
  final String debutDate;
  final String imgUrl;
  final String group;
  final List<Album>? albumList;
  final String id;
  final String appleUrl;

  Artist({
    required this.realName,
    required this.artistName,
    required this.age,
    required this.debutDate,
    required this.imgUrl,
    required this.group,
    this.albumList,
    required this.id,
    required this.appleUrl,
  });
}

class Album {
  final String albumName;
  final List<String> songList;

  Album({
    required this.albumName,
    required this.songList,
  });
}
