class Member {
    final bool current;
    final String idolId;
    final String? roles;

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