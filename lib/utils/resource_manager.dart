import 'dart:convert';

import 'package:pamphlet_app/config/config.dart';
import 'package:pamphlet_app/github_api/api_request.dart';
import 'package:pamphlet_app/github_api/result.dart';
import 'package:pamphlet_app/model/repo_content.dart';

class ResourceManager {
  static final ResourceManager _instance = ResourceManager._();
  ResourceManager._();

  static ResourceManager get instance => _instance;

  Map<String, RepoContent> resourceMapping = {};

  Future<List<RepoContent>> getResources() async {
    resourceMapping = {};
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
      return resourceMapping.values.toList();
    }
    return [];
  }

  Future<List> getRepos() async {
    if (resourceMapping.isEmpty) {
      await getResources();
    }
    var repoContent = resourceMapping['goodrepos']!;
    var result = await ApiService.instance.getByUrl(repoContent.url);
    if (result.type == ResultType.success) {
      RepoContent content = RepoContent.fromJson(result.data);
      var rs = json.decode(content.content);
      return rs.map((e) => SimpleRepos.fromJson(e)).toList();
    }
    return [];
  }

  Future<List> getDevelopers() async {
    if (resourceMapping.isEmpty) {
      await getResources();
    }

    var developerContent = resourceMapping['developers']!;
    var result = await ApiService.instance.getByUrl(developerContent.url);
    if (result.type == ResultType.success) {
      RepoContent content = RepoContent.fromJson(result.data);
      List rs = json.decode(content.content);
      rs.add({
        'name': '原作者',
        'id': 1234,
        'users': [
          {"id": "dyljqq", "des": "repo owner"}
        ]
      });
      return rs.map((e) => Developer.fromJson(e)).toList();
    }
    return [];
  }
}
