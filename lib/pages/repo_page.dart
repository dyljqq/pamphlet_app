import 'package:flutter/material.dart';
import 'package:pamphlet_app/github_api/result.dart';
import 'package:pamphlet_app/model/repo.dart';
import 'package:pamphlet_app/utils/route.dart';
import '../view_model/repo_view_model.dart';
import 'package:pamphlet_app/utils/time_convert.dart';

class RepoPage extends StatefulWidget {
  final String repoName;

  const RepoPage({Key? key, required this.repoName}) : super(key: key);

  @override
  _RepoPageState createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.repoName),
        ),
        body: Center(
            child: FutureBuilder<Result<dynamic>>(
          future: RepoViewModel.instance.getRepo(widget.repoName),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Result<dynamic> result = snapshot.data;
              switch (result.type) {
                case ResultType.success:
                  return Container(
                      color: const Color(0XF8F8F8FF), child: page(result.data));
                case ResultType.failure:
                  break;
              }
            }
            return const Center(
              child: Text('Loading...'),
            );
          },
        )));
  }

  Widget page(Repo repo) {
    var size = repo.license != null
        ? '${repo.license?.key} * ${repo.size ~/ 1000}MB'
        : '';
    List<CellData> data = [
      CellData(
          Icons.code, repo.language.isEmpty ? 'Language' : repo.language, size),
      CellData(Icons.sync_problem, 'Issues', repo.openIssuesCount.toString()),
      CellData(Icons.assignment, 'Pull Requests', ''),
      CellData(Icons.chair_rounded, 'Branches', 'main')
    ];
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.white,
          child: header(repo),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 12),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final cellData = data[index];
              return Container(
                color: Colors.white,
                height: 44,
                child: cell(cellData.icon, cellData.title, cellData.desc),
              );
            },
          ),
        )
      ],
    );
  }

  Widget header(Repo repo) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 30),
          child: titleSection(repo),
        ),
        Row(
          children: [
            Expanded(
              child: repoCount('Watches', repo.watchersCount),
            ),
            Expanded(
              child: repoCount('Stars', repo.starCount),
            ),
            Expanded(
              child: repoCount('Forks', repo.forksCount),
            )
          ],
        )
      ],
    );
  }

  Widget titleSection(Repo repo) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: NetworkImage(repo.user.avatar), fit: BoxFit.cover)),
          ),
          onTap: () {
            PARouter.pushUser(context, repo.user.login);
          },
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  repo.fullName,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              Text(repo.description),
              Text(
                repo.url,
                style: const TextStyle(color: Colors.blue),
              ),
              Text(
                'Updated ' + convertTime(repo.updatedAt) + ' ago',
                style: const TextStyle(color: Colors.black87),
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget repoCount(String title, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            count.toString(),
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  Widget cell(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(icon, size: 24),
          ),
          Expanded(
              child: Text(title,
                  style: const TextStyle(color: Colors.black, fontSize: 14))),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              desc,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          const Image(
              image: AssetImage('images/arrows_right.png'),
              width: 7,
              height: 13)
        ],
      ),
    );
  }
}

class CellData {
  IconData icon;
  String title;
  String desc;

  CellData(this.icon, this.title, this.desc);
}
