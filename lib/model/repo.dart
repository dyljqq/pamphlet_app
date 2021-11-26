import 'user.dart';
import 'license.dart';

class Repo {
  int id;
  String name;
  String description;
  String fullName = '';
  String url = '';
  String updatedAt = '';

  int starCount;
  int watchersCount;
  int forksCount;

  String language;
  int openIssuesCount;
  int size;

  User user;
  License license;
  // List topics;

  Repo(
      this.id,
      this.name,
      this.description,
      this.fullName,
      this.url,
      this.updatedAt,
      this.starCount,
      this.watchersCount,
      this.forksCount,
      this.language,
      this.openIssuesCount,
      this.size,
      this.user,
      this.license);

  factory Repo.fromJson(Map<String, dynamic> json) {
    User user = User.fromJson(json['owner']);
    License license = License.fromJson(json['license']);
    List topics = [];
    for (var topic in json['topics']) {
      topics.add(topic);
    }
    return Repo(
        json['id'],
        json['name'],
        json['description'],
        json['full_name'],
        json['url'],
        json['updated_at'],
        json['stargazers_count'],
        json['watchers_count'],
        json['forks_count'],
        json['language'],
        json['open_issues_count'],
        json['size'],
        user,
        license);
  }
}
