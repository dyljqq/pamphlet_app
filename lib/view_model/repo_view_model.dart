import '../model/repo.dart';
import '../github_api/api_request.dart';
import '../github_api/result.dart';

class RepoViewModel {
  static final RepoViewModel _instance = RepoViewModel._();
  RepoViewModel._();

  static RepoViewModel get instance => _instance;

  Future<Result<dynamic>> getRepo(String repoName) async {
    String path = 'repos/' + repoName;
    Map<String, dynamic> json = await ApiService.instance.get(path, {});
    int code = json['code'];
    if (code == 200) {
      Repo repo = Repo.fromJson(json['data']);
      return Result(repo, ResultType.success);
    } else {
      return Result(ErrorData(code, 'something wrong.'), ResultType.failure);
    }
  }
}
