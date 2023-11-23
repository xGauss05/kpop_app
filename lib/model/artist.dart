class Artist {
  final String artistName;
  final String realName;
  final int age;
  final String debutDate;
  final String imgUrl;
  final String group;
  final List<Album> albumList;
  final String id;
  final String appleUrl;
  final String role;
  final String about;

  Artist({
    required this.realName,
    required this.artistName,
    required this.age,
    required this.debutDate,
    required this.imgUrl,
    required this.group,
    required this.albumList,
    required this.id,
    required this.appleUrl,
    required this.role,
    required this.about,
  });
}

class Album {
  final String albumName;
  final String imgUrl;

  Album({
    required this.albumName,
    required this.imgUrl,
  });
}
