import '../utils/file_manager.dart';

class Config {
  static const githubHost = '"https://github.com/';

  static Future<List> repos() async {
    String filename = 'assets/data/repos.json';
    var r = await FileManager.loadDataFromFile(filename);
    var repos = r.map((e) => SimpleRepos.fromJson(e));
    return repos.toList();
  }

  static Future<String> githubAuthToken() async {
    var r = await FileManager.loadDataFromFile('assets/data/auth_token.json');
    return r['authToken'];
  }

  static Future<List> developers() async {
    String filename = 'assets/data/developers.json';
    var r = await FileManager.loadDataFromFile(filename);
    return r.map((e) => Developer.fromJson(e)).toList();
  }
}

class SimpleRepos {
  String name;
  int id;
  List<SimpleRepo> repos;

  SimpleRepos(this.name, this.id, this.repos);

  factory SimpleRepos.fromJson(Map<String, dynamic> json) {
    List<SimpleRepo> repos = [];
    for (Map<String, dynamic> r in json['repos']) {
      repos.add(SimpleRepo(r['id'], r['des'] ?? ''));
    }
    return SimpleRepos(json['name'], json['id'], repos);
  }
}

class SimpleRepo {
  String id;
  String des;

  SimpleRepo(this.id, this.des);

  factory SimpleRepo.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();
    String des = json['des'].toString();
    return SimpleRepo(id, des);
  }
}

class Developer {
  String name;
  int id;
  List<DevelopeUser> users;

  Developer(this.name, this.id, this.users);

  factory Developer.fromJson(Map<String, dynamic> json) {
    List<DevelopeUser> users = [];
    for (var user in json['users']) {
      users.add(DevelopeUser.fromJson(user));
    }
    return Developer(json['name'], json['id'], users);
  }
}

class DevelopeUser {
  String id;
  String des;

  DevelopeUser(this.id, this.des);

  factory DevelopeUser.fromJson(Map<String, dynamic> json) {
    return DevelopeUser(json['id'], json['des'] ?? '');
  }
}
