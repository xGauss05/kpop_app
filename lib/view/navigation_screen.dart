import 'package:flutter/material.dart';
import 'package:kpop_app/view/favorite_screen.dart';
import 'package:kpop_app/view/search_screen.dart';
import 'package:kpop_app/theme.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int index = 0;

  final List<Widget> screensList = [
    const SearchScreen(),
    const FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KpopTheme.primaryColor,
        title: const Text('KPOP App'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: KpopTheme.primaryColor,
        currentIndex: index,
        onTap: (value) => setState(() {
          index = value;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: "Favorites",
          ),
        ],
      ),
      body: screensList[index],
    );
  }
}
