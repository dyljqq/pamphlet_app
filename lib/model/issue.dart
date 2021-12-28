import 'package:flutter/material.dart';
import 'package:pamphlet_app/model/issue_comment.dart';

class Issue {
  String title;
  String body;
  int number;
  int commentCount;
  String authorAssociation;
  String updatedAt;
  String createdAt;
  String commentsUrl;
  String state;
  IssueUser user;
  IssueCommentReaction reaction;

  Issue(
      this.title,
      this.body,
      this.number,
      this.commentCount,
      this.authorAssociation,
      this.updatedAt,
      this.createdAt,
      this.commentsUrl,
      this.state,
      this.user,
      this.reaction);

  factory Issue.fromJson(Map<String, dynamic> json) {
    IssueUser user = IssueUser.fromJson(json['user']);
    IssueCommentReaction reaction =
        IssueCommentReaction.fromJson(json['reactions']);
    return Issue(
        json['title'],
        json['body'],
        json['number'],
        json['comments'],
        json['author_association'],
        json['updated_at'],
        json['created_at'],
        json['comments_url'],
        json['state'],
        user,
        reaction);
  }
}

class IssueUser {
  String login;
  String avatarUrl;

  IssueUser(this.login, this.avatarUrl);

  factory IssueUser.fromJson(Map<String, dynamic> json) {
    return IssueUser(json['login'], json['avatar_url']);
  }
}

class LocalIssuePage {
  String title;
  IconData? icon;
  String? filename;
  bool? isLocal;
  String? resourceName;

  LocalIssuePage(this.title,
      {this.icon, this.filename, this.isLocal, this.resourceName});
}

class LocalIssueList {
  String name;
  int id;
  List issues;

  LocalIssueList(this.name, this.id, this.issues);

  factory LocalIssueList.fromJson(Map<String, dynamic> json) {
    var issues = json['issues'].map((e) => LocalIssue.fromJson(e)).toList();
    return LocalIssueList(json['name'], json['id'], issues);
  }
}

class LocalIssue {
  int id;
  String title;
  int number;

  LocalIssue(this.id, this.title, this.number);

  factory LocalIssue.fromJson(Map<String, dynamic> json) {
    return LocalIssue(json['id'], json['title'], json['number']);
  }
}
