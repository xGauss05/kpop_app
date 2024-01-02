import 'package:kpop_app/model/group.dart';
import 'package:kpop_app/model/idol.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KpopManager {
  static const String idolFavoriteKey = 'favoriteIdols';
  final List<Group> groupList;
  final List<Idol> idolList;
  final List<Idol> favoriteList = [];

  Future<void> addFavorite(Idol idol) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIdols = prefs.getStringList(idolFavoriteKey) ?? [];

    favoriteIdols.add(idol.id);
    prefs.setStringList(idolFavoriteKey, favoriteIdols);
  }

  Future<void> removeFavorite(Idol idol) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIdols = prefs.getStringList(idolFavoriteKey) ?? [];

    favoriteIdols.remove(idol.id);
    prefs.setStringList(idolFavoriteKey, favoriteIdols);
  }

  Future<void> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIdols = prefs.getStringList(idolFavoriteKey) ?? [];
    
    for (var element in idolList) {
      if (favoriteIdols.contains(element.id) && !favoriteList.contains(element)) {
        favoriteList.add(element);
      }
    }
  }

  KpopManager({
    required this.groupList,
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
