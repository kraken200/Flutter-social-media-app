import 'package:flutter/material.dart';

class Tool_card extends StatefulWidget {
  String title = "";
  int num = 0;
  Tool_card({Key? key, required this.title, required this.num})
      : super(key: key);

  @override
  State<Tool_card> createState() => _Tool_cardState();
}

class _Tool_cardState extends State<Tool_card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.01),
              spreadRadius: 20,
              blurRadius: 10,
              offset: Offset(0, 10))
        ],
      ),
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
