import 'package:http/http.dart' as http;
import 'result.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final ApiService _instance = ApiService._();
  ApiService._();

  static ApiService get instance => _instance;

  String baseURLString = 'https://api.github.com/';

  Future<Map<String, dynamic>> get(
      String path, Map<String, String> params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final r = prefs.getString('repo_name');
    if (r != null) {
      return {'code': 200, 'data': json.decode(r)};
    }
    String urlString = baseURLString + path;
    final headers = {
      'Authorization':
          'token admin:enterprise, admin:gpg_key, admin:org, admin:org_hook, admin:public_key, admin:repo_hook, delete:packages, delete_repo, gist, notifications, repo, user, workflow, write:discussion, write:packages',
      'User-Agent': 'SwiftPamphletApp'
    };
    final url = Uri.parse(urlString);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        prefs.setString('repo_name', response.body);
        return {'code': 200, 'data': json.decode(response.body)};
      } else {
        return {'code': response.statusCode, 'msg': '网络出错～'};
      }
    } catch (error) {
      print('get error: ${error.toString()}');
      return {'code': -1, 'msg': 'something was wrong: ${error.toString()}'};
    }
  }

  Result<dynamic> _handleData(http.Response response) {
    Map result = json.decode(response.body);
    if (response.statusCode == 200) {
      return Result(result, ResultType.success);
    } else {
      return Result(ErrorData(response.statusCode, '网络错误'), ResultType.failure);
    }
  }
}
