import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pamphlet_app/github_api/result.dart';
import 'package:pamphlet_app/model/user.dart';
import 'package:pamphlet_app/view_model/user_view_model.dart';
import 'package:pamphlet_app/widgets/user_contribution_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage(this.userName, {Key? key}) : super(key: key);

  final String userName;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
      ),
      body: page(),
    );
  }

  Widget page() {
    return FutureBuilder(
      future: UserViewModel.getUserInfo(widget.userName),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Text('loading...'),
          );
        }
        Result<dynamic> result = snapshot.data;
        switch (result.type) {
          case ResultType.success:
            return Container(
              color: const Color(0XF8F8F8FF),
              child: Column(
                children: [
                  header(result.data),
                  userContribution(),
                  listView(result.data)
                ],
              ),
            );
          case ResultType.failure:
            ErrorData error = result.data;
            return Center(
              child: Text('error: ${error.data.toString()}'),
            );
        }
      },
    );
  }

  Widget header(User user) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 30),
            child: titleSection(user),
          ),
          Row(
            children: [
              Expanded(
                child: userCount('Repositories', user.publicReposCount),
              ),
              Expanded(
                child: userCount('Followers', user.followers),
              ),
              Expanded(
                child: userCount('followering', user.followings),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget listView(User user) {
    List items = [
      [
        Icons.group,
        user.company.isEmpty ? 'Teams' : user.company,
        user.company.isEmpty
      ],
      [
        Icons.location_on,
        user.location.isEmpty ? 'Location' : user.location,
        user.location.isEmpty
      ],
      [
        Icons.email,
        user.email.isEmpty ? 'Email' : user.email,
        user.email.isEmpty
      ],
      [Icons.link, user.blog.isEmpty ? 'Blog' : user.blog, user.blog.isEmpty]
    ];
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 12),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          var arr = items[index];
          return Container(
            height: 44,
            color: Colors.white,
            child: cell(arr[0], arr[1], isEmpty: arr[2]),
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 12),
            child: const Divider(
              height: 1,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }

  Widget titleSection(User user) {
    const normalTextStyle = TextStyle(color: Colors.black87, fontSize: 12);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(user.avatar), fit: BoxFit.cover)),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Text(
                        user.name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    Text(
                      '(${user.login})',
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Text(
                user.bio,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Joined on ${DateFormat('yyyy-MM-dd').format(DateTime.parse(user.createdAt))}',
                  style: normalTextStyle,
                ),
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget userCount(String title, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            count.toString(),
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  Widget cell(IconData icon, String title, {bool isEmpty = false}) {
    return Container(
        height: 44,
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(icon, size: 20),
              ),
              Text(title,
                  style: TextStyle(
                      color: isEmpty ? Colors.grey : Colors.black,
                      fontSize: 14)),
              const Spacer(),
              const Image(
                  width: 7,
                  height: 13,
                  image: AssetImage('images/arrows_right.png'))
            ],
          ),
        ]));
  }

  Widget userContribution() {
    return FutureBuilder(
      future: UserViewModel.getUserContributions(widget.userName),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Result<dynamic> result = snapshot.data;
          switch (result.type) {
            case ResultType.success:
              return Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: UserContributionWidget(result.data),
              );
            case ResultType.failure:
              break;
          }
        }
        return const SizedBox(
          width: 0,
          height: 0,
        );
      },
    );
  }
}
