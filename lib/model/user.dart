class User {
  int id;
  String name;
  String url;
  String avatar;
  String followersUrl;
  String followingUrl;

  User(
      {required this.id,
      required this.name,
      required this.url,
      required this.avatar,
      required this.followersUrl,
      required this.followingUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as int,
        name: json['login'],
        url: json['url'],
        avatar: json['avatar_url'],
        followersUrl: json['followers_url'],
        followingUrl: json['following_url']);
  }
}
