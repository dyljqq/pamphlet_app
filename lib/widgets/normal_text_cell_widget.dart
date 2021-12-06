import 'dart:math';

import 'package:flutter/material.dart';

typedef NormalTextCellCallback = void Function();

class NormalTextCell extends StatefulWidget {
  String text;
  String? description;
  NormalTextCellCallback? callback;

  NormalTextCell(this.text, {Key? key, this.description, this.callback})
      : super(key: key);

  @override
  _NormalTextCellState createState() => _NormalTextCellState();
}

class _NormalTextCellState extends State<NormalTextCell> {
  @override
  Widget build(BuildContext context) {
    var child = Row(
      children: [
        Text(widget.text,
            style: const TextStyle(
              fontSize: 16,
            ))
      ],
    );
    if (widget.description != null && widget.description!.isNotEmpty) {
      child = Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.text,
                  style: const TextStyle(
                    fontSize: 16,
                  )),
              Text(
                widget.description!,
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
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
        child: child,
      ),
      onTap: widget.callback,
    );
  }
}
