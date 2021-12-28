import 'package:flutter/material.dart';
import 'package:pamphlet_app/github_api/api_request.dart';
import 'package:pamphlet_app/github_api/result.dart';
import 'package:pamphlet_app/model/issue.dart';
import 'package:pamphlet_app/model/issue_comment.dart';
import 'package:pamphlet_app/utils/file_manager.dart';
import 'package:pamphlet_app/utils/resource_manager.dart';

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

  static List<LocalIssuePage> get items {
    return [
      LocalIssuePage('Swift指南'),
      LocalIssuePage('语法速查',
          icon: Icons.functions,
          filename: 'guide_syntex.json',
          resourceName: 'guide-syntax'),
      LocalIssuePage('特性',
          icon: Icons.person,
          filename: 'guide_features.json',
          resourceName: 'guide-features'),
      LocalIssuePage('专题',
          icon: Icons.campaign,
          filename: 'guide_subject.json',
          resourceName: 'guide-subject'),
      LocalIssuePage('库使用指南'),
      LocalIssuePage('Combine',
          icon: Icons.connect_without_contact,
          filename: 'lib_combine.json',
          resourceName: 'lib-Combine'),
      LocalIssuePage('Concurrency',
          icon: Icons.timer,
          filename: 'lib_concurrency.json',
          resourceName: 'lib-Concurrency'),
      LocalIssuePage('SwiftUI',
          icon: Icons.filter_list,
          filename: 'lib_SwiftUI.json',
          resourceName: 'lib-SwiftUI'),
      LocalIssuePage('小册子'),
      LocalIssuePage('小册子议题', icon: Icons.bookmark, isLocal: false)
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

  static Future<List<LocalIssueList>> localIssueList(String filename) async {
    var items = await FileManager.loadDataFromFile('assets/data/$filename');
    List<LocalIssueList> rs = [];
    for (var item in items) {
      rs.add(LocalIssueList.fromJson(item));
    }
    return rs;
  }

  static Future<List<dynamic>> issues() async {
    String path = 'repos/ming1016/SwiftPamphletApp/issues';
    var result = await ApiService.instance.get(path);
    if (result.type == ResultType.success) {
      return result.data.map((e) => Issue.fromJson(e)).toList();
    }
    return [];
  }

  static Future<List> issuesPageData(LocalIssuePage issuePage) async {
    if (issuePage.isLocal != null && !issuePage.isLocal!) {
      return issues();
    }
    List resources = [];
    if (issuePage.resourceName != null &&
        issuePage.resourceName != 'guide-syntax') {
      resources = await getResources(issuePage.resourceName!);
    }
    if (resources.isEmpty) {
      resources = await localIssueList(issuePage.filename ?? '');
    }
    return resources;
  }

  static Future<List> getResources(String resourceName) async {
    return ResourceManager.instance.getResources(resourceName);
  }

  static Future<List> comments(String url) async {
    Uri uri = Uri.parse(url);
    var result = await ApiService.instance.get(uri.path);
    if (result.type == ResultType.success) {
      return result.data.map((e) => IssueComment.fromJson(e)).toList();
    }
    return [];
  }
}
