import 'package:flutter/material.dart';
import 'package:pamphlet_app/model/issue.dart';
import 'package:pamphlet_app/pages/issues_page.dart';
import 'package:pamphlet_app/view_model/issue_view_model.dart';

class LocalIssuesPage extends StatefulWidget {
  const LocalIssuesPage({Key? key}) : super(key: key);

  @override
  _LocalIssuesPageState createState() => _LocalIssuesPageState();
}

class _LocalIssuesPageState extends State<LocalIssuesPage> {
  List<LocalIssuePage> issues = IssueViewModel.items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swift Pamphlet'),
      ),
      body: page(),
    );
  }

  Widget page() {
    return ListView.builder(
      itemCount: issues.length,
      itemBuilder: (BuildContext context, int index) {
        LocalIssuePage issue = issues[index];
        Widget cell;
        if (issue.icon != null) {
          cell = Row(
            children: [
              Icon(issue.icon),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(issue.title,
                    style: const TextStyle(fontSize: 12, color: Colors.black)),
              )
            ],
          );
        } else {
          cell = Text(
            issue.title,
            style: const TextStyle(fontSize: 16, color: Colors.black26),
          );
        }
        return Container(
            height: 44,
            padding: const EdgeInsets.only(left: 14),
            alignment: Alignment.centerLeft,
            child: issue.icon != null
                ? GestureDetector(
                    child: cell,
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(builder: (context) {
                        return IssuesPage(issue);
                      }));
                    })
                : cell);
      },
    );
  }
}
