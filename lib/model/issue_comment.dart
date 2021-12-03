import 'package:pamphlet_app/model/issue.dart';

class IssueComment {
  int id;
  String body;
  String authorAssociation;
  String createdAt;
  String updatedAt;
  IssueUser user;
  IssueCommentReaction reaction;

  IssueComment(this.id, this.body, this.authorAssociation, this.createdAt,
      this.updatedAt, this.user, this.reaction);

  factory IssueComment.fromJson(Map<String, dynamic> json) {
    IssueUser user = IssueUser.fromJson(json['user']);
    IssueCommentReaction reaction =
        IssueCommentReaction.fromJson(json['reactions']);
    return IssueComment(json['id'], json['body'], json['author_association'],
        json['created_at'], json['updated_at'], user, reaction);
  }

  factory IssueComment.fromIssue(Issue issue) {
    return IssueComment(0, issue.body, issue.authorAssociation, issue.createdAt,
        issue.updatedAt, issue.user, issue.reaction);
  }
}

class IssueCommentReaction {
  String url;
  int totalCount;
  int plusOne;
  int minusOne;

  IssueCommentReaction(this.url, this.totalCount, this.plusOne, this.minusOne);

  factory IssueCommentReaction.fromJson(Map<String, dynamic> json) {
    return IssueCommentReaction(
        json['url'], json['total_count'], json['+1'], json['-1']);
  }
}
