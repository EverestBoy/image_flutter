

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_camera_app/ImageActivity.dart';

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
          // image: DecorationImage(
          //   colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
          //   image: AssetImage("assets/robot.png",),
          //   fit: BoxFit.fill
          // )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: width*0.3,
              width: width*0.3,
              child: Image.asset("assets/rubixe.png")
              
            ),
            // SizedBox(
            //   width: width*0.4,
            //   height: width*0.4,
            //   child: FlareActor(
            //     "assets/rubixe.flr",
            //     animation: "Untitled",
            //   ),
            // )
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
                        Text("Project Name Here", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                        Text("Project Description Lorem Ipsum is simply dummy text of the printing and typesetting industry. ", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,)
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

            SizedBox(height: 32,),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Stack(
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
                            minWidth: 200.0,
                            height: 35,
                            child: SizedBox(
                              height: width/2-48,
                              width: width/2-32,
                            ),
                            onPressed: () {
                              getImageFromCamera();
                            },
                          ),
                        
                      ],
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Stack(
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
                            minWidth: 200.0,
                            height: 35,
                            child: SizedBox(
                              height: width/2-48,
                              width: width/2-32,
                            ),
                            onPressed: () {
                              getImageFromGallery();
                            },
                          ),
                        
                      ],
                    )
                  ),
                ),
              ],
            )
           
          ],
        ),
      ),
      
    );
  }
}
