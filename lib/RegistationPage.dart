
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management/HomePage.dart';
import 'package:student_management/LoginPage.dart';

class RegestationPage extends StatefulWidget { 
  _RegestationPageState createState() => _RegestationPageState();
}

class _RegestationPageState extends State<RegestationPage> {
  var formKey = GlobalKey<FormState>();

  final _userNameClt = TextEditingController();
  final _emailClt = TextEditingController();
  final _passClt = TextEditingController();
  final _conformPassClt = TextEditingController();

  var Username, Email, Password, ConformPassword;
  var cheak=true;
 Timer timer;



  registerToFirebase() async{
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (Password != ConformPassword) {
        Fluttertoast.showToast(
            msg: "Password not match",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return;
      }
      setState(() {
        cheak=false;
      });
      FirebaseAuth firebaseAuth=FirebaseAuth.instance;
   final   User user=(await firebaseAuth.createUserWithEmailAndPassword(email: Email, password: Password)).user;
   if(user!=null){
     setState(() {
       cheak=true;
     });

     User user=firebaseAuth.currentUser;
     user.sendEmailVerification();
/*timer= Timer.periodic(Duration(seconds: 20), (timer) {
       checkEmailVerified();

     });*/
    Fluttertoast.showToast(
         msg: "Send a conform mail in your email",
         toastLength: Toast.LENGTH_LONG,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         textColor: Colors.white,
         fontSize: 16.0
     );
     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
   }
   else{
     Fluttertoast.showToast(
         msg: "Something Wrong..",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 16.0
     );
   }

    }

    storeUserInform();

  }

  var userId;
  var date;
  storeUserInform()async{
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    User user=firebaseAuth.currentUser;
    setState(() {
      this.userId=user.uid.toString()+"a";
    });
    final userInform=await FirebaseFirestore.instance.collection(userId).doc("ProfileInfo").set({
      'Username':Username,
      'Email':Email,
      'Password':Password,
      'Date':date,
      'Image':'https://maxcdn.icons8.com/Share/icon/Users//user_male_circle_filled1600.png'

    });

  }

 /* Future<void>checkEmailVerified()async{
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    User user= firebaseAuth.currentUser;
    await user.reload();
    if(user.emailVerified){
      Fluttertoast.showToast(
          msg: "Register Sucessfull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      timer.cancel();
     *//* SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString('mail', 'useremail@gmail.com');*//*
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }

  }*/
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  void initState() {

     var now=new DateTime.now();
     var formatter=new DateFormat.yMMMMd('en_Us');
     String formattedDate=formatter.format(now);
     date=formattedDate;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.blue[400],
        // resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomPadding: true,

        body: LayoutBuilder(builder: (context, constraint) {
        return  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top:25.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30,
                            child: SvgPicture.asset("assets/images/profile.svg"),
                          ),
                          Container(
                            child: Text(
                              "Sign Up",
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                padding:
                                    EdgeInsets.only(top: 40, left: 18, right: 18),
                                height: height * 0.7,
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
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green, width: 4),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintText: "Username",
                                            prefixIcon: Icon(
                                              Icons.supervised_user_circle,
                                              color: Colors.blue,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200]),
                                        controller: _userNameClt,
                                        validator: (value) {
                                          if (value.trim().isEmpty) {
                                            return "Empty Feild";
                                          }
                                        },
                                        onSaved: (value) {
                                          Username = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green, width: 4),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintText: "Email",
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: Colors.blue,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200]),
                                        controller: _emailClt,
                                        validator: (value) {
                                          if (value.trim().isEmpty) {
                                            return "Empty Feild";
                                          }
                                        },
                                        onSaved: (value) {
                                          Email = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green, width: 4),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintText: "Password",
                                            prefixIcon: Icon(
                                              Icons.lock,
                                              color: Colors.blue,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200]),
                                        controller: _passClt,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Empty Feild";
                                          } else if (value.length < 6) {
                                            return "Password must at least 6 letter";
                                          }
                                        },
                                        onSaved: (value) {
                                          Password = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green, width: 4),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintText: "Confirm password",
                                            prefixIcon: Icon(
                                              Icons.lock,
                                              color: Colors.blue,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[200]),
                                        controller: _conformPassClt,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Empty Feild";
                                          } else if (value.length < 6) {
                                            return "Password must at least 6 letter";
                                          }
                                        },
                                        onSaved: (value) {
                                          ConformPassword = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.blue,
                                        ),
                                        width: width,
                                        child: FlatButton(
                                          child:cheak? Text(
                                            "REGISTER",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ):
                                          CircularProgressIndicator(backgroundColor: Colors.white,),

                                          onPressed: () async {
                                            var connectivityResult = await(Connectivity().checkConnectivity());
                                            if (connectivityResult == ConnectivityResult.mobile ||
                                                connectivityResult == ConnectivityResult.wifi) {
                                              registerToFirebase();
                                            } else {
                                              Fluttertoast.showToast(msg: 'Please check your internet connection',
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                              );
                                            }

                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                          child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Text("Have an account?"),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: InkWell(
                                              child: Text(
                                                "SignIn",
                                                style:
                                                    TextStyle(color: Colors.blue),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage()));
                                              },
                                            ),
                                          )
                                        ],
                                      ))
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
              ),
            ),
          );
        }));
  }
}
