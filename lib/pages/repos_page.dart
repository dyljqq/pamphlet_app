import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pamphlet_app/config/config.dart';
import 'package:pamphlet_app/pages/repo_page.dart';

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
      var child = Row(
        children: [
          Text(e.id,
              style: const TextStyle(
                fontSize: 16,
              ))
        ],
      );
      if (e.des.isNotEmpty) {
        child = Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.id,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
                // const Spacer(),
                Text(
                  e.des,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                )
              ],
            )
          ],
        );
      }
      return GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)]),
          child: child,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return RepoPage(repoName: e.id);
          }));
        },
      );
    }).toList();
  }
}
