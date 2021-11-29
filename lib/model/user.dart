class User {
  int id;
  String login;
  String url;
  String avatar;
  String followersUrl;
  String followingUrl;

  int publicReposCount = 0;
  int followers = 0;
  int followings = 0;
  String updatedAt = '';
  String createdAt = '';
  String name = '';
  String company = '';
  String blog = '';
  String location = '';
  String bio = '';
  String email = '';

  User(
      {required this.id,
      required this.login,
      required this.url,
      required this.avatar,
      required this.followersUrl,
      required this.followingUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    User user = User(
        id: json['id'] as int,
        login: json['login'],
        url: json['url'],
        avatar: json['avatar_url'],
        followersUrl: json['followers_url'],
        followingUrl: json['following_url']);
    user.publicReposCount = json['public_repos'] ?? 0;
    user.followers = json['followers'] ?? 0;
    user.followings = json['following'] ?? 0;
    user.updatedAt = json['updated_at'] ?? '';
    user.createdAt = json['created_at'] ?? '';
    user.name = json['name'] ?? '';
    user.company = json['company'] ?? '';
    user.blog = json['blog'] ?? '';
    user.location = json['location'] ?? '';
    user.bio = json['bio'] ?? '';
    user.email = json['email'] ?? '';
    return user;
  }
}
