import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kpop_app/model/artist.dart';
import 'package:kpop_app/model/kpop_manager.dart';
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

    results = widget.kpopManager.idolList
        .where((idol) => idol.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
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
    return Column(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Example: Nayeon',
              labelText: 'Artist name',
            ),
          ),
        ),
      ],
    );
    ;
  }
}
