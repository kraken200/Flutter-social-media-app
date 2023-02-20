import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitworld_app/resources/firestore_methods.dart';
import 'package:fitworld_app/resources/storage_methods.dart';
import 'package:fitworld_app/utils/colors.dart';
import 'package:fitworld_app/utils/utils.dart';
import 'package:fitworld_app/widgets/progress_image_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Progress_image extends StatefulWidget {
  final String uid;
  const Progress_image({Key? key, required this.uid}) : super(key: key);

  @override
  State<Progress_image> createState() => _Progress_imageState();
}

class _Progress_imageState extends State<Progress_image> {
  Uint8List? _file;

  uploadImage(Uint8List file, String uid) async {
    String photoUrl = await StorageMethods()
        .uploadImageToStorage('Progess_images', file, false);
    String date = DateFormat.yMMMd().format(DateTime.now());
    await FirebaseFirestore.instance
        .collection('progress_images')
        .doc(uid)
        .collection('date')
        .doc(date)
        .set({'PhotoUrl': photoUrl, 'Date': DateTime.now().toString()});
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Add an Image'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                    if (_file != null) {
                      uploadImage(file, widget.uid);
                    }
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                    if (_file != null) {
                      uploadImage(file, widget.uid);
                    }
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(
          "Progress Images",
          style: TextStyle(color: primaryColor, fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () => _selectImage(context),
                child: Text(
                  "Upload",
                  style: TextStyle(color: blueColor, fontSize: 18),
                )),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('progress_images')
            .doc(widget.uid)
            .collection('date')
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
              itemBuilder: (context, index) =>
                  Image_card(snap: snapshot.data!.docs[index].data()));
        },
      ),
    );
  }
}
