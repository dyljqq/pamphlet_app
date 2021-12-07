import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pamphlet_app/model/repo.dart';
import 'package:pamphlet_app/utils/color_utils.dart';
import 'package:pamphlet_app/view_model/repo_view_model.dart';

class RepoListPage extends StatefulWidget {
  RepoListPage(this.login, {Key? key}) : super(key: key);

  String login;

  @override
  _RepoListPageState createState() => _RepoListPageState();
}

class _RepoListPageState extends State<RepoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.login),
      ),
      body: FutureBuilder(
        future: RepoViewModel.repos(widget.login),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Repo> repos = snapshot.data;
            return ListView.builder(
              itemCount: repos.length,
              itemBuilder: (BuildContext context, int index) {
                Repo repo = repos[index];
                return cell(repo);
              },
            );
          }
          return const Center(
            child: Text('loading....'),
          );
        },
      ),
    );
  }

  Widget cell(Repo repo) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(repo.user.avatar), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10)),
          ),
          info(repo)
        ],
      ),
    );
  }

  Widget info(Repo repo) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              repo.fullName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                repo.description,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            Text(
              'Updated on ${DateFormat('yyyy-MM-dd').format(DateTime.parse(repo.updatedAt))}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: cellFooter(repo),
            )
          ],
        ),
      ),
    );
  }

  Widget cellFooter(Repo repo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        footerItem(Icons.circle, repo.language,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
        footerItem(Icons.star, repo.starCount.toString()),
        footerItem(Icons.bar_chart, repo.forksCount.toString())
      ],
    );
  }

  Widget footerItem(IconData icon, String text, {Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        color != null
            ? Icon(
                icon,
                size: 15,
                color: color,
              )
            : Icon(
                icon,
                size: 15,
              ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
        )
      ],
    );
  }
}
