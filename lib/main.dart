import 'package:flutter/material.dart';
import 'package:kpop_app/model/kpop_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import 'package:kpop_app/view/screens/artist_screen.dart';
import 'package:kpop_app/view/screens/favorite_screen.dart';
import 'package:kpop_app/view/screens/search_screen.dart';

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
      //debugPrint(decodedJson.toString());

      return KpopManager.fromJson(decodedJson);
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      //debugPrintStack(stackTrace: stackTrace);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: kpopManager,
      child: MaterialApp(
        routes: {
          "home": (context) => const ArtistScreen(),
          "search": (context) => const SearchScreen(),
          "favorite": (context) => const FavoriteScreen(),
        },
        initialRoute: "search",
      ),
    );
  }
}
