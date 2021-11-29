import 'package:pamphlet_app/github_api/api_request.dart';
import 'package:pamphlet_app/github_api/result.dart';
import 'package:pamphlet_app/model/user.dart';

class UserViewModel {
  static Future<Result<dynamic>> getUserInfo(String name) async {
    String path = 'users/' + name;
    var result = await ApiService.instance.get(path, {});
    switch (result.type) {
      case ResultType.success:
        User user = User.fromJson(result.data);
        return Result(user, result.type);
      case ResultType.failure:
        return result;
    }
  }
}
