import 'package:pamphlet_app/model/repo.dart';

import '../github_api/api_request.dart';
import '../github_api/result.dart';

class RepoViewModel {
  static final RepoViewModel _instance = RepoViewModel._();
  RepoViewModel._();

  static RepoViewModel get instance => _instance;

  Future<Result<dynamic>> getRepo(String repoName) async {
    String path = 'repos/' + repoName;
    Result result = await ApiService.instance.get(path, {});
    switch (result.type) {
      case ResultType.success:
        Repo repo = Repo.fromJson(result.data);
        return Result(repo, result.type);
      case ResultType.failure:
        return result;
    }
  }
}
