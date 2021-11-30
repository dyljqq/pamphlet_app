import 'package:pamphlet_app/github_api/api_request.dart';
import 'package:pamphlet_app/github_api/result.dart';
import 'package:pamphlet_app/model/user.dart';
import 'package:pamphlet_app/model/user_contribution.dart';

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

  static Future<Result<dynamic>> getUserContributions(String name) async {
    String path = 'graphql';
    var body = {
      "query": '''query {
            user(login: "$name") {
              name
              contributionsCollection {
                contributionCalendar {
                  colors
                  totalContributions
                  weeks {
                    contributionDays {
                      color
                      contributionCount
                      date
                      weekday
                    }
                    firstDay
                  }
                }
              }
            }
          }'''
    };
    Result<dynamic> result = await ApiService.instance.post(path, body);
    switch (result.type) {
      case ResultType.success:
        if (result.data['errors'] == null) {
          var r = result.data['data']['user']['contributionsCollection']
              ['contributionCalendar'];
          UserContribution userContribution = UserContribution.fromJson(r);
          return Result(userContribution, result.type);
        }
        return Result(result.data, ResultType.failure);
      case ResultType.failure:
        return result;
    }
  }
}
