import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kpop_app/model/artist.dart';
import 'package:kpop_app/model/kpop_manager.dart';
import 'package:kpop_app/theme.dart';
import 'package:kpop_app/view/screens/artist_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final kpopManager = context.read<Future<KpopManager?>>();
    return Scaffold(
      body: FutureBuilder(
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
            return SearchView(kpopManager: snapshot.data!);
          }
        },
      ),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({
    super.key,
    required this.kpopManager,
  });

  final KpopManager kpopManager;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final controller = TextEditingController();
  List<Idol> results = <Idol>[];

  @override
  void initState() {
    super.initState();
    controller.addListener(onSearchChanged);
  }

  void onSearchChanged() {
    final query = controller.text.trim();

    if (query.isEmpty) return;
    setState(() {
      results = widget.kpopManager.idolList
          .where(
              (idol) => idol.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });

    debugPrint(results.toString());
  }

  @override
  void dispose() {
    controller.removeListener(onSearchChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Example: Nayeon',
              labelText: 'Artist name',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final idol = results[index];
                final group = widget.kpopManager.groupList
                    .firstWhere((group) => group.id == idol.groups.first);
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: IdolListItem(
                    idol: idol,
                    group: group,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IdolListItem extends StatelessWidget {
  const IdolListItem({
    super.key,
    required this.idol,
    required this.group,
  });

  final Group group;
  final Idol idol;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistScreen())),
      child: Container(
        width: 300,
        height: 60,
        decoration: const BoxDecoration(
          color: KpopTheme.mainColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(
                  idol.thumbUrl,
                ),
                radius: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      idol.name,
                      style: KpopTheme.titleTextStyle,
                    ),
                    Text(
                      group.name,
                      style: KpopTheme.subtitleTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
