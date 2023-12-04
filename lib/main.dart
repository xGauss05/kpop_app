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

  final Artist artist = Artist(
    realName: "Im Na-yeon",
    artistName: "Nayeon",
    role: "Lead Vocalist",
    age: 28,
    debutDate: "20/10/2015",
    imgUrl:
        "https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/bc/c7/aa/bcc7aaac-311a-bd86-fd0d-3904d56a06fb/pr_source.png/960x960bb.jpg",
    about:
        "Im Na-yeon (Hangul: 임나연, Japanese: イム ナヨン), better known by her stage name, Nayeon (Hangul: 나연, Japanese: ナヨン) is a South Korean singer. She is the oldest member, lead vocalist and face of the girl group Twice. Nayeon is the first member of TWICE to debut as a solo artist. Her solo debut was on June 24, 2022.",
    group: "TWICE",
    albumList: [
      Album(
          albumName: "Twicetagram",
          imgUrl:
              "https://static.wikia.nocookie.net/twicenation/images/2/23/Likey_teaser_coverphoto.jpg/revision/latest/scale-to-width-down/1000?cb=20171029192106"),
      Album(
          albumName: "Feel Special",
          imgUrl:
              "https://static.wikia.nocookie.net/twicenation/images/e/e3/Feel_Special_Online_Cover.jpg/revision/latest/scale-to-width-down/1000?cb=20190923124415"),
      Album(
          albumName: "More & More",
          imgUrl:
              "https://static.wikia.nocookie.net/twicenation/images/0/08/More%26More_Online_Cover.jpg/revision/latest/scale-to-width-down/1000?cb=20200601030205"),
      Album(
          albumName: "Eyes Wide Open",
          imgUrl:
              "https://static.wikia.nocookie.net/twicenation/images/3/32/Eyes_wide_open_Online_Cover_%28Revised%29.jpg/revision/latest/scale-to-width-down/1000?cb=20201012153409"),
      Album(
          albumName: "Taste of Love",
          imgUrl:
              "https://static.wikia.nocookie.net/twicenation/images/d/d6/TasteOfLove_Full_Release_Cover.jpg/revision/latest/scale-to-width-down/1000?cb=20210610172524"),
      Album(
          albumName: "Formula of Love: O+T=<3",
          imgUrl:
              "https://static.wikia.nocookie.net/twicenation/images/1/11/Formula_of_Love_Digital_Cover.png/revision/latest?cb=20211102063652"),
      Album(
          albumName: "Celebrate",
          imgUrl:
              "https://static.wikia.nocookie.net/twicenation/images/b/ba/CelebrateDigitalVersion.jpeg/revision/latest/scale-to-width-down/1000?cb=20220425132016"),
      Album(
          albumName: "IM NAYEON",
          imgUrl:
              "https://static.wikia.nocookie.net/twicenation/images/f/fd/Im_Nayeon_EP_digital_cover.png/revision/latest/scale-to-width-down/1000?cb=20220524073326"),
    ],
    id: "123456789",
  );

  KpopManager? kpopManager;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final uri = Uri.parse(url);
    var response = await http.get(uri);
    var decodedJson = jsonDecode(response.body);
    kpopManager = KpopManager.fromJson(decodedJson);
    debugPrint(decodedJson.toString());
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ArtistDetail(artist: artist),
    );
  }
}
