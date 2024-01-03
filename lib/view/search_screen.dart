import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kpop_app/model/idol.dart';
import 'package:kpop_app/model/group.dart';
import 'package:kpop_app/model/member.dart';
import 'package:kpop_app/model/kpop_manager.dart';
import 'package:kpop_app/view/idol_screen.dart';
import 'package:kpop_app/theme.dart';

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
              body: Center(
                child: CircularProgressIndicator(),
              ),
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
    widget.kpopManager.getFavorites();
    results = widget.kpopManager.idolList;
  }

  void onSearchChanged() {
    final query = controller.text.trim();

    setState(() {
      if (query.isEmpty) {
        results = widget.kpopManager.idolList;
      } else {
        results = widget.kpopManager.idolList
            .where(
                (idol) => idol.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Search for a KPOP idol"),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Example: Nayeon',
              labelText: 'Search idol name',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final idol = results[index];
                final group = widget.kpopManager.groupList.firstWhereOrNull(
                    (group) => group.id == idol.groups.firstOrNull);
                final member = group?.members.firstWhereOrNull((element) =>
                    element.idolId == idol.id && element.current == true);
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: IdolListItem(
                    idol: idol,
                    group: group,
                    member: member,
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
    required this.member,
  });

  final Group? group;
  final Idol idol;
  final Member? member;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IdolScreen(
            idol: idol,
            group: group,
            member: member,
          ),
        ),
      ),
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
                      group?.name ?? "No data",
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
