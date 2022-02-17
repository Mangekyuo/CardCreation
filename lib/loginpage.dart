import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sultanandmeproject/mainpage.dart';
import 'package:sultanandmeproject/signuppage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget{
  LoginPageState createState()=> LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  //bool to show password ->
  bool passwordVisible = false;

  //VOIDS :

  Future<String> LoginUser(String email , String password) async {
    //get tokens -->
    String rightPassword = password + "!!!#&*^*&^*&(*&(*&*&^TR%^\$\$#%\$";
    String accessesToken="";
    final response1 = await http.post(Uri.parse("http://192.168.31.121:4000/auth/token"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
        },
        body: {"Email":email,
          "Password":rightPassword
        }
    );
    if(response1.statusCode!=200){
      print("Something went wrong to server can't work with server");
    }
    String res = response1.body.toString();
    String redo = res.substring(1,res.length-1).replaceAll("{", "").replaceAll("}", "").replaceAll(":", "").replaceAll("[", "").replaceAll("]", "");
    for (String a in redo.split(",")) {
      if(a!=""){
        if(a.substring(1,2)=="A"){
          accessesToken = a.substring(13,a.length);
        }
      }
    }
    print("Task done");
    return accessesToken;
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(
                  left: width/25 , top: height/5, right: width/25
              ),child: Align(alignment: Alignment.centerLeft,child: Text("Login",style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold,color: Colors.black))))),
              Padding(padding: EdgeInsets.symmetric(vertical: height/25 , horizontal: width/25),child: Align(alignment: Alignment.centerLeft,child:  Text("Please sign in to continue" , style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black))))),

              SizedBox(width: width, child: Padding(padding: EdgeInsets.only(top:height/50 , right: width/25 , left: width/25),child:Align(alignment: Alignment.centerLeft,
                  //< keyboard type check -->
                  child:TextFormField(controller: email, keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration( prefixIcon: Padding(padding: EdgeInsets.only() ,
                          child: IconTheme(data: IconThemeData(color: Colors.black), child: Icon(Icons.email)
                          )
                      ),
                          enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          hintStyle: TextStyle(fontSize: 22 , color: Colors.grey),
                          hintText: "user1234@email.com", labelText: "EMAIL" , labelStyle: TextStyle(fontSize: 18, color: Colors.grey)),
                      style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , color: Colors.black)),validator: (String?value){
                        if(value == null ||value.isEmpty){
                          return "PLEASE ENTER YOUR LOGIN OR EMAIL";}
                        return null;}))
              )),

              //password ->
              SizedBox(width:width, child: Padding(padding: EdgeInsets.symmetric(vertical: height/50 , horizontal: width/25),child: Align(alignment: Alignment.centerLeft,
                  child:TextFormField( controller: password, keyboardType: TextInputType.text,
                      obscureText: !passwordVisible, //this will obscure text dynamically
                      decoration: InputDecoration( prefixIcon: Padding(padding: EdgeInsets.only() ,
                          child: IconTheme(data: IconThemeData(color: Colors.black), child: Icon(Icons.password))),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),hintStyle: TextStyle(fontSize: 22 , color: Colors.black),
                        hintText: "" , labelText: "PASSWORD" , labelStyle: TextStyle(fontSize: 18 , color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , color: Colors.black)),validator: (String?value){
                        if(value == null ||value.isEmpty){
                          return "PLEASE ENTER YOUR PASSWORD";}
                        return null;})))),
              Padding(padding:  EdgeInsets.symmetric(vertical: height/50),
                  child: SizedBox(width: width/2,height:height/20, child: ElevatedButton(child: Text("LOGIN " ,
                      style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18, color: Colors.white))),
                      onPressed:() async {
                        // Validate will return true if the form is valid, or false if
                          print("Clicked");
                            await LoginUser(email.text, password.text).then((value) => Future.delayed(const Duration(milliseconds: 100), () {
                              // Here you can write your code
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                                  MainPage(value)),(route)=>false);
                            }));
                      },
                      style:ElevatedButton.styleFrom(primary: Colors.blue)
                  ),
                  )),
              Padding(padding: EdgeInsets.only(top: height/5),
                  child: Align(alignment: Alignment.center,
                      child: Text.rich(TextSpan(
                      text: "Don't have an account?", style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18,color: Colors.black)),
                      children: <TextSpan>[
                        TextSpan(text: " Sign up" , style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.blue)) , recognizer: TapGestureRecognizer()
                          ..onTap =(){
                            //go to sign up screen ==>
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
                          })
                      ]
                  )))),
            ],
          )),
    );
  }
}