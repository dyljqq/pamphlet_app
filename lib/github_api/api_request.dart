import 'package:http/http.dart' as http;
import 'package:pamphlet_app/config/config.dart';
import 'result.dart';
import 'dart:convert';

class ApiService {
  static final ApiService _instance = ApiService._();
  ApiService._();

  static ApiService get instance => _instance;

  String baseURLString = 'https://api.github.com/';

  Future<Map<String, String>> headers() async {
    String authToken = await Config.githubAuthToken();
    return {
      'Authorization': 'token ' + authToken,
    };
  }

  Future<Result<dynamic>> get(String path,
      {Map<String, String>? params}) async {
    if (path.startsWith('/')) {
      path = path.replaceFirst('/', '');
    }
    String urlString = baseURLString + path;
    final url = Uri.parse(urlString);
    try {
      final response = await http.get(url, headers: await headers());
      return _handleData(response);
    } catch (error) {
      print('get error: ${error.toString()}');
      return Result(
          ErrorData(-1, {'msg': error.toString()}), ResultType.failure);
    }
  }

  Future<Result<dynamic>> post(String path, Map<String, dynamic> params) async {
    final url = Uri.parse(baseURLString + path);
    try {
      final response = await http.post(url,
          headers: await headers(), body: json.encode(params));
      return _handleData(response);
    } catch (error) {
      print('get error: ${error.toString()}');
      return Result(
          ErrorData(-1, {'msg': error.toString()}), ResultType.failure);
    }
  }

  Result<dynamic> _handleData(http.Response response) {
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      return Result(result, ResultType.success);
    } else {
      return Result(ErrorData(response.statusCode, result), ResultType.failure);
    }
  }
}
