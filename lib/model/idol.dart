class Idol {
    final DateTime birthDate;
    final DateTime? debutDate;
    final List<String> groups;
    final double? height;
    final String id;
    final String name;
    final String? nameAlias;
    final String nameOriginal;
    final String realName;
    final String realNameOriginal;
    final String thumbUrl;
    final List<String> urls;
    final double? weight;

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

    @override
    String toString() { return name; }
}

