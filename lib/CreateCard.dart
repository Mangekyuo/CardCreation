import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'mainpage.dart';

class GenerateDataforCreateCard extends StatefulWidget{
  String AccessesToken;
  String data;
  String keydata;
  GenerateDataforCreateCard(this.AccessesToken,this.data,this.keydata);
  GenerateDataforCreateCardState createState()=> GenerateDataforCreateCardState(AccessesToken,data,keydata);
}
class GenerateDataforCreateCardState extends State<GenerateDataforCreateCard>{
  String AccessesToken;
  String data;
  String keydata;
  GenerateDataforCreateCardState(this.AccessesToken,this.data,this.keydata);

  TextEditingController title = TextEditingController();
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
                SizedBox(width: width,
                    child: Padding(padding: EdgeInsets.only(top:height/50 , right: width/25 , left: width/25),
                        child:Align(alignment: Alignment.centerLeft,
                    //< keyboard type check -->
                    child:TextFormField(controller: title, keyboardType: TextInputType.text,
                        decoration: const InputDecoration( prefixIcon: Padding(padding: EdgeInsets.only() ,
                            child: IconTheme(data: IconThemeData(color: Colors.black), child: Icon(Icons.text_fields)
                            )
                        ),
                            enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            hintStyle: TextStyle(fontSize: 22 , color: Colors.grey),
                            hintText: "Hello World!", labelText: "Text" , labelStyle: TextStyle(fontSize: 18, color: Colors.grey)),
                        style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , color: Colors.black)),validator: (String?value){
                          if(value == null ||value.isEmpty){
                            return "PLEASE ENTER YOUR LOGIN OR EMAIL";}
                          return null;}))
                )
                ),
                Padding(padding:  EdgeInsets.symmetric(vertical: height/50),
                    child: SizedBox(width: width/2,height:height/20, child: ElevatedButton(child: Text("Create Card" ,
                        style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18, color: Colors.white))),
                        onPressed:() async {
                          // Validate will return true if the form is valid, or false if
                          if(title.text.isNotEmpty){
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                                  ExtraGetData(title.text , AccessesToken , data , keydata)),(route)=>false);
                          }
                        },
                        style:ElevatedButton.styleFrom(primary: Colors.blue)
                    ),
                    )),
              ],
            )
        )
    );
  }
}

class ExtraGetData extends StatefulWidget{
  String titledatatext;
  String AccessesToken;
  String data;
  String keydata;
  ExtraGetData(this.titledatatext,this.AccessesToken,this.data,this.keydata);
  ExtraGetDataState createState()=> ExtraGetDataState(titledatatext,AccessesToken,data,keydata);
}
class ExtraGetDataState extends State<ExtraGetData>{
  String titledatatext;
  String AccessesToken;
  String data;
  String keydata;
  ExtraGetDataState(this.titledatatext,this.AccessesToken,this.data,this.keydata);

  List<String> title =<String>[];
  List<String> created =<String>[];
  List<String> updated =<String>[];
  Future<http.Response> GenerateCardmethod() async {
    String token = "Bearer " + AccessesToken;
    final response1 = await http.post(Uri.parse("http://192.168.31.121:4000/cards"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": token
        },
        body:jsonEncode(<String,dynamic>{
          "Data": data,
          "Key": keydata,
          "Title":titledatatext
        }),
        encoding: Encoding.getByName("utf-8"));

    String res = response1.body.toString();
    String redo = res.substring(1,res.length-1).replaceAll("{", "").replaceAll("}", "").replaceAll(":", "").replaceAll("[", "").replaceAll("]", "");
    for (String a in redo.split(",")) {
      if(a!=""){
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
    await GenerateCardmethod().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
        CreCard(title,created,updated,AccessesToken)),(route)=>false));
  }
  @override
  Widget build(BuildContext context) {
    getDatases();
    return Container();
  }
}

class CreCard extends StatefulWidget{
  final List<String> title;
  final List<String> created;
  final List<String> updated;
  final String token;
  CreCard(this.title,this.created,this.updated,this.token);
  CreCardState createState()=>CreCardState(title,created,updated,token);
}
class CreCardState extends State<CreCard>{
  final List<String> title;
  final List<String> created;
  final List<String> updated;
  final String token;
  CreCardState(this.title,this.created,this.updated,this.token);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                              String sendDAta = "W"+token+"W";
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                                  MainPage(sendDAta)),(route)=>false);
                            })
                        ]
                    )),
                    Container(width: width*0.9, height: height*0.8, child: Card(title,created,updated))
                  ],
                )
            )
        ));
  }
}

class Card extends StatefulWidget{

  final List<String> title;
  final List<String> created;
  final List<String> updated;

  const Card(this.title,this.created,this.updated);
  CardState createState()=>CardState(title,created,updated);
}
class CardState extends State<Card>{
  final List<String> title;
  final List<String> created;
  final List<String> updated;

  CardState(this.title,this.created,this.updated);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(padding: EdgeInsets.all(0),scrollDirection: Axis.vertical,shrinkWrap: false,
        itemCount: title.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int idx){
          if(idx==-1){
            return Container(width: 0,height: 0);
          }
          else{
            return _ourCard(title[idx],created[idx],updated[idx] ,width, height);
          }
        });
  }
  _ourCard(String title,
      String created, String updated , double width , double height){
    return Padding(padding: EdgeInsets.only(top: height*0.05),
        child: GestureDetector(
            onTap: (){
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