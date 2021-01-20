import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management/Home.dart';
import 'package:student_management/HomePage.dart';
import 'package:student_management/RegistationPage.dart';
import 'package:student_management/ResetPasswordPage.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey=GlobalKey<FormState>();
  final _emailClt=TextEditingController();
  final _passClt=TextEditingController();

var Email,Password;
var cheak=true;


  singInToFirebase()async{
    if(formKey.currentState.validate()){
      formKey.currentState.save();
       setState(() {
         cheak=false;
       });
       FirebaseAuth firebaseAuth=FirebaseAuth.instance;
       User user= (await firebaseAuth.signInWithEmailAndPassword(email: Email, password: Password)).user;
      if(user!=null){

        setState(() {
          cheak=true;
        });
        Fluttertoast.showToast(
            msg: "Login Sucesss",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
        sharedPreferences.setString('mail', 'useremail@gmail.com');


        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }
      else{
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    }
  }
  var firstLogin;
  @override
  void initState() {
    firstLogin=false;
    getFirstLoginData();

    if(firstLogin){
      Route route=MaterialPageRoute(builder: (context)=>HomePage());
      Navigator.push(context, route);
    }


    super.initState();
  }
  getFirstLoginData()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      firstLogin=   sharedPreferences.getBool('firstLogin');
    });

  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blue[400],
     // resizeToAvoidBottomInset: false,
     // resizeToAvoidBottomPadding: true,
      body:
         SingleChildScrollView(
           child: Padding(
             padding: EdgeInsets.only(top:60),
             child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                    CircleAvatar(
                      radius: 30,
                      child: SvgPicture.asset("assets/images/profile.svg"),
                    ),

                  Container(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 5,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        padding: EdgeInsets.only(top:60,left:18,right: 18),
                        height: height * 0.6,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          //boxShadow: [BoxShadow(color: Colors.white,offset: Offset(5,5),blurRadius: 1.0,spreadRadius: 1.0)]

                        ),
                        child: Form(
                          key: formKey,
                          autovalidate: true,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  /*enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                      width: 6
                                    ),
                                    borderRadius: BorderRadius.circular(10),

                                  ),*/
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green,
                                      width:4

                                    ),
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                  hintText:"Email",

                                  prefixIcon: Icon(Icons.email,color: Colors.blue,),
                                  filled: true,
                                  fillColor: Colors.grey[200],


                                ),


                                controller: _emailClt,
                                validator: (value){
                                  if(value.trim().isEmpty){
                                    return "Empty Feild";
                                  }
                                },
                                onSaved: (value){
                                  Email=value;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                   /* enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      ),
                                      borderRadius: BorderRadius.circular(10),

                                    ),*/
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.green,
                                        width: 4
                                      ),
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                    hintText:"Password",
                                    prefixIcon: Icon(Icons.lock,color: Colors.blue,),
                                    filled: true,
                                    fillColor: Colors.grey[200]
                                ),
                                controller: _passClt,
                                obscureText: true,
                                validator: (value){
                                  if(value.trim().isEmpty){
                                    return "Empty Feild";
                                  }
                                  else if(value.length<6){
                                    return "Password must at least 6 letter";
                                  }
                                },
                                onSaved: (value){
                                  Password=value;
                                },
                              ),
                              SizedBox(height: 20,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  InkWell(child: Text("Forgot Password?",style: TextStyle(decoration: TextDecoration.underline),),
                                    onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordPage()));
                                    },

                                  )
                                ],
                              ),
                              SizedBox(height: 30,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                ),
                                width: width,

                                child: FlatButton(
                                  child:cheak? Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ):
                                  CircularProgressIndicator(backgroundColor: Colors.white,),

                                  onPressed: () {
                                    singInToFirebase();
                                  },
                                ),

                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(

                             child:Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text("Create an account?"),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: InkWell(child: Text("SignUp",style: TextStyle(color: Colors.blue),),onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegestationPage()));
                                      },),
                                    )
                                  ],
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
        ),
           ),
         ),

    );
  }
}
