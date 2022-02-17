import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sultanandmeproject/loginpage.dart';

class SignUpPage extends StatefulWidget{
  SignUpPageState createState()=> SignUpPageState();
}

class SignUpPageState extends State<SignUpPage>{

  bool password1 = false;
  bool password2 = false;
  //VOIDS :
  //register account

  Future<http.Response> RegisterUser(String email , String password) async {
    //get tokens -->
    String rightPassword = password + "!!!#&*^*&^*&(*&(*&*&^TR%^\$\$#%\$";
    final response1 = await http.post(Uri.parse("http://192.168.31.121:4000/accounts/register"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
        },
        body: {"Email":email,
          "Password":rightPassword
        }
        );
    return response1;
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController retrypassword = TextEditingController();

  Widget build(BuildContext context){
    //width and height of device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false, // to avoid show bottom overflow
        body:Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsets.only(
                    left: width/25 , top: height/8, right: width/25
                ),child: Align(alignment: Alignment.centerLeft,
                    child: Text("Create Account",
                        style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold,color: Colors.black))))),
                SizedBox(width: width, child: Padding(padding: EdgeInsets.only(top:height/50 , right: width/25 , left: width/25),
                    child:Align(alignment: Alignment.centerLeft,
                    child:TextFormField(controller: email,decoration: const InputDecoration( prefixIcon: Padding(padding: EdgeInsets.only() ,
                        child: IconTheme(data: IconThemeData(color: Colors.black), child: Icon(Icons.email))),
                        enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        hintText: "user1234@email.com" , hintStyle: TextStyle(fontSize: 22 , color: Colors.grey),
                        labelText: "EMAIL" , labelStyle: TextStyle(fontSize: 18, color: Colors.grey)),
                        style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , color: Colors.black)),validator: (String?value){
                          if(value == null ||value.isEmpty){
                            return "PLEASE ENTER YOUR LOGIN OR EMAIL";}
                          return null;}))
                )),
                SizedBox(width:width, child: Padding(padding: EdgeInsets.symmetric(vertical: height/50 , horizontal: width/25),
                    child: Align(alignment: Alignment.centerLeft,
                    child:TextFormField( controller: password, obscureText: !password1,
                        decoration: InputDecoration( prefixIcon: Padding(padding: EdgeInsets.only() ,
                            child: IconTheme(data: IconThemeData(color: Colors.black), child: Icon(Icons.password))),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          hintText: "" , hintStyle: TextStyle(fontSize: 22 , color: Colors.black),
                          labelText: "PASSWORD" , labelStyle: TextStyle(fontSize: 18 , color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              password1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                password1 = !password1;
                              });
                            },
                          ),
                        ),
                        style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , color: Colors.black)),validator: (String?value){
                          if(value == null ||value.isEmpty){
                            return "PLEASE ENTER YOUR PASSWORD";}
                          return null;})))),
                SizedBox(width:width, child: Padding(padding: EdgeInsets.symmetric(vertical: height/50 , horizontal: width/25),child: Align(alignment: Alignment.centerLeft,
                    child:TextFormField( controller: retrypassword,obscureText: !password2,
                        decoration: InputDecoration( prefixIcon: Padding(padding: EdgeInsets.only() ,
                            child: IconTheme(data: IconThemeData(color: Colors.black), child: Icon(Icons.password))),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          hintText: "" ,hintStyle: TextStyle(fontSize: 22 , color: Colors.black),
                          labelText: " CONFIRM PASSWORD" , labelStyle: TextStyle(fontSize: 18 , color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              password2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                password2 = !password2;
                              });
                            },
                          ),
                        ),
                        style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , color: Colors.black)),validator: (String?value){
                          if(value == null ||value.isEmpty){
                            return "PLEASE ENTER YOUR PASSWORD";}
                          return null;})))),
                Padding(padding:  EdgeInsets.symmetric(vertical: height/50),
                    child: SizedBox(width: width/2,height:height/20,
                      child: ElevatedButton(
                          child: Text("SIGN UP " ,
                        style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18 , color: Colors.white))),
                        onPressed:() async {
                          // Validate will return true if the form is valid, or false if
                          if(password.text==retrypassword.text && email.text.isNotEmpty){
                            await RegisterUser(email.text, password.text).then((value) => Future.delayed(const Duration(milliseconds: 100), () {
                              // Here you can write your code
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                                  LoginPage()),(route)=>false);
                            }));
                          }
                        },style:ElevatedButton.styleFrom(primary: Colors.blue)
                    ),
                    )),
                Padding(padding: EdgeInsets.only(top: height/8 ,bottom: height*0.05),
                    child: Align(alignment: Alignment.center,child: Text.rich(TextSpan(
                        text: "Already have an account?", style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18),color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(text: " Sign in" ,
                              style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.blue)) ,
                              recognizer: TapGestureRecognizer()
                                ..onTap =(){
                                  //go to sign up screen ==>
                                  Navigator.pop(context);
                                })
                        ]
                    ))))
              ],
            )));
  }
}