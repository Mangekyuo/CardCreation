import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sultanandmeproject/GenerateCard.dart';
import 'package:sultanandmeproject/ListCards.dart';

class MainPage extends StatefulWidget{
  String AccessesToken;
  MainPage(this.AccessesToken);
  MainPageState createState()=> MainPageState(AccessesToken);
}

class MainPageState extends State<MainPage>{
  String AccessesToken;
  MainPageState(this.AccessesToken);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String rightAccessesToken = AccessesToken.substring(1,AccessesToken.length-1);
    print("RIGHT TOKEN =>" +rightAccessesToken);
    return Scaffold(
        resizeToAvoidBottomInset: false, // to avoid show bottom overflow
        body:Container(
        decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsets.only(left: width/20 , right: width/20) ,
                  child: SizedBox(width: width*0.9, height: height*0.2,
                    child: ElevatedButton(
                        child: Text("Generate Card" ,
                            style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18 , color: Colors.white))),
                        onPressed:() async {
                          //go to generate card class =>
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                              GetDataGenerateCard(rightAccessesToken)),(route)=>true);
                        },style:ElevatedButton.styleFrom(primary: Color.fromRGBO(192, 192, 255, 1))
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: width/20 , right: width/20) ,
                  child: SizedBox(width: width*0.9, height: height*0.2,
                    child: ElevatedButton(
                        child: Text("Show your cards" ,
                            style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18 , color: Colors.white))),
                        onPressed:() async {
                          // Validate will return true if the form is valid, or false if
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                              GetData(rightAccessesToken)),(route)=>true);
                        },style:ElevatedButton.styleFrom(primary: Color.fromRGBO(192, 192, 255, 1))
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}