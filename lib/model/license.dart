class License {
  String name;
  String key;
  String url;

  License(this.name, this.key, this.url);

  factory License.fromJson(Map<String, dynamic> json) {
    return License(json['name'], json['key'], json['url']);
  }
}
