import 'package:pamphlet_app/github_api/api_request.dart';
import 'package:pamphlet_app/github_api/result.dart';
import 'package:pamphlet_app/model/issue.dart';

class IssueViewModel {
  static List<String> get filenames {
    return [
      'guide_features.json',
      'guide_subject.json',
      'guide_syntex.json',
      'lib_combine.json',
      'lib_concurrency.json',
      'lib_SwiftUI.json'
    ];
  }

  static Future<Result<dynamic>> getIssue(
      String repoName, int issueNumber) async {
    String path = 'repos/ming1016/$repoName/issues/$issueNumber';
    var result = await ApiService.instance.get(path);
    if (result.type == ResultType.success) {
      return Result(Issue.fromJson(result.data), ResultType.success);
    }
    return result;
  }
}
