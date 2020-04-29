

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_camera_app/ImageActivity.dart';
import 'package:toast/toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'AI Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  File _image;

  Future getImageFromCamera() async {
    print("Image from camera selected");
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if(image == null){
      print("No image selected");
    }
    else{
      Navigator.push(context, CupertinoPageRoute(builder: (context) => ImageActivity(image: image)));
    }

  }
  Future getImageFromGallery() async {
    print("Image from gallery selected");
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image == null){
      print("No image selected");
    }
    else{
      Navigator.push(context, CupertinoPageRoute(builder: (context) => ImageActivity(image: image)));
    }
  }

  String serverUrl = "";
 

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: width*0.3,
                width: width*0.3,
                child: Image.asset("assets/rubixe.png")
                
              ),
              SizedBox(height: 8,),
              Text("AI Internship Program", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
              // SizedBox(height: 4,),
              Text("Rubixe Incubation Center", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
              SizedBox(height: 24,),
              Container(
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                height: 125,
                decoration: BoxDecoration(
                  color: Color(0xfff7f7f7),
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Healthy Diet", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          Text("Our Healthy Diet project is focused on combining machine learning with real user input to create an advanced method for nutritional tracking.", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,)
                        ],
                      )
                    ),
                    
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: width*0.4,
                        height: width*0.4,
                        child: FlareActor(
                          "assets/robot.flr",
                          animation: "reposo",
                        ),
                      )
                      
                    )
                  ],
                ),
                
              ),

              Container(
                        height: 60,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: new TextField(
                          obscureText: false,
                          keyboardType: TextInputType.url,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16.0),
                            hintText: "Enter server url",
                            hintStyle: new TextStyle(fontSize: 16.0),
                            focusedBorder: OutlineInputBorder(borderRadius: 
                              BorderRadius.circular(0),
                              borderSide: const BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(borderRadius: 
                              BorderRadius.circular(0),
                              borderSide: const BorderSide(color: Colors.white))
                          ),
                          onChanged: (text){
                            serverUrl = text;
                          },


                        ),
                      ),
              SizedBox(height: 16,),
                    
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Stack(
                        children: <Widget>[
                          Card(
                            elevation: 4,
                            child: SizedBox(
                              height: width/2-48,
                              width: width/2-32,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.camera, color: Color(0xff616161), size: 60,),
                                  Text("Open Camera", style: TextStyle(fontSize: 16,))
                                ],
                              )
                            ),
                          ),
                          MaterialButton(
                              minWidth: width/2-48,
                              height: 35,
                              child: SizedBox(
                                height: width/2-48,
                                width: width/2-62,
                              ),
                              onPressed: () {
                                if(serverUrl.length == 0){
                                  Toast.show("Enter the server url at first", context);
                                } else getImageFromCamera();
                              },
                            ),
                          
                        ],
                      ),
                  Stack(
                        children: <Widget>[
                          Card(
                            elevation: 4,
                            child: SizedBox(
                              height: width/2-48,
                              width: width/2-32,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.photo_library, color: Color(0xff616161), size: 60,),
                                  Text("Open Gallery", style: TextStyle(fontSize: 16,))
                                ],
                              )
                            ),
                          ),
                          MaterialButton(
                              child: SizedBox(
                                height: width/2-48,
                                width: width/2-60,
                              ),
                              onPressed: () {
                                if(serverUrl.length == 0){
                                  Toast.show("Enter the server url at first", context);
                                } else getImageFromGallery();
                              },
                            ),
                          
                        ],
                      )
                ],
              ),
            
            ],
          ),
        )
      ),
      
    );
  }
}
