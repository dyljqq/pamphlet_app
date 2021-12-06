import 'package:flutter/material.dart';
import 'package:pamphlet_app/model/issue_comment.dart';
import 'package:pamphlet_app/pages/user_page.dart';
import 'package:pamphlet_app/utils/time_convert.dart';

class IssueUserHeader extends StatefulWidget {
  IssueUserHeader(this.issueComment, this.borderRadius, {Key? key})
      : super(key: key);

  IssueComment issueComment;
  BorderRadius borderRadius;

  @override
  _IssueUserHeaderState createState() => _IssueUserHeaderState();
}

class _IssueUserHeaderState extends State<IssueUserHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: widget.borderRadius),
      child: header(widget.issueComment),
    );
  }

  Widget header(IssueComment comment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        avatar(comment.user.avatarUrl, comment.user.login),
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

  Widget avatar(String avatarUrl, String login) {
    return GestureDetector(
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(avatarUrl), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserPage(login);
        }));
      },
    );
  }
}
