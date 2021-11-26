import 'package:http/http.dart' as http;
import 'package:pamphlet_app/config/config.dart';
import 'result.dart';
import 'dart:convert';

class ApiService {
  static final ApiService _instance = ApiService._();
  ApiService._();

  static ApiService get instance => _instance;

  String baseURLString = 'https://api.github.com/';

  Future<Result<dynamic>> get(String path, Map<String, String> params) async {
    String urlString = baseURLString + path;
    String authToken = await Config.githubAuthToken();
    final headers = {
      'Authorization': 'token ' + authToken,
      'User-Agent': 'SwiftPamphletApp'
    };
    final url = Uri.parse(urlString);
    try {
      final response = await http.get(url, headers: headers);
      return _handleData(response);
    } catch (error) {
      print('get error: ${error.toString()}');
      return Result(
          ErrorData(-1, {'msg': error.toString()}), ResultType.failure);
    }
  }

  Result<dynamic> _handleData(http.Response response) {
    Map<String, dynamic> result = json.decode(response.body);
    if (response.statusCode == 200) {
      return Result(result, ResultType.success);
    } else {
      return Result(ErrorData(response.statusCode, result), ResultType.failure);
    }
  }
}
