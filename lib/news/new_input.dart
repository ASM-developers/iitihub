import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Newinput extends StatefulWidget {
  Newinput({super.key});


  @override
  State<Newinput> createState() => _NewinputState();
}

class _NewinputState extends State<Newinput> {
  String imageUrl="";

  TextEditingController newsTitle = TextEditingController();
  TextEditingController newsDesc = TextEditingController();
  TextEditingController newsDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add News")),
      body: Padding(padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(children: [
           Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: newsTitle,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'News Title',
                    hintText: 'Enter Title Name',
                  ),
                ),
              ),
           SingleChildScrollView(
             child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: newsDesc,
                    minLines: 4,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'News Description',
                      hintText: 'Enter Description',
                    ),
                  ),
                ),
           ),
      
              Padding(
      
                padding: const EdgeInsets.all(15.0),
                child: IconButton(onPressed: () async
                {
                  ImagePicker imagepicker =ImagePicker();
                  XFile? file=await imagepicker.pickImage(source: ImageSource.gallery);
              
                  print(file?.path);
              
                  if(file==null )return;
              
                  Reference referenceRoot=FirebaseStorage.instance.ref();
                  Reference referenceDirimages=referenceRoot.child('images');
              
                    Reference referenceImageToUpload=referenceDirimages.child(file.name);
                  try{
              
                  await referenceImageToUpload.putFile(File(file.path));
                  imageUrl=await referenceImageToUpload.getDownloadURL();
                  }catch(e)
                  {
                    
                  }
                  
              
                }, icon: Icon(Icons.image, size: 50,)
                ),
              ),
              ElevatedButton(onPressed: (){
                final _news_title=newsTitle.text;
                final _newsDesc=newsDesc.text;
                final _url=imageUrl;
                _submitdata(newsTitle: _news_title, newsDesc: _newsDesc, url: _url);
              }, child: Text("Submit"))
            
        ]),
      ),
      ),

    );
  }
  Future _submitdata(
      {required String newsTitle,
      required String newsDesc,
      required String url}) async {
    final docuser = FirebaseFirestore.instance.collection('news').doc();
    final json = {
      'ID': docuser.id,
      'newsTitle': newsTitle,
      'newsDesc': newsDesc,
      'url': url,
    };
    await docuser.set(json);

    await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text('News is succesfully added'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}