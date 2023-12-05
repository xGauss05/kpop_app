import 'package:flutter/material.dart';
import 'package:kpop_app/model/artist.dart';
import 'package:kpop_app/theme.dart';
import 'package:intl/intl.dart';

class ArtistDetail extends StatefulWidget {
  const ArtistDetail({super.key, required this.artist, required this.group});

  final Idol artist;
  final Group group;

  @override
  State<ArtistDetail> createState() => _ArtistDetailState();
}

class _ArtistDetailState extends State<ArtistDetail> {
  final scrollController = ScrollController();
  final Color appTheme = const Color.fromARGB(255, 240, 55, 108);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme,
        leading: const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 212, 238, 250),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 241, 189, 189),
        child: const Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageSection(artist: widget.artist),
              Align(
                heightFactor: 0.9,
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: screenSize.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 234, 141, 141),
                        Color.fromARGB(255, 255, 221, 225),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 10,
                        blurRadius: 50,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InfoSection(
                          artist: widget.artist,
                          group: widget.group,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appTheme,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
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
    );
  }
}

class InfoData extends StatelessWidget {
  const InfoData({
    super.key,
    required this.name,
    required this.value,
  });

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: KpopTheme.subtitleTextStyle,
        ),
        Text(
          value,
          style: KpopTheme.titleTextStyle,
        ),
      ],
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
    required this.artist,
  });

  final Idol artist;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height / 1.8,
      width: screenSize.width,
      child: Image.network(artist.thumbUrl, fit: BoxFit.cover),
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.artist,
    required this.group,
  });

  final Idol artist;
  final Group group;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "${artist.name} (${artist.nameOriginal})",
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        InfoData(
          name: 'Real name',
          value: "${artist.realName} (${artist.realNameOriginal})",
        ),
        const SizedBox(height: 16),
        InfoData(
          name: 'Alias name',
          value: artist.nameAlias ?? "No data",
        ),
        const SizedBox(height: 16),
        InfoData(
          name: 'Group',
          value: group.name,
        ),
        const SizedBox(height: 16),
        InfoData(
          name: 'Height',
          value: artist.height == null
              ? "No data"
              : "${artist.height!.toInt()} cm",
        ),
        const SizedBox(height: 16),
        InfoData(
          name: "Weight",
          value: artist.weight == null
              ? "No data"
              : "${artist.weight!.toInt()} kg",
        ),
        const SizedBox(height: 16),
        InfoData(
          name: 'Birth date',
          value: DateFormat('yyyy-MM-dd').format(artist.birthDate).toString(),
        ),
        const SizedBox(height: 16),
        InfoData(
          name: 'Debut date',
          value: artist.debutDate == null
              ? "No data"
              : DateFormat('yyyy-MM-dd').format(artist.debutDate!).toString(),
        ),
      ],
    );
  }
}
