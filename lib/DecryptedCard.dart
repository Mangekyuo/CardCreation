import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sultanandmeproject/ListCards.dart';

class GetDecryptData extends StatefulWidget{
  final String accessesToken;
  final String ID;
  GetDecryptData(this.accessesToken,this.ID);
  GetDecryptDataState createState()=> GetDecryptDataState(accessesToken,ID);
}
class GetDecryptDataState extends State<GetDecryptData>{
  final String accessesToken;
  final String ID;
  GetDecryptDataState(this.accessesToken,this.ID);
  List<String> data = <String>[];
  Future<http.Response> GetEncryptedCard() async {
    String token = "Bearer " + accessesToken;

    final response1 = await http.get(Uri.parse("http://192.168.31.121:4000/cards/$ID/decrypt"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token
      },
    );
    String res = response1.body.toString();
    String redo = res.substring(1,res.length-1).replaceAll("{", "").replaceAll("}", "").replaceAll(":", "").replaceAll("[", "").replaceAll("]", "");
    for (String a in redo.split(",")) {
      if(a!="") {
        if (a.substring(1, 2) == "D") {
          data.add(a.substring(7, a.length - 1));
        }
      }
      }
    String datas = data[0];
    //here we should create 9 strings ==>
    //по 29 строк на каждую =>
    String one =datas.substring(0,77);
    String two = datas.substring(79,107);
    String three = datas.substring(109,138);
    String four = datas.substring(140,175);
    String five = datas.substring(177,210);
    String six = datas.substring(212,241);
    String seven = datas.substring(243,272);
    String eight = datas.substring(274,303);
    String nine = datas.substring(305,334);
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
    await GetEncryptedCard().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
        EncryptedCard(data,accessesToken)),(route)=>false));
  }
  @override
  Widget build(BuildContext context) {
    getDatases();
    return Container();
  }
}
class EncryptedCard extends StatefulWidget{
  final List<String> data;
  final String token;
  EncryptedCard(this.data,this.token);
  EncryptedCardState createState()=> EncryptedCardState(data,token);
}
class EncryptedCardState extends State<EncryptedCard>{
  final List<String> data;
  final String token;
  EncryptedCardState(this.data,this.token);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false, // to avoid show bottom overflow
        body: Padding(padding: EdgeInsets.only(left: width/20 , right: width/20,top: height*0.075) ,
            child: Container(
              width: width*0.9, height: height*0.9, color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text.rich(TextSpan(
                      text: "", style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18,color: Colors.black)),
                      children: <TextSpan>[
                        TextSpan(text: "Back" , style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.grey)) , recognizer: TapGestureRecognizer()
                          ..onTap =(){
                            //go to sign up screen ==>
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                                GetData(token)),(route)=>false);
                          })
                      ]
                  )),
                  Container(width: width*0.9, height: height*0.9-30,
                      child: Padding(padding: EdgeInsets.only(top: height*0.1),
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
                      ),)
                  ),

                ],
              ) ,
            )
        ),
    );
  }

}