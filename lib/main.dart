import 'package:flutter/material.dart';
import 'pages/repo_page.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pamphlet app'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: RepoPage(repoName: 'onevcat/Kingfisher'),
        ),
      ),
    );
  }
}
