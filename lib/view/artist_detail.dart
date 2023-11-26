import 'package:flutter/material.dart';
import 'package:kpop_app/model/artist.dart';
import 'package:kpop_app/theme.dart';

class ArtistDetail extends StatefulWidget {
  const ArtistDetail({super.key, required this.artist});

  final Artist artist;

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
      body: SingleChildScrollView(
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
                      child: InfoSection(artist: widget.artist),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Album list",
                        style: KpopTheme.titleTextStyle,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: widget.artist.albumList
                            .map((album) => AlbumWidget(album: album))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height / 1.8,
      width: screenSize.width,
      child: Image.network(artist.imgUrl, fit: BoxFit.cover),
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.artist,
  });

  final Artist artist;

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
                artist.realName,
                style: const TextStyle(fontSize: 50),
              ),
            ),
            IconButton(
                icon: const Icon(
                  Icons.favorite,
                  size: 24,
                  color: Colors.red,
                ),
                onPressed: () {}),
          ],
        ),
        InfoData(
          name: 'Artist name',
          value: artist.artistName,
        ),
        const SizedBox(height: 16),
        InfoData(
          name: 'Group',
          value: artist.group,
        ),
        const SizedBox(height: 16),
        InfoData(
          name: 'Role',
          value: artist.role,
        ),
        const SizedBox(height: 16),
        InfoData(
          name: 'Debut date',
          value: artist.debutDate,
        ),
        const SizedBox(height: 16),
        Text(
          "About",
          style: KpopTheme.titleTextStyle,
        ),
        Text(
          artist.about,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class AlbumWidget extends StatelessWidget {
  const AlbumWidget({super.key, required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 205,
      width: 160,
      child: Column(
        children: [
          Image.network(
            album.imgUrl,
            fit: BoxFit.fitWidth,
          ),
          Text(
            album.albumName,
            style: KpopTheme.subtitleTextStyle,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
