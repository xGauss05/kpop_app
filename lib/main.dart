import 'package:flutter/material.dart';
import 'package:kpop_app/model/artist.dart';
import 'package:kpop_app/view/artist_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Color appTheme = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("testing hehe"),
          backgroundColor: appTheme,
          actions: const <Widget>[
            IconButton(
              onPressed: null,
              icon: Icon(Icons.arrow_back),
            ),
          ],
        ),
        body: ArtistDetail(
            artist: Artist(
                realName: "Im Nayeon",
                artistName: "Nayeon",
                age: 27,
                debutDate: "debutDate",
                imgUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/bc/c7/aa/bcc7aaac-311a-bd86-fd0d-3904d56a06fb/pr_source.png/450x400bb.jpg",
                group: "TWICE",
                albumList: null,
                id: "123456789",
                appleUrl: "https://music.apple.com/gb/artist/nayeon/1625812861")),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Saved',
            ),
          ],
        ),
      ),
    );
  }
}
