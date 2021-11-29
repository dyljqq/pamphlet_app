import 'package:flutter/material.dart';
import 'package:pamphlet_app/config/config.dart';
import 'package:pamphlet_app/pages/developer_page.dart';
import 'package:pamphlet_app/pages/repos_page.dart';

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
    return const DeveloperPage();
  }
}
