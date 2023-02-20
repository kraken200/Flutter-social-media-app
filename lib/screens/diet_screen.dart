import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitworld_app/utils/colors.dart';
import 'package:fitworld_app/widgets/diet_card.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Diet_screen extends StatefulWidget {
  const Diet_screen({Key? key}) : super(key: key);

  @override
  State<Diet_screen> createState() => _Diet_screenState();
}

class _Diet_screenState extends State<Diet_screen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _foodcontroller = TextEditingController();
  final TextEditingController _caloriecontroller = TextEditingController();

  void addFood(String uid, String food, String calories) async {
    String fid = const Uuid().v1();
    await FirebaseFirestore.instance
        .collection('diet')
        .doc(uid)
        .collection("foods")
        .doc(fid)
        .set({
      "food": food,
      "calories": calories,
      "eid": fid,
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _foodcontroller.dispose();
    _caloriecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Diet tool",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          backgroundColor: mobileBackgroundColor,
        ),
        body: SafeArea(
            child: Column(children: [
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
                      controller: _foodcontroller,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      decoration: const InputDecoration(
                        labelText: 'Food',
                        labelStyle: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _caloriecontroller,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      decoration: const InputDecoration(
                        labelText: 'Calories',
                        labelStyle: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        child: Text(
                          "Add Meal",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          addFood(uid, _foodcontroller.text,
                              _caloriecontroller.text);
                        },
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('diet')
                  .doc(uid)
                  .collection('foods')
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => Diet_card(
                      snap: snapshot.data!.docs[index].data(), uid: uid),
                  shrinkWrap: true,
                );
              },
            ),
          )
        ])));
    ;
  }
}
