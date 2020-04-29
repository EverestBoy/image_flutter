import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ml_camera_app/FoodCard.dart';
import 'package:ml_camera_app/restServices/SendPicService.dart';
import 'package:ml_camera_app/restServices/model/FoodModel.dart';
import 'package:path/path.dart' as path;
import 'package:flare_flutter/flare_actor.dart';

class ImageActivity extends StatefulWidget {
  File image;
  String postUrl;
  ImageActivity({this.image, String postUrl});
  @override
  _ImageActivityState createState() => _ImageActivityState();
}

class _ImageActivityState extends State<ImageActivity> {

  

  bool imageProgress = false;
  List<FoodModel> foodModelList;
  String uploadedImage = "";
  bool evalVisible = true;

  SendPicService sendPicService = new SendPicService();


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
        evalVisible = false;
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

 bool foodLength = false;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  uploadImage() async {
    print("UPloading image");
    setState(() {
      imageProgress = true;
      evalVisible = false;
    });
    sendPicService.setImage = widget.image;
    sendPicService.setpostUrl = widget.postUrl;
    foodModelList = await sendPicService.sendFood();
    setState(() {
      if(foodModelList.length>0){
        foodLength = true;
      }
      imageProgress = false;
    });
    }
  
  
  @override
  Widget build(BuildContext context) {

    

    var width = MediaQuery.of(context).size.width;

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
          // uploadFile(context);
          uploadImage();


          
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
      body: SingleChildScrollView(
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Center(
                    child: new Container(
                      width: double.infinity,
                      height: width*0.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(widget.image),
                          fit: BoxFit.cover
                        ),
                        border: Border.all(color: Colors.black12)
                      ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(110.0),
                        
                      //   child: Image.file(widget.image, fit: BoxFit.cover,)
                      // )
                    ),
                  )),
                  SizedBox(height: 16,),
                  new Visibility(
                    visible: evalVisible,
                    child: evaButton,
                  ),
                  new Visibility(
                    visible: imageProgress,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 200.0,
                          height: 200.0,
                          child: FlareActor(
                            "assets/robot.flr",
                            animation: "Cargando",
                          ),
                        ),
                        Text("Please wait!")
                      ],
                    )
                  ),

                  if(!evalVisible & !foodLength) Text("Something went wrong"),

                  if(!evalVisible & !foodLength) ListView(
                  children: foodModelList
                      .map(
                        (FoodModel food) => FoodCard(food, context)
                      )
                      .toList(),
                  ),
                  
                ],
              )
            ),
            
        
      
      
    );
  }
}