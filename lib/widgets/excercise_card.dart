import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Excercise_Card extends StatefulWidget {
  final snap;
  const Excercise_Card({Key? key, required this.snap}) : super(key: key);

  @override
  State<Excercise_Card> createState() => _Excercise_CardState();
}

class _Excercise_CardState extends State<Excercise_Card> {
  void removeExcercise(String eid) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('Workout')
          .doc(uid)
          .collection('excercises')
          .doc(eid)
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
                  child: Text(widget.snap['excercise'],
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.snap['reps'],
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
              ),
              const Divider(),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.snap['weight'],
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              const Divider(),
              Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child: const Text(
                        "Completed excercise",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        removeExcercise(widget.snap['eid']);
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
