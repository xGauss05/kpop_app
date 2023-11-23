import 'package:flutter/material.dart';
import 'package:kpop_app/model/artist.dart';

class ArtistDetail extends StatelessWidget {
  const ArtistDetail({super.key, required this.artist});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageSection(artist: artist),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(children: [
          ImageBackground(artist: artist),
          const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.favorite_border),
              ))
        ]),
      ],
    );
  }
}

class ImageBackground extends StatelessWidget {
  const ImageBackground({
    super.key,
    required this.artist,
  });

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final scrS = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          width: scrS.width,
          fit: BoxFit.contain,
          image: NetworkImage(
            artist.imgUrl,
          ),
        ),
      ],
    );
  }
}
