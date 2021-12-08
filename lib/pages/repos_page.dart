import 'package:flutter/material.dart';
import 'package:pamphlet_app/config/config.dart';
import 'package:pamphlet_app/utils/route.dart';
import 'package:pamphlet_app/widgets/normal_text_cell_widget.dart';

class ReposPage extends StatefulWidget {
  const ReposPage({Key? key}) : super(key: key);

  @override
  _ReposPageState createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repos'),
      ),
      body: Center(
          child: FutureBuilder(
        future: Config.repos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var repos = snapshot.data;
            return Container(
              color: const Color(0XF8F8F8FF),
              child: page(repos),
            );
          }
          return const Text('unknown things happened...');
        },
      )),
    );
  }

  Widget page(List repos) {
    return ListView.builder(
        itemCount: repos.length,
        itemBuilder: (BuildContext context, int index) {
          SimpleRepos repo = repos[index];
          return cell(repo);
        });
  }

  Widget cell(SimpleRepos repo) {
    List<Widget> childs = [
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          repo.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
    ];
    childs.addAll(repos(repo.repos));
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(top: 10, left: 18, right: 18, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: childs,
        ));
  }

  List<Widget> repos(List<SimpleRepo> repos) {
    return repos.map((e) {
      return NormalTextCell(e.id, description: e.des, callback: () {
        PARouter.pushRepo(context, e.id, rootNavigator: true);
      });
    }).toList();
  }
}
