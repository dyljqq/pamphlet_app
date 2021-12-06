import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pamphlet_app/github_api/result.dart';
import 'package:pamphlet_app/model/issue.dart';
import 'package:pamphlet_app/model/issue_comment.dart';
import 'package:pamphlet_app/pages/issue_comment_page.dart';
import 'package:pamphlet_app/utils/time_convert.dart';
import 'package:pamphlet_app/view_model/issue_view_model.dart';
import 'package:pamphlet_app/widgets/issue_user_header_widget.dart';

// ignore: must_be_immutable
class IssuePage extends StatefulWidget {
  IssuePage(this.repoName, this.issueNumber, {Key? key}) : super(key: key);

  String repoName;
  int issueNumber;

  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: IssueViewModel.getIssue(widget.repoName, widget.issueNumber),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget widget = const SizedBox();
        if (snapshot.connectionState == ConnectionState.done) {
          Result<dynamic> result = snapshot.data;
          if (result.type == ResultType.success) {
            Issue issue = result.data;
            if (issue.commentCount > 0) {
              widget = page(result.data);
            } else {
              return IssueCommentPage(
                  this.widget.repoName, issue, IssueComment.fromIssue(issue));
            }
          }
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(this.widget.repoName),
          ),
          body: widget,
        );
      },
    );
  }

  Widget page(Issue issue) {
    return FutureBuilder(
      future: IssueViewModel.comments(issue.commentsUrl),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List rs = snapshot.data;
          rs.insert(0, IssueComment.fromIssue(issue));
          return Container(
            padding: const EdgeInsets.only(left: 12, right: 12),
            margin: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: header(issue),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: rs.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: cell(rs[index]),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return IssueCommentPage(
                              widget.repoName, issue, rs[index]);
                        }));
                      },
                    );
                  },
                ))
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget titleSection(Issue issue) {
    var authorAssociation =
        issue.authorAssociation == 'NONE' ? 'unowner' : 'owner';
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

  Widget header(Issue issue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${issue.title}#${issue.number}',
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 30,
          width: 70,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: issue.state == 'open' ? Colors.green : Colors.red),
          child: Text(
            issue.state,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                issue.user.login,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 10),
                child: Text(
                  'opened this isssue ${convertTime(issue.createdAt)} ago - ${issue.commentCount} comments',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
        const Divider(
          color: Colors.black12,
          height: 2,
        )
      ],
    );
  }

  Widget cell(IssueComment comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IssueUserHeader(
              comment,
              const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
            child: Text(comment.body),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 10),
            child: cellFooter(comment),
          )
        ],
      ),
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

  Widget cellFooter(IssueComment comment) {
    if (comment.reaction.plusOne <= 0) {
      return const SizedBox();
    }
    return SizedBox(
      height: 20,
      width: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.thumb_up,
                size: 15,
                color: Colors.yellow,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  comment.reaction.plusOne.toString(),
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
