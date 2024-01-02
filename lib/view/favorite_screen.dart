import 'package:flutter/material.dart';
import 'package:kpop_app/model/idol.dart';
import 'package:provider/provider.dart';
import 'package:kpop_app/model/kpop_manager.dart';

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
  List<Idol> favorites = [];
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    controller.addListener(onSearchChanged);
    widget.kpopManager.getFavorites();
  }

  void onSearchChanged() {
    final query = controller.text.trim();

    if (query.isEmpty) return;
    setState(() {
      favorites = widget.kpopManager.idolList
          .where(
              (idol) => idol.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
              itemCount: favorites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                return GridTile(
                  header: const Text("Header"),
                  footer: const Text("footer"),
                  child: Center(
                    child: Text(
                      "$index",
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
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
