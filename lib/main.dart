import 'package:flutter/material.dart';
import 'package:kpop_app/model/artist.dart';
import 'package:kpop_app/model/kpop_manager.dart';
import 'package:kpop_app/view/artist_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final url =
      "https://raw.githubusercontent.com/kpopnet/kpopnet.json/master/kpopnet.json";

  late Future<KpopManager?> kpopManager;

  @override
  void initState() {
    super.initState();
    kpopManager = getData();
  }

  Future<KpopManager?> getData() async {
    try {
      final uri = Uri.parse(url);
      var response = await http.get(uri);
      var decodedJson = jsonDecode(response.body);
      debugPrint(decodedJson.toString());
      return KpopManager.fromJson(decodedJson);
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: kpopManager,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              backgroundColor: Colors.red,
            );
          }
          if (snapshot.data == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            final artist = snapshot.data!.idolList
                .where((element) => element.name.contains("Jihyo"))
                .elementAt(0);
            final group = snapshot.data!.groupList
                .firstWhere((element) => element.id == artist.groups.first);
            final member = group.members.firstWhere((element) => element.idolId == artist.id && element.current == true);
          
            return ArtistDetail(
              artist: artist,
              group: group,
              member: member
            );
          }
        },
      ),
    );
  }
}
