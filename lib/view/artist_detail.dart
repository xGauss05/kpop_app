import 'package:flutter/material.dart';
import 'package:kpop_app/model/artist.dart';

class ArtistDetail extends StatelessWidget {
  const ArtistDetail({super.key, required this.artist});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ImageSection(
            artist: artist,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: screenSize.width,
            height: screenSize.height / 2.5,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      artist.realName,
                      style: const TextStyle(fontSize: 50),
                    ),
                    Text("Artist name: ${artist.artistName}"),
                    Text("Group: ${artist.group}"),
                  ],
                ),
              ),
            ),
          ),
        )
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
    return Stack(
      children: [
        SizedBox(
          height: screenSize.height / 1.8,
          width: screenSize.width,
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(
              artist.imgUrl,
            ),
          ),
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
