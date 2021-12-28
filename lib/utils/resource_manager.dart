import 'dart:convert';

import 'package:pamphlet_app/config/config.dart';
import 'package:pamphlet_app/github_api/api_request.dart';
import 'package:pamphlet_app/github_api/result.dart';
import 'package:pamphlet_app/model/issue.dart';
import 'package:pamphlet_app/model/repo_content.dart';

class ResourceManager {
  static final ResourceManager _instance = ResourceManager._();
  ResourceManager._();

  static ResourceManager get instance => _instance;

  Future<Map<String, RepoContent>> getResourceMapping() async {
    Map<String, RepoContent> resourceMapping = {};
    String path =
        'repos/ming1016/SwiftPamphletApp/contents/SwiftPamphletApp/Resource';
    Result r = await ApiService.instance.get(path);
    if (r.type == ResultType.success) {
      for (var d in r.data) {
        RepoContent content = RepoContent.fromJson(d);
        if (content.isJSONFile) {
          resourceMapping[content.filename] = content;
        }
      }
      return resourceMapping;
    }
    return {};
  }

  Future<List> getRepos() async {
    List rs = await getData('goodrepos');
    return rs.map((e) => SimpleRepos.fromJson(e)).toList();
  }

  Future<List> getDevelopers() async {
    List rs = await getData('developers');
    rs.add({
      'name': '原作者',
      'id': 1234,
      'users': [
        {"id": "dyljqq", "des": "repo owner"}
      ]
    });
    return rs.map((e) => Developer.fromJson(e)).toList();
  }

  Future<List> getResources(String name) async {
    List rs = await getData(name);
    return rs.map((e) => LocalIssueList.fromJson(e)).toList();
  }

  Future<List> getData(String name) async {
    Map<String, RepoContent> resourceMapping = await getResourceMapping();
    RepoContent repoContent = resourceMapping[name]!;
    var result = await ApiService.instance.getByUrl(repoContent.url);
    if (result.type == ResultType.success) {
      RepoContent content = RepoContent.fromJson(result.data);
      return json.decode(content.content);
    }
    return [];
  }
}
