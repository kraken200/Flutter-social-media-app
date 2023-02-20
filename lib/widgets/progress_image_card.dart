import 'package:fitworld_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Image_card extends StatefulWidget {
  final snap;
  const Image_card({Key? key, required this.snap}) : super(key: key);

  @override
  State<Image_card> createState() => _Image_cardState();
}

class _Image_cardState extends State<Image_card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 20,
              child: Text(
                widget.snap['Date'],
                style: TextStyle(fontSize: 15, color: primaryColor),
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              widget.snap['PhotoUrl'],
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
