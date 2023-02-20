import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitworld_app/resources/auth_methods.dart';
import 'package:fitworld_app/resources/firestore_methods.dart';
import 'package:fitworld_app/screens/progress_image_screen.dart';
import 'package:fitworld_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class Progress extends StatefulWidget {
  const Progress({
    Key? key,
  }) : super(key: key);

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController _weightcontroller = TextEditingController();
  TextEditingController _waistcontroller = TextEditingController();
  TextEditingController _chestcontroller = TextEditingController();
  TextEditingController _armcontroller = TextEditingController();
  TextEditingController _hipcontroller = TextEditingController();
  final progress_list = [
    "Progress Images",
    "Body Weight",
    "Waist size",
    "Chest Size",
    "Arm Size",
    "Hip Size"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setvalues(uid);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _weightcontroller.dispose();
    _chestcontroller.dispose();
    _waistcontroller.dispose();
    _armcontroller.dispose();
    _hipcontroller.dispose();
  }

  void setvalues(String uid) async {
    var user_data =
        await FirebaseFirestore.instance.collection('user_data').doc(uid).get();
    setState(() {
      if (((user_data as dynamic)['weight']) == null) {
      } else {
        _weightcontroller = TextEditingController.fromValue(
            TextEditingValue(text: (user_data as dynamic)['weight']));
        _waistcontroller = TextEditingController.fromValue(
            TextEditingValue(text: (user_data as dynamic)['waist_size']));
        ;
        _chestcontroller = TextEditingController.fromValue(
            TextEditingValue(text: (user_data as dynamic)['chest_size']));
        ;
        _armcontroller = TextEditingController.fromValue(
            TextEditingValue(text: (user_data as dynamic)['arm_size']));
        ;
        _hipcontroller = TextEditingController.fromValue(
            TextEditingValue(text: (user_data as dynamic)['hip_size']));
      }
      ;
    });
  }

  void updateprogress(
      String weight, String waist, String chest, String arm, String hip) async {
    String res = "Enter all the required fields";
    if (weight.isNotEmpty &
        waist.isNotEmpty &
        chest.isNotEmpty &
        arm.isNotEmpty &
        hip.isNotEmpty) {
      await FirebaseFirestore.instance.collection('user_data').doc(uid).set({
        'weight': weight,
        'waist_size': waist,
        'chest_size': chest,
        'arm_size': arm,
        'hip_size': hip
      });
    } else {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(
          "My Progress",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            child: ListView(shrinkWrap: true, children: [
              Card(
                color: mobileBackgroundColor,
                child: ListTile(
                  title: Text(
                    progress_list[0],
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  trailing: Icon(Icons.arrow_right_sharp),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Progress_image(
                              uid: uid,
                            )));
                  },
                ),
              ),
              Card(
                color: mobileBackgroundColor,
                child: ListTile(
                    title: Text(
                      progress_list[1],
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    trailing: SizedBox(
                      width: 50,
                      height: 15,
                      child: TextField(
                        controller: _weightcontroller,
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              ),
              Card(
                color: mobileBackgroundColor,
                child: ListTile(
                    title: Text(
                      progress_list[2],
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    trailing: SizedBox(
                      width: 50,
                      height: 15,
                      child: TextField(
                        controller: _waistcontroller,
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              ),
              Card(
                color: mobileBackgroundColor,
                child: ListTile(
                    title: Text(
                      progress_list[3],
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    trailing: SizedBox(
                      width: 50,
                      height: 15,
                      child: TextField(
                        controller: _chestcontroller,
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              ),
              Card(
                color: mobileBackgroundColor,
                child: ListTile(
                    title: Text(
                      progress_list[4],
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    trailing: SizedBox(
                      width: 50,
                      height: 15,
                      child: TextField(
                        controller: _armcontroller,
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              ),
              Card(
                color: mobileBackgroundColor,
                child: ListTile(
                    title: Text(
                      progress_list[5],
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    trailing: SizedBox(
                      width: 50,
                      height: 15,
                      child: TextField(
                        controller: _hipcontroller,
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              ),
            ]),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Center(
                child: MaterialButton(
              minWidth: 100,
              color: blueColor,
              padding: EdgeInsets.all(10),
              onPressed: () {
                updateprogress(
                    _weightcontroller.text,
                    _waistcontroller.text,
                    _chestcontroller.text,
                    _armcontroller.text,
                    _hipcontroller.text);
                setvalues(uid);
              },
              child: Text(
                "Done",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )),
          )
        ],
      )),
    );
  }
}
