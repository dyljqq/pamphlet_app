import 'package:flutter/material.dart';
import 'package:pamphlet_app/model/issue.dart';
import 'package:pamphlet_app/model/issue_comment.dart';
import 'package:pamphlet_app/pages/issue_comment_page.dart';
import 'package:pamphlet_app/pages/issue_page.dart';
import 'package:pamphlet_app/pages/issues_page.dart';
import 'package:pamphlet_app/pages/repo_list_page.dart';
import 'package:pamphlet_app/pages/repo_page.dart';
import 'package:pamphlet_app/pages/user_page.dart';

class PARouter {
  static void open(BuildContext context, String url,
      {Map<String, dynamic> params = const {}}) {
    if (url == 'repo') {
      pushRepo(context, params['repoName'],
          rootNavigator: params['rootNavigator']);
    }
  }

  static void pushRepo(BuildContext context, String repoName,
      {bool rootNavigator = false}) {
    Navigator.of(context, rootNavigator: rootNavigator)
        .push(MaterialPageRoute(builder: (context) {
      return RepoPage(repoName: repoName);
    }));
  }

  static void pushUser(BuildContext context, String login,
      {bool rootNavigator = false}) {
    Navigator.of(context, rootNavigator: rootNavigator)
        .push(MaterialPageRoute(builder: (context) {
      return UserPage(login);
    }));
  }

  static void pushIssue(
      BuildContext context, String repoName, int issueNumber) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return IssuePage(repoName, issueNumber);
    }));
  }

  static void pushRepoList(BuildContext context, String login) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RepoListPage(login);
    }));
  }

  static void pushIssueComment(BuildContext context, String repoName,
      Issue issue, IssueComment comment) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return IssueCommentPage(repoName, issue, comment);
    }));
  }

  static void pushIssues(
      BuildContext context, LocalIssuePage issue, rootNavigator) {
    Navigator.of(context, rootNavigator: rootNavigator)
        .push(MaterialPageRoute(builder: (context) {
      return IssuesPage(issue);
    }));
  }
}
