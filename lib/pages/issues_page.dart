import 'package:flutter/material.dart';
import 'package:pamphlet_app/model/issue.dart';
import 'package:pamphlet_app/pages/issue_page.dart';
import 'package:pamphlet_app/view_model/issue_view_model.dart';

class IssuesPage extends StatefulWidget {
  const IssuesPage(this.filename, this.title, {Key? key}) : super(key: key);

  final String filename;
  final String title;

  @override
  _IssuesPageState createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: IssueViewModel.localIssueList(widget.filename),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<LocalIssueList> items = snapshot.data;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return cell(items[index]);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget page(List<LocalIssueList> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return cell(items[index]);
      },
    );
  }

  Widget cell(LocalIssueList issue) {
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
