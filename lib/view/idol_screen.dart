import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kpop_app/model/idol.dart';
import 'package:kpop_app/model/group.dart';
import 'package:kpop_app/model/member.dart';
import 'package:kpop_app/model/kpop_manager.dart';
import 'package:kpop_app/theme.dart';

class IdolScreen extends StatefulWidget {
  const IdolScreen(
      {super.key,
      required this.idol,
      required this.group,
      required this.member});

  final Idol idol;
  final Group? group;
  final Member? member;

  @override
  State<IdolScreen> createState() => _IdolScreenState();
}

class _IdolScreenState extends State<IdolScreen> {
  final scrollController = ScrollController();
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final kpopManager = context.read<Future<KpopManager?>>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KpopTheme.primaryColor,
      ),
      backgroundColor: KpopTheme.backgroundColor,
      floatingActionButton: FutureBuilder(
        future: kpopManager,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.favoriteList.contains(widget.idol)) {
              isFavorite = true;
            } else {
              isFavorite = false;
            }
          }
          return FloatingActionButton(
            onPressed: () async {
              setState(() {
                if (isFavorite) {
                  snapshot.data!.removeFavorite(widget.idol);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Removed ${widget.idol.name} from your favorites list.",
                      ),
                    ),
                  );
                  isFavorite = false;
                } else {
                  snapshot.data!.addFavorite(widget.idol);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Added ${widget.idol.name} to your favorites list.",
                      ),
                    ),
                  );
                  isFavorite = true;
                }
              });
            },
            backgroundColor: KpopTheme.buttonColor,
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
              color: Colors.red,
            ),
          );
        },
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageSection(artist: widget.idol),
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
                        KpopTheme.mainColor,
                        KpopTheme.subColor,
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
                          artist: widget.idol,
                          group: widget.group,
                          member: widget.member,
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
    required this.member,
  });

  final Idol artist;
  final Group? group;
  final Member? member;

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
          value: group?.name ?? "No data",
        ),
        const SizedBox(height: 16),
        InfoData(
          name: 'Role',
          value: member?.roles ?? "No data",
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
