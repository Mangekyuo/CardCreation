import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sultanandmeproject/CreateCard.dart';

import 'mainpage.dart';

class GetDataGenerateCard extends StatefulWidget{
  String AccessesToken;
  GetDataGenerateCard(this.AccessesToken);
  GetDataGenerateCardState createState()=> GetDataGenerateCardState(AccessesToken);
}

class GetDataGenerateCardState extends State<GetDataGenerateCard>{
  String AccessesToken;
  GetDataGenerateCardState(this.AccessesToken);
  List<String> data = <String>[];
  List<String> keys = <String>[];
  Future<http.Response> GenerateCardmethod() async {
    String token = "Bearer " + AccessesToken;
    final response1 = await http.post(Uri.parse("http://192.168.31.121:4000/cards/new"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": token
        },
        body:jsonEncode(<String,dynamic>{
          "IncludeSymbols": true,
          "DigitsArea": true
        }),
        encoding: Encoding.getByName("utf-8"));
    String res = response1.body.toString();
    String redo = res.substring(1,res.length-1).replaceAll("{", "").replaceAll("}", "").replaceAll(":", "").replaceAll("[", "").replaceAll("]", "");
    for (String a in redo.split(",")) {
      if(a!="") {
        if (a.substring(1, 2) == "D") {
          data.add(a.substring(6, a.length - 1));
        }
        else{
          keys.add(a.substring(6,a.length-1));
        }
      }
    }
    String datas = data[0];
    int lenght = datas.length;
    String one =datas.substring(0,lenght-259);
    String two = datas.substring(lenght-257,lenght-229);
    String three = datas.substring(lenght-227,lenght-194);
    String four = datas.substring(lenght-192,lenght-153);
    String five = datas.substring(lenght-151,lenght-124);
    String six = datas.substring(lenght-122,lenght-93);
    String seven = datas.substring(lenght-91,lenght-62);
    String eight = datas.substring(lenght-60,lenght-31);
    String nine = datas.substring(lenght-29,lenght);
    data.add(one);
    data.add(two);
    data.add(three);
    data.add(four);
    data.add(five);
    data.add(six);
    data.add(seven);
    data.add(eight);
    data.add(nine);
    return response1;
  }
  void getDatases() async {
    await GenerateCardmethod().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
        GenerateCard(AccessesToken,data,keys)),(route)=>false));
  }
  @override
  Widget build(BuildContext context) {
    getDatases();
    return Container();
  }

}

class GenerateCard extends StatefulWidget{
  String AccessesToken;
  final List<String> data;
  final List<String> keydata;
  GenerateCard(this.AccessesToken,this.data,this.keydata);
  GenerateCardState createState()=> GenerateCardState(AccessesToken,data,keydata);
}

class GenerateCardState extends State<GenerateCard>{
  String AccessesToken;
  final List<String> data;
  final List<String> keydata;
  GenerateCardState(this.AccessesToken,this.data,this.keydata);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false, // to avoid show bottom overflow
        body:Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsets.only(top: height*0.1),
                    child: Text.rich(TextSpan(
                        text: "", style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18,color: Colors.black)),
                        children: <TextSpan>[
                          TextSpan(text: "Back" , style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.grey)) , recognizer: TapGestureRecognizer()
                            ..onTap =(){
                              String sendData = "w"+AccessesToken+"w";
                              //go to sign up screen ==>
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                                  MainPage(sendData)),(route)=>false);
                            })
                        ]
                    ))),
                Padding(padding: EdgeInsets.only(left: width/20 , right: width/20) ,
                  child: Container(
                    width: width*0.9, height: height*0.7, color: Colors.white,
                    child: Padding
                      (padding: EdgeInsets.only(top: height*0.1),
                      child: Column(
                        children: [
                          Container(
                            width: width*0.9, height: height*0.05, color: Color.fromRGBO(255, 255, 255, 1),
                            child: Text(data[1] , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 18 , color: Colors.black))),
                          ),
                          Container(
                            width: width*0.9, height: height*0.05, color: Color.fromRGBO(255, 255, 255, 1),
                            child: Text(data[2] , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 18 , color: Colors.black))),
                          ),
                          Container(
                            width: width*0.9, height: height*0.05, color: Color.fromRGBO(192, 192, 192, 1),
                            child: Text(data[3] , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 18 , color: Colors.black),)),
                          ),
                          Container(
                            width: width*0.9, height: height*0.05, color: Color.fromRGBO(255, 192, 192, 1),
                            child: Text(data[4] , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 18 , color: Colors.black),)),
                          ),
                          Container(
                            width: width*0.9, height: height*0.05, color: Color.fromRGBO(192, 255, 192, 1),
                            child: Text(data[5] , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 18 , color: Colors.black),)),
                          ),
                          Container(
                            width: width*0.9, height: height*0.05, color: Color.fromRGBO(255, 255, 192, 1),
                            child: Text(data[6] , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 18 , color: Colors.black),)),
                          ),
                          Container(
                            width: width*0.9, height: height*0.05, color: Color.fromRGBO(192, 192, 255, 1),
                            child: Text(data[7] , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 18 , color: Colors.black),)),
                          ),
                          Container(
                            width: width*0.9, height: height*0.05, color: Color.fromRGBO(255, 192, 255, 1),
                            child: Text(data[8] , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 18 , color: Colors.black),)),
                          ),
                          Container(
                            width: width*0.9, height: height*0.05, color: Color.fromRGBO(192, 255, 255, 1),
                            child: Text(data[9] , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 18 , color: Colors.black),)),
                          ),
                        ],
                      ),),
                  )
                ),
                Padding(padding: EdgeInsets.only(left: width/20 , right: width/20) ,
                  child: SizedBox(width: width*0.9, height: height*0.1,
                    child: ElevatedButton(
                        child: Text("Create Card" ,
                            style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18 , color: Colors.white))),
                        onPressed:() async {
                          // Validate will return true if the form is valid, or false if
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                              GenerateDataforCreateCard(AccessesToken,data[0],keydata[0])),(route)=>false);
                        },style:ElevatedButton.styleFrom(primary: Colors.blue)
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}