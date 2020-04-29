import 'package:flutter/material.dart';
import 'package:ml_camera_app/restServices/model/FoodModel.dart';

class FoodCard extends StatefulWidget {
  FoodModel food;
  BuildContext context;
  FoodCard(FoodModel food, BuildContext context){
    this.food = food;
    this.context = context;
  }

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            color: Color(0xfff6f6f6),
            child: Text(widget.food.name.toString(), style: TextStyle(fontSize: 18),),
          ),


          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            color: Color(0xfff6f6f6),
            child: Text("Carbohydrate: "+widget.food.carbs.toString()),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            color: Color(0xfff6f6f6),
            child: Text("Fats: "+widget.food.carbs.toString()),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            color: Color(0xfff6f6f6),
            child: Text("Proteins: "+widget.food.carbs.toString()),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            color: Color(0xfff6f6f6),
            child: Text("Calories: "+widget.food.carbs.toString()),
          ),
          
        ],
      ),

    );
  }
}