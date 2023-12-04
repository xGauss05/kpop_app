import 'package:kpop_app/model/artist.dart';

class KpopManager {
  final List<Group> groupList;
  final List<Idol> idolList;

  KpopManager({required this.groupList, required this.idolList});

  factory KpopManager.fromJson(Map<String, dynamic> json) {
    return KpopManager(
        groupList: json['groups']?.map(Group.fromMap(json)),
        idolList: json['idols']?.map(Group.fromMap(json)));
  }
}
