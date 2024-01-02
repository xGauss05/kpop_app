import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kpop_app/model/idol.dart';
import 'package:kpop_app/model/group.dart';
import 'package:kpop_app/model/member.dart';
import 'package:kpop_app/model/kpop_manager.dart';
import 'package:kpop_app/view/idol_screen.dart';
import 'package:kpop_app/theme.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final kpopManager = context.read<Future<KpopManager?>>();
    return FutureBuilder(
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
          return FavoriteView(kpopManager: snapshot.data!);
        }
      },
    );
  }
}

class FavoriteView extends StatefulWidget {
  const FavoriteView({
    super.key,
    required this.kpopManager,
  });

  final KpopManager kpopManager;

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final controller = TextEditingController();
  List<Idol> searchResults = <Idol>[];

  @override
  void initState() {
    super.initState();
    controller.addListener(onSearchChanged);
    widget.kpopManager.getFavorites().then((a) {
      setState(() {
        searchResults = widget.kpopManager.favoriteList;
      });
    });
  }


  void onSearchChanged() {
    final query = controller.text.trim();

    setState(() {
      if (query.isEmpty) {
        searchResults = widget.kpopManager.favoriteList;
      } else {
        searchResults = widget.kpopManager.favoriteList
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
          const Text("Your favourite KPOP idols list"),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Example: Nayeon',
              labelText: 'Search artist name',
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: searchResults.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 200,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final idol = searchResults[index];
                final group = widget.kpopManager.groupList.firstWhereOrNull(
                    (group) => group.id == idol.groups.firstOrNull);
                final member = group?.members.firstWhereOrNull((element) =>
                    element.idolId == idol.id && element.current == true);

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: IdolGridItem(
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

class IdolGridItem extends StatelessWidget {
  const IdolGridItem({
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
      child: GridTile(
        child: Container(
          decoration: const BoxDecoration(
            color: KpopTheme.subColor,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(
                  idol.thumbUrl,
                ),
                radius: 50,
              ),
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
      ),
    );
  }
}
