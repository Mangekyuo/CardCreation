import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sultanandmeproject/mainpage.dart';

import 'DecryptedCard.dart';

class GetData extends StatefulWidget{
  String AccessesToken;

  GetData(this.AccessesToken);
  GetDataState createState()=> GetDataState(AccessesToken);
}
class GetDataState extends State<GetData>{
  String AccessesToken;
  //create list to hold data =>
  List<String> id = <String>[];
  List<String> userid = <String>[];
  List<String> title =<String>[];
  List<String> encryptedData = <String>[];
  List<String> created = <String>[];
  List<String> updated = <String>[];
  GetDataState(this.AccessesToken);
  Future<http.Response> GetListCards() async {
    String token = "Bearer " + AccessesToken;

    final response1 = await http.get(Uri.parse("http://192.168.31.121:4000/cards/"),
      headers: {
        "Authorization": token
      },
    );
    //log(response1.body);
    String res = response1.body.toString();
    String redo = res.substring(1,res.length-1).replaceAll("{", "").replaceAll("}", "").replaceAll(":", "").replaceAll("[", "").replaceAll("]", "");
    for (String a in redo.split(",")) {
      if(a!=""){
        if(a.substring(1,3)=="ID"){
          id.add(a.substring(5,a.length-1));
        }
        if(a.substring(1,3)=="Us"){
          userid.add(a.substring(9,a.length-1));
        }
        if(a.substring(1,3)=="En"){
          encryptedData.add(a.substring(16,a.length-1));
        }
        if(a.substring(1,3)=="Cr"){
          created.add(a.substring(12,a.length-1));
        }
        if(a.substring(1,3)=="Up"){
          updated.add(a.substring(12,a.length-1));
        }
        if(a.substring(1,3)=="Ti"){
          String datas = a.substring(8,a.length-1);
          if(datas==""){
            title.add("UNDEFINED");
          }
          else{
            title.add(datas);
          }
        }
      }
    }
    return response1;
  }
  void getDatases() async {
    await GetListCards().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
        ListCards(id,userid,title,encryptedData,created,updated,AccessesToken)),(route)=>false));
  }
  @override
  Widget build(BuildContext context) {
    getDatases();
    return Container();
  }
}

class ListCards extends StatefulWidget{
  final List<String> id;
  final List<String> userid;
  final List<String> title;
  final List<String> encryptedData;
  final List<String> created;
  final List<String> updated;
  final String accessesToken;
  ListCards(this.id,this.userid,this.title,this.encryptedData,this.created,this.updated,this.accessesToken);

  ListCardsState createState()=> ListCardsState(id,userid,title,encryptedData,created,updated,accessesToken);
}

class ListCardsState extends State<ListCards>{
  final List<String> id;
  final List<String> userid;
  final List<String> title;
  final List<String> encryptedData;
  final List<String> created;
  final List<String> updated;
  final String accessesToken;
  ListCardsState(this.id,this.userid,this.title,this.encryptedData,this.created,this.updated,this.accessesToken);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //get data =>

    return Scaffold(
        resizeToAvoidBottomInset: false, // to avoid show bottom overflow
        body:Padding(padding: EdgeInsets.only(top: height*0.05,right: width/20,left: width/20,bottom: height*0.05),
            child: Container(width: width*0.9,height: height*0.9,color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text.rich(TextSpan(
                      text: "", style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18)),
                      children: <TextSpan>[
                        TextSpan(text: "Back" , style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.grey)) , recognizer: TapGestureRecognizer()
                          ..onTap =(){
                            //go to sign up screen ==>
                            String sendDAta = "W"+accessesToken+"W";
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                                MainPage(sendDAta)),(route)=>false);
                          })
                      ]
                  )),
                  Container(width: width*0.9, height: height*0.8, child: Card(id,userid,title,encryptedData,created,updated,accessesToken))
                ],
              )
      )
    ));
}
}
class Card extends StatefulWidget{
  final List<String> id;
  final List<String> userid;
  final List<String> title;
  final List<String> encryptedData;
  final List<String> created;
  final List<String> updated;
  final String accessesToken;

  const Card(this.id,this.userid,this.title,this.encryptedData,this.created,this.updated,this.accessesToken);
  CardState createState()=>CardState(id, userid,title, encryptedData,created,updated,accessesToken);
}
class CardState extends State<Card>{
  final List<String> id;
  final List<String> userid;
  final List<String> title;
  final List<String> encryptedData;
  final List<String> created;
  final List<String> updated;
  final String accessesToken;

  CardState(this.id,this.userid,this.title,this.encryptedData,this.created,this.updated,this.accessesToken);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(padding: EdgeInsets.all(0),scrollDirection: Axis.vertical,shrinkWrap: false,
        itemCount: id.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int idx){
          if(idx==-1){
            return Container(width: 0,height: 0);
          }
          else{
            return _ourCard(id[idx],userid[idx],title[idx],encryptedData[idx],created[idx],updated[idx] ,width, height);
          }
        });
  }
  _ourCard(String id, String userid,String title, String encryptedData,
      String created, String updated , double width , double height){
    return Padding(padding: EdgeInsets.only(top: height*0.05),
    child: GestureDetector(
        onTap: (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
              GetDecryptData(accessesToken,id)),(route)=>false);
        },
        child:Container(
            height: height,
            width: width*0.9,
             decoration: BoxDecoration(border: Border.all(color: Colors.black , width: 2) , borderRadius: BorderRadius.circular(20) , color: Color.fromRGBO(192, 192, 255, 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("TITLE : " + title , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 24 , color: Colors.black),),textAlign: TextAlign.center,),
                Text("CREATED : " + created , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 24 , color: Colors.black),),textAlign: TextAlign.center,),
                Text("UPDATED : " + updated , style:GoogleFonts.comicNeue(textStyle:  TextStyle(fontSize: 24 , color: Colors.black),),textAlign: TextAlign.center,),
              ],
            )
    )));
  }
}