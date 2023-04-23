import 'package:flutter/material.dart';
import 'package:firstapp/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:io';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CircularImage extends StatefulWidget {
  final String imageFile;
  final double size;
  CircularImage({Key? key, required this.imageFile, this.size = 100.0})
      : super(key: key);

  @override
  State<CircularImage> createState() => _CircularImageState();
}

class _CircularImageState extends State<CircularImage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  var b = AuthService().user?.photoURL.toString();
  String spp = 'show pic';
  String hpp = 'hide pic';
  void setImag() async {
    final a = await ref.child('${AuthService().user?.uid}/photoURL').get();
    if (a.value == null) {}
    print(a.value.toString());
    print('Thank You Madhav');
    setState(() {
      b = a.value.toString();
      String mad = spp;
      spp = hpp;
      hpp = mad;
    });
  }

  void setImag2() {
    setState(() {
      b = AuthService().user?.photoURL.toString();
      String mad = spp;
      spp = hpp;
      hpp = mad;
    });
  }

  final picker = ImagePicker();

  // final snapshot = FirebaseDatabase.instance
  //     .ref()
  //     .child('User/${AuthService().user?.uid}/photoURL')
  //     .get();
  XFile? _image;

  XFile? get image => _image;

  void uploadImage(BuildContext context) async {
    firebase_storage.Reference sRef = firebase_storage.FirebaseStorage.instance
        .ref('${AuthService().user?.uid}');
    firebase_storage.UploadTask uploadTask =
        sRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final newURL = await sRef.getDownloadURL();
    // print(snapshot.toString());

    print(newURL);
    setImag();
    setState(() {
      b = newURL.toString();
    });
    ref
        .child('${AuthService().user?.uid}')
        .update({'photoURL': b}).then((value) => _image = null);
    // print('${AuthService().user}');
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
    }
  }

  @override

  //when we are able to fetch image uri from backend replace the placeholder with Image.fronUri() and add the text obtained in imageFile
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 50.0,
        ),
        child: Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage('${b}'),
              radius: 55,
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.camera,
                        size: 30.0,
                      ),
                      onPressed: () {
                        pickGalleryImage(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Card(
                      color: Colors.black45,
                      elevation: 10,
                      child: TextButton(
                        onPressed: () {
                          if (spp == 'show pic') {
                            setImag();
                          } else {
                            setImag2();
                          }
                        },
                        child: Text(
                          spp,
                          style: TextStyle(
                            color: Colors.orange.shade200,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
