import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitworld_app/utils/colors.dart';
import 'package:fitworld_app/widgets/excercise_card.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TrainingTool extends StatefulWidget {
  const TrainingTool({Key? key}) : super(key: key);

  @override
  State<TrainingTool> createState() => _TrainingToolState();
}

class _TrainingToolState extends State<TrainingTool> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _excercisecontroller = TextEditingController();
  final TextEditingController _repcontroller = TextEditingController();
  final TextEditingController _weightcontroller = TextEditingController();

  void addExcercise(
      String uid, String excercise, String reps, String weight) async {
    String eid = const Uuid().v1();
    await FirebaseFirestore.instance
        .collection('Workout')
        .doc(uid)
        .collection("excercises")
        .doc(eid)
        .set({
      "excercise": excercise,
      "weight": weight,
      "reps": reps,
      "eid": eid,
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _excercisecontroller.dispose();
    _repcontroller.dispose();
    _weightcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Training tool",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          backgroundColor: mobileBackgroundColor,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 8,
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _excercisecontroller,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                        decoration: const InputDecoration(
                          labelText: 'Excercise',
                          labelStyle: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _repcontroller,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                        decoration: const InputDecoration(
                          labelText: 'Reps',
                          labelStyle: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _weightcontroller,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                        decoration: const InputDecoration(
                          labelText: 'Weight',
                          labelStyle: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: Text(
                            "Add excercise",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            addExcercise(uid, _excercisecontroller.text,
                                _repcontroller.text, _weightcontroller.text);
                          },
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Workout')
                    .doc(uid)
                    .collection('excercises')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) =>
                        Excercise_Card(snap: snapshot.data!.docs[index].data()),
                    shrinkWrap: true,
                  );
                },
              ),
            )
          ],
        )));
  }
}
