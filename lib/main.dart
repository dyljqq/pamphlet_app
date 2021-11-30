// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pamphlet_app/pages/developer_page.dart';
import 'package:pamphlet_app/pages/repos_page.dart';

final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const PamphletApp());
}

class PamphletApp extends StatelessWidget {
  const PamphletApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pamphlet App',
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      home: const PamphletHomePage(),
    );
  }
}

class PamphletHomePage extends StatefulWidget {
  const PamphletHomePage({Key? key}) : super(key: key);
  @override
  _PamphletHomePageState createState() => _PamphletHomePageState();
}

class _PamphletHomePageState extends State<PamphletHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Repo'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'User')
        ]),
        tabBuilder: (context, index) {
          if (index == 0) {
            return CupertinoTabView(
              navigatorKey: firstTabNavKey,
              builder: (BuildContext context) => const ReposPage(),
            );
          } else {
            return CupertinoTabView(
              navigatorKey: secondTabNavKey,
              builder: (BuildContext context) => const DeveloperPage(),
            );
          }
        });
  }
}