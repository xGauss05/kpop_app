class Artist {
  final String artistName;
  final String realName;
  final int age;
  final String debutDate;
  final String imgUrl;
  final String group;
  final List<Album> albumList;
  final String id;
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

class Group {
    String agencyName;
    DateTime? debutDate;
    DateTime? disbandDate;
    String id;
    List<Member> members;
    String name;
    String? nameAlias;
    String nameOriginal;
    String? parentId;
    String? thumbUrl;
    List<String> urls;

    Group({
        required this.agencyName,
        required this.debutDate,
        required this.disbandDate,
        required this.id,
        required this.members,
        required this.name,
        required this.nameAlias,
        required this.nameOriginal,
        required this.parentId,
        required this.thumbUrl,
        required this.urls,
    });

    factory Group.fromMap(Map<String, dynamic> json) => Group(
        agencyName: json["agency_name"],
        debutDate: json["debut_date"] == null ? null : DateTime.parse(json["debut_date"]),
        disbandDate: json["disband_date"] == null ? null : DateTime.parse(json["disband_date"]),
        id: json["id"],
        members: List<Member>.from(json["members"].map((x) => Member.fromMap(x))),
        name: json["name"],
        nameAlias: json["name_alias"],
        nameOriginal: json["name_original"],
        parentId: json["parent_id"],
        thumbUrl: json["thumb_url"],
        urls: List<String>.from(json["urls"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "agency_name": agencyName,
        "debut_date": "${debutDate!.year.toString().padLeft(4, '0')}-${debutDate!.month.toString().padLeft(2, '0')}-${debutDate!.day.toString().padLeft(2, '0')}",
        "disband_date": "${disbandDate!.year.toString().padLeft(4, '0')}-${disbandDate!.month.toString().padLeft(2, '0')}-${disbandDate!.day.toString().padLeft(2, '0')}",
        "id": id,
        "members": List<dynamic>.from(members.map((x) => x.toMap())),
        "name": name,
        "name_alias": nameAlias,
        "name_original": nameOriginal,
        "parent_id": parentId,
        "thumb_url": thumbUrl,
        "urls": List<dynamic>.from(urls.map((x) => x)),
    };
}

class Member {
    bool current;
    String idolId;
    String? roles;

    Member({
        required this.current,
        required this.idolId,
        required this.roles,
    });

    factory Member.fromMap(Map<String, dynamic> json) => Member(
        current: json["current"],
        idolId: json["idol_id"],
        roles: json["roles"],
    );

    Map<String, dynamic> toMap() => {
        "current": current,
        "idol_id": idolId,
        "roles": roles,
    };
}

class Idol {
    DateTime birthDate;
    DateTime? debutDate;
    List<String> groups;
    double? height;
    String id;
    String name;
    String? nameAlias;
    String nameOriginal;
    String realName;
    String realNameOriginal;
    String thumbUrl;
    List<String> urls;
    double? weight;

    Idol({
        required this.birthDate,
        required this.debutDate,
        required this.groups,
        required this.height,
        required this.id,
        required this.name,
        required this.nameAlias,
        required this.nameOriginal,
        required this.realName,
        required this.realNameOriginal,
        required this.thumbUrl,
        required this.urls,
        required this.weight,
    });

    factory Idol.fromMap(Map<String, dynamic> json) => Idol(
        birthDate: DateTime.parse(json["birth_date"]),
        debutDate: json["debut_date"] == null ? null : DateTime.parse(json["debut_date"]),
        groups: List<String>.from(json["groups"].map((x) => x)),
        height: json["height"]?.toDouble(),
        id: json["id"],
        name: json["name"],
        nameAlias: json["name_alias"],
        nameOriginal: json["name_original"],
        realName: json["real_name"],
        realNameOriginal: json["real_name_original"],
        thumbUrl: json["thumb_url"],
        urls: List<String>.from(json["urls"].map((x) => x)),
        weight: json["weight"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "birth_date": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "debut_date": "${debutDate!.year.toString().padLeft(4, '0')}-${debutDate!.month.toString().padLeft(2, '0')}-${debutDate!.day.toString().padLeft(2, '0')}",
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "height": height,
        "id": id,
        "name": name,
        "name_alias": nameAlias,
        "name_original": nameOriginal,
        "real_name": realName,
        "real_name_original": realNameOriginal,
        "thumb_url": thumbUrl,
        "urls": List<dynamic>.from(urls.map((x) => x)),
        "weight": weight,
    };
}