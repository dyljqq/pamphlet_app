import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pamphlet_app/model/issue.dart';
import 'package:pamphlet_app/pages/issue_page.dart';
import 'package:pamphlet_app/view_model/issue_view_model.dart';

class IssuesPage extends StatefulWidget {
  const IssuesPage(this.localIssue, {Key? key}) : super(key: key);

  final LocalIssuePage localIssue;

  @override
  _IssuesPageState createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.localIssue.title),
      ),
      body: FutureBuilder(
        future: IssueViewModel.issuesPageData(widget.localIssue),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List items = snapshot.data;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                if (widget.localIssue.isLocal != null &&
                    !widget.localIssue.isLocal!) {
                  return GestureDetector(
                    child: cell(items[index]),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return IssuePage(
                            'SwiftPamphletApp', items[index].number);
                      }));
                    },
                  );
                } else {
                  return localCell(items[index]);
                }
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget cell(Issue issue) {
    var date = DateTime.parse(issue.updatedAt);
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 10, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              issue.title,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Text(
            DateFormat('yyyy-MM-dd').format(date),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget localCell(LocalIssueList issue) {
    List<Widget> childs = [
      Padding(
        padding: const EdgeInsets.only(left: 12, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              issue.name,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const Divider(
              height: 1,
            )
          ],
        ),
      )
    ];
    List<Widget> cs = issue.issues.map((e) {
      return GestureDetector(
        child: Container(
          height: 30,
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            (e.title),
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return IssuePage('SwiftPamphletApp', (e as LocalIssue).number);
          }));
        },
      );
    }).toList();
    childs.addAll(cs);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: childs);
  }
}
