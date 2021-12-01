class Issue {
  String title;
  String body;
  IssueUser user;

  Issue(this.title, this.body, this.user);

  factory Issue.fromJson(Map<String, dynamic> json) {
    IssueUser user = IssueUser.fromJson(json['user']);
    return Issue(json['title'], json['body'], user);
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

class LocalIssueList {
  String name;
  int id;
  List issues;

  LocalIssueList(this.name, this.id, this.issues);

  factory LocalIssueList.fromJson(Map<String, dynamic> json) {
    List issues = json['issues'].map((e) => LocalIssue.fromJson(e));
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
