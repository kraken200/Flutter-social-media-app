import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Diet_card extends StatefulWidget {
  final snap;
  final uid;
  const Diet_card({Key? key, required this.snap, required this.uid})
      : super(key: key);

  @override
  State<Diet_card> createState() => _Diet_cardState();
}

class _Diet_cardState extends State<Diet_card> {
  void removeFood(String fid) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('diet')
          .doc(uid)
          .collection('foods')
          .doc(fid)
          .delete();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: SizedBox(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.12),
                spreadRadius: 5,
                blurRadius: 10,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.snap['food'],
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
              ),
              const Divider(),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.snap['calories'],
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              const Divider(),
              Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child: const Text(
                        "Remove",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        removeFood(widget.snap['fid']);
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
