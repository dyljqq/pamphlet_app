import 'dart:convert';

class RepoContent {
  String name;
  String url;
  String type;
  String content;

  RepoContent(this.name, this.url, this.type, this.content);

  factory RepoContent.fromJson(Map<String, dynamic> json) {
    String content = json['content'] ?? '';
    if (content.isNotEmpty) {
      content = content.replaceAll('\n', '');
      content = utf8.decode(base64Decode(content));
    }
    return RepoContent(json['name'], json['url'], json['type'], content);
  }

  bool get isFile {
    return type == 'file';
  }

  bool get isJSONFile {
    if (!isFile) {
      return false;
    }
    List<String> rs = name.split('.');
    return rs.length == 2 && rs[1] == 'json';
  }

  String get filename {
    List<String> rs = name.split('.');
    return rs[0];
  }
}
