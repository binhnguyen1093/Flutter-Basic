import 'package:finalprojectcoin/screen/favouritecoins.dart';
import 'package:finalprojectcoin/screen/searchcoins.dart';
import 'package:finalprojectcoin/screen/top100coins.dart';
import 'package:finalprojectcoin/screen/top5coins.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int indexBottom = 0;
  var listscreen = [
    Top100Coins(),
    Top5Coins(),
    SearchCoins(),
    FavouriteCoins()
  ];

  var titlescreen = <String>[
    'Top 100 Coins',
    'Top 5 Coins',
    'Search',
    'Favorite'
  ];

  void tabBottom(int bottomIndex) {
    setState(() {
      indexBottom = bottomIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: listscreen[indexBottom],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrangeAccent,
        unselectedItemColor: Colors.grey,
        onTap: (value) => tabBottom(value),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: indexBottom,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Top 100 Coins'),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit_sharp), label: 'Top 5 Coins'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
    );
  }

  buildAppBar() => AppBar(
        centerTitle: true,
        title: Text(titlescreen[indexBottom]),
      );
}
