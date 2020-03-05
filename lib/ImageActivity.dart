import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:flare_flutter/flare_actor.dart';

class ImageActivity extends StatefulWidget {
  File image;
  ImageActivity({this.image});
  @override
  _ImageActivityState createState() => _ImageActivityState();
}

class _ImageActivityState extends State<ImageActivity> {

  

  bool imageProgress = false;
  String uploadedImage = "";

  Future uploadFile(BuildContext context) async {    
      print("\n\n\n\n\nUploading");

  //Create a reference to the location you want to upload to in firebase  
    StorageReference reference;
    try{
      print("\n\n\n\n\nUploading");
      FirebaseStorage _storage = FirebaseStorage.instance;
      reference = _storage.ref().child("image/Project1/ "+path.basename(widget.image.path));
      StorageUploadTask uploadTask = reference.putFile(widget.image);
      setState(() {
        imageProgress = true;
      });

      var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      uploadedImage = dowurl.toString();

      print("Url is "+uploadedImage);
      
      setState(() {
        imageProgress = false;
      });
      
    }
    catch(err){
      print(err);
    }
    

    //Upload the file to firebase 
    
    

    // Waits till the file is uploaded then stores the download url 
    // Uri location = (await uploadTask.future).downloadUrl;

 } 
  
  
  @override
  Widget build(BuildContext context) {

    final evaButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.red,
      child: MaterialButton(
        minWidth: 150.0,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
      print("\n\n\n\n\nUploading");

          FocusScope.of(context).requestFocus(FocusNode());
          uploadFile(context);


          
        },
        child: Text("Evaluate",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Image Processing"),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(height: 32,),
                  Container(
                    width: double.infinity,
                    child: Center(
                    child: new Container(
                      width: 220.0,
                      height: 220.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(widget.image),
                          fit: BoxFit.fill
                        ),
                        borderRadius: BorderRadius.circular(110.0),
                        border: Border.all(color: Colors.black12)
                      ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(110.0),
                        
                      //   child: Image.file(widget.image, fit: BoxFit.cover,)
                      // )
                    ),
                  )),
                  SizedBox(height: 16,),
                  evaButton
                  
                ],
              )
            ),
            new Visibility(
              visible: imageProgress,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54,
                child: Center(
                  child: SizedBox(
                    width: 420.0,
                    height: 420.0,
                    child: FlareActor(
                      "assets/robot.flr",
                      animation: "Cargando",
                    ),
                  )
                ),
              ),
            )
        ],
      )
      
    );
  }
}