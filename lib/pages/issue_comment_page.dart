import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart';
import 'package:pamphlet_app/model/issue.dart';
import 'package:pamphlet_app/model/issue_comment.dart';
import 'package:pamphlet_app/utils/time_convert.dart';

class IssueCommentPage extends StatefulWidget {
  IssueCommentPage(this.repoName, this.issue, this.comment, {Key? key})
      : super(key: key);

  String repoName;
  Issue issue;
  IssueComment comment;

  @override
  _IssueCommentPageState createState() => _IssueCommentPageState();
}

class _IssueCommentPageState extends State<IssueCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.repoName),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
        child: Column(
          children: [
            header(widget.issue),
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5)),
              child: cellHeader(widget.comment),
            ),
            Expanded(
              child: Markdown(data: widget.comment.body),
            )
          ],
        ),
      ),
    );
  }

  Widget header(Issue issue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${issue.title}#${issue.number}',
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const Divider(
          color: Colors.black12,
          height: 2,
        )
      ],
    );
  }

  Widget cellHeader(IssueComment comment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(right: 3),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(comment.user.avatarUrl), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(comment.user.login,
              style: const TextStyle(fontSize: 12, color: Colors.black)),
        ),
        Text(
          'commented ${convertTime(comment.updatedAt)} ago',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }
}
