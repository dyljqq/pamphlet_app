import 'package:pamphlet_app/model/repo.dart';
import 'package:pamphlet_app/view_model/issue_view_model.dart';

import '../github_api/api_request.dart';
import '../github_api/result.dart';

class RepoViewModel {
  static final RepoViewModel _instance = RepoViewModel._();
  RepoViewModel._();

  static RepoViewModel get instance => _instance;

  Future<Result<dynamic>> getRepo(String repoName) async {
    String path = 'repos/' + repoName;
    Result result = await ApiService.instance.get(path);
    switch (result.type) {
      case ResultType.success:
        Repo repo = Repo.fromJson(result.data);
        return Result(repo, result.type);
      case ResultType.failure:
        return result;
    }
  }

  static Future<List<Repo>> repos(String login) async {
    String path = 'users/$login/repos';
    Result result = await ApiService.instance.get(path);
    List<Repo> repos = [];
    if (result.type == ResultType.success) {
      for (var d in result.data) {
        repos.add(Repo.fromJson(d));
      }
    }
    return repos;
  }
}
