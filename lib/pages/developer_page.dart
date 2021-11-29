import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pamphlet_app/config/config.dart';
import 'package:pamphlet_app/pages/user_page.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  _DeveloperPageState createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developers'),
      ),
      body: page(),
    );
  }

  Widget page() {
    return FutureBuilder(
      future: Config.developers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List developers = snapshot.data;
          return Container(
            color: const Color(0XF8F8F8FF),
            child: developersList(developers),
          );
        }
        return const Center(
          child: Text('loading...'),
        );
      },
    );
  }

  Widget developersList(List developers) {
    return ListView.builder(
      itemCount: developers.length,
      itemBuilder: (BuildContext context, int index) {
        Developer dev = developers[index];
        return Container(
          child: cell(dev),
        );
      },
    );
  }

  Widget cell(Developer dev) {
    List<Widget> childs = [
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          dev.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
    ];
    childs.addAll(users(dev.users));
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(top: 10, left: 18, right: 18, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: childs,
        ));
  }

  List<Widget> users(List<DevelopeUser> users) {
    return users.map((e) {
      var child = Row(
        children: [
          Text(e.id,
              style: const TextStyle(
                fontSize: 16,
              ))
        ],
      );
      if (e.des.isNotEmpty) {
        child = Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.id,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
                // const Spacer(),
                Text(
                  e.des,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                )
              ],
            )
          ],
        );
      }
      return GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)]),
          child: child,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UserPage(e.id);
          }));
        },
      );
    }).toList();
  }
}
