import 'package:flutter/material.dart';
import 'package:kpop_app/model/kpop_manager.dart';
import 'package:kpop_app/view/artist_detail.dart';
import 'package:provider/provider.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({
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
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          final artist = snapshot.data!.idolList
              .where((element) => element.name.contains("Nayeon"))
              .elementAt(1);
          final group = snapshot.data!.groupList
              .firstWhere((element) => element.id == artist.groups.first);
          final member = group.members.firstWhere((element) =>
              element.idolId == artist.id && element.current == true);

          return ArtistDetail(artist: artist, group: group, member: member);
        }
      },
    );
  }
}
