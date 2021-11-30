class UserContribution {
  int totalContributions;
  List colors;
  List<UserContributionItem> items;

  UserContribution(this.totalContributions, this.colors, this.items);

  factory UserContribution.fromJson(Map<String, dynamic> json) {
    List<UserContributionItem> items = [];
    for (var week in json['weeks']) {
      for (var day in week['contributionDays']) {
        items.add(UserContributionItem.fromJson(day));
      }
    }
    return UserContribution(json['totalContributions'], json['colors'], items);
  }
}

class UserContributionItem {
  String color;
  int contributionCount;
  String date;
  int weekday;

  UserContributionItem(
      this.color, this.contributionCount, this.date, this.weekday);

  factory UserContributionItem.fromJson(Map<String, dynamic> json) {
    return UserContributionItem(json['color'], json['contributionCount'],
        json['date'], json['weekday']);
  }
}
