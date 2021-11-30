import 'package:flutter/material.dart';
import 'package:pamphlet_app/model/user_contribution.dart';
import 'package:pamphlet_app/utils/color_utils.dart';

class UserContributionWidget extends StatefulWidget {
  final UserContribution userContribution;

  const UserContributionWidget(this.userContribution, {Key? key})
      : super(key: key);

  @override
  _UserContributionWidgetState createState() => _UserContributionWidgetState();
}

class _UserContributionWidgetState extends State<UserContributionWidget> {
  ScrollController contributionScrollController =
      ScrollController(initialScrollOffset: 1000);

  UserContributionItem? contributionItem;

  @override
  void initState() {
    contributionItem = widget.userContribution.items.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userContribution();
  }

  Widget userContribution() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_contributionText(contributionItem)),
          Container(
            height: 100,
            margin: const EdgeInsets.only(top: 5),
            child: userContributionGridView(widget.userContribution),
          )
        ],
      ),
    );
  }

  Widget userContributionGridView(UserContribution contribution) {
    List<Widget> widgets = contribution.items.map((UserContributionItem item) {
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              color: ColorUtils.fromHex(item.color),
              borderRadius: BorderRadius.circular(2)),
        ),
        onTap: () {
          setState(() {
            contributionItem = item;
          });
        },
      );
    }).toList();
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, mainAxisSpacing: 3, crossAxisSpacing: 3),
      controller: contributionScrollController,
      scrollDirection: Axis.horizontal,
      children: widgets,
    );
  }

  String _contributionText(UserContributionItem? item) {
    return '${item!.contributionCount} contributions on ${item.date}';
  }

  @override
  void dispose() {
    contributionScrollController.dispose();
    super.dispose();
  }
}
