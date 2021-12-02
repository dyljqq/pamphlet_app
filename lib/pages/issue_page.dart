import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pamphlet_app/github_api/result.dart';
import 'package:pamphlet_app/model/issue.dart';
import 'package:pamphlet_app/view_model/issue_view_model.dart';

// ignore: must_be_immutable
class IssuePage extends StatefulWidget {
  IssuePage(this.repoName, this.issueNumber, {Key? key}) : super(key: key);

  String repoName;
  int issueNumber;

  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  String title = '';

  @override
  void initState() {
    title = '${widget.repoName}:${widget.issueNumber}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: IssueViewModel.getIssue(widget.repoName, widget.issueNumber),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget widget = const SizedBox();
        if (snapshot.connectionState == ConnectionState.done) {
          Result<dynamic> result = snapshot.data;
          if (result.type == ResultType.success) {
            title = (result.data as Issue).title;
            widget = page(result.data);
          }
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: widget,
        );
      },
    );
  }

  Widget page(Issue issue) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 12, top: 12),
        child: titleSection(issue),
      ),
      Expanded(child: bodySection(issue.body))
    ]);
  }

  Widget titleSection(Issue issue) {
    var authorAssociation =
        issue.authorAssociation != 'NONE' ? 'unowner' : 'owner';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(issue.user.avatarUrl),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
            issue.user.login,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Text(
          '($authorAssociation)',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }

  Widget bodySection(String body) {
    return Markdown(
      data: body,
      onTapLink: (text, href, title) {
        print(href);
      },
    );
  }
}