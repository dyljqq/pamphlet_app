import 'package:flutter/material.dart';
import 'package:pamphlet_app/config/config.dart';
import 'package:pamphlet_app/utils/resource_manager.dart';
import 'package:pamphlet_app/utils/route.dart';
import 'package:pamphlet_app/widgets/normal_text_cell_widget.dart';

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
      future: ResourceManager.instance.getDevelopers(),
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
      return NormalTextCell(
        e.id,
        description: e.des,
        callback: () {
          PARouter.pushUser(context, e.id, rootNavigator: true);
        },
      );
    }).toList();
  }
}
