import 'dart:convert';
import 'dart:io';

import 'package:kpop_app/model/group.dart';
import 'package:kpop_app/model/idol.dart';
import 'package:path_provider/path_provider.dart';

class KpopManager {
  final List<Group> groupList;
  final List<Idol> idolList;
  List<Idol>? favoriteList;

  KpopManager(
      {required this.groupList,
      required this.idolList,
      });

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

void saveIdols(List<Idol> idolList) async {
  final dir = await getApplicationDocumentsDirectory();
  final json = jsonEncode(idolList);
  await File("${dir.absolute.path}/favorite_idols.json").writeAsString(json);
}

Future<List<Idol>> loadIdols() async {
  final dir = await getApplicationDocumentsDirectory();
  final json = await File("${dir.absolute.path}/favorite_idols.json").readAsString();
  final List jsonList = jsonDecode(json);
  return jsonList.map((t) => Idol.fromMap(t)).toList();
}
