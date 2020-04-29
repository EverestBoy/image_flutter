
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'model/FoodModel.dart';



class SendPicService{

  File image;
  String postUrl;

  void set setpostUrl (String postUrl){
    this.postUrl = postUrl;
  }

  void set setImage(File image){
    this.image = image;
  }

  List<FoodModel> foodModelList = [];
  
  Future<List<FoodModel>> sendFood() async {
    
    String base64Image = base64Encode(image.readAsBytesSync());
    http.post(postUrl, body: {
      "image": base64Image,
      "name":"food name"
    }).then((res) {
      if (res.statusCode == 200) {
        

        var foodJson = json.decode(res.body);
        
        List<dynamic> body = foodJson;

        foodModelList = body
            .map(
              (dynamic item) => FoodModel.fromJson(item),
            )
            .toList();
        print(foodModelList.length);
        return foodModelList;
                
          
      
          
      } else {
        return foodModelList;
        // throw "Can't get referrals.";
      }
    }).catchError((err) {
      print(err);
    });

    
  }

}
