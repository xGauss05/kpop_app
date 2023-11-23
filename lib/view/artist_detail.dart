import 'package:flutter/material.dart';
import 'package:kpop_app/model/artist.dart';

class ArtistDetail extends StatefulWidget {
  const ArtistDetail({super.key, required this.artist});

  final Artist artist;

  @override
  State<ArtistDetail> createState() => _ArtistDetailState();
}

class _ArtistDetailState extends State<ArtistDetail> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
              alignment: Alignment.bottomCenter,
              child: Container(
                width: screenSize.width,
                height: screenSize.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.artist.realName,
                          style: const TextStyle(fontSize: 50),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Artist name: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Flexible(child: Text(widget.artist.artistName)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Group: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Flexible(child: Text(widget.artist.group)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Debut date: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Flexible(child: Text(widget.artist.debutDate)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Role: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Flexible(child: Text(widget.artist.role)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Apple URL: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Flexible(child: Text(widget.artist.appleUrl)),
                          ],
                        ),
                        const Text(
                          "About",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(widget.artist.about),
                        const Text("Album list"),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widget.artist.albumList
                                .map(
                                  (album) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          album.imgUrl,
                                          width: 100,
                                          height: 100,
                                        ),
                                        Text(album.albumName),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
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

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
    required this.artist,
  });

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          height: screenSize.height / 1.8,
          width: screenSize.width,
          child: Image.network(artist.imgUrl, fit: BoxFit.cover),
        ),
        const Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.favorite_border),
          ),
        ),
      ],
    );
  }
}
