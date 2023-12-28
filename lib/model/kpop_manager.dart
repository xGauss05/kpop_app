import 'package:kpop_app/model/group.dart';
import 'package:kpop_app/model/idol.dart';

class KpopManager {
  final List<Group> groupList;
  final List<Idol> idolList;

  KpopManager({required this.groupList, required this.idolList});

  factory KpopManager.fromJson(Map<String, dynamic> json) {
    return KpopManager(
      groupList: json['groups'] == null
          ? []
          : List<Group>.from(json["groups"].map((x) => Group.fromMap(x))),
      idolList: json['idols'] == null
          ? []
          : List<Idol>.from(json["idols"].map((x) => Idol.fromMap(x))),
    );
  }
}
