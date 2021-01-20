
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management/Home.dart';
import 'package:student_management/HomePage.dart';
import 'package:path/path.dart' as path;
import 'package:student_management/LoginPage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var cheak=true;
  File _image;
  var Uid;
  var CurrentUserName;
  var CurrentImage;
  //var UpdateUserName=null;

  var userNameClt=TextEditingController();
  String downloadImageLink;

 Future imagePickFromStroge() async{
    final pickedFile=await ImagePicker().getImage(source: ImageSource.gallery);
    print(pickedFile.path);
    setState(() {
      if(pickedFile!=null){
        _image=File(pickedFile.path);
      }
      else{
        print("No Image Selected");
      }

    });


  }



    // Get Current  UserId
  getCurrentUserUid() async{
    FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    User user=firebaseAuth.currentUser;

    final Uid=user.uid;
    print(Uid);
    setState(() {
      this.Uid=Uid.toString()+'a';

    });

  }

  //Update Profile Info

  updateUserInformation(var currentImage)async{
   String filename=path.basename(_image.path);
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref().child(filename);

  firebase_storage.UploadTask uploadTask=ref.putFile(_image);
  firebase_storage.TaskSnapshot taskSnapshot=await uploadTask;
  if(taskSnapshot!=null){
    print("Save Image");
  }
  else{
    print("Unsave image");
  }

   setState(() {
     CurrentImage=currentImage;
   });

   getDownloadImage();
  }
   //Get Current Profile link
  getDownloadImage()async{
    String filename=path.basename(_image.path);
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref().child(filename);
   String downloadAddress=await ref.getDownloadURL();
   setState(() {
     downloadImageLink=downloadAddress;

   });

    CollectionReference users=FirebaseFirestore.instance.collection(Uid);
     users.doc('ProfileInfo').update({
       'Image':downloadImageLink==null?CurrentImage:downloadImageLink,

     }).then((value){

       Fluttertoast.showToast(
           msg: "Update info sucessfull",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.green,
           textColor: Colors.white,
           fontSize: 16.0
       );
       Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
     }).catchError((error){
       Fluttertoast.showToast(
           msg: "Update fail",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     });

  }

  //SignOut Methhod
  signOutMethod(){

   FirebaseAuth.instance.signOut().then((value){

    Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
   });


  }
  deleteUserMethod()async{
   User user=await FirebaseAuth.instance.currentUser;
   user.delete().then((value)async{
     Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
     CollectionReference collectionReference= await FirebaseFirestore.instance.collection(Uid);
   await collectionReference.doc('ProfileInfo').delete().then((value) {
       Fluttertoast.showToast(msg: "User delete sucessfull ");

     });

   });


  }


//AlertDialoge
  showAlertDialoge(BuildContext context){

   Widget cancelButton=new FlatButton(
     child: Text('No'),onPressed: (){Navigator.pop(context);}
   );
   Widget yesButton=new FlatButton(
       child: Text('Yes'),onPressed: (){deleteUserMethod();}
   );

   AlertDialog alertDialog=new AlertDialog(
     title: Text("Delete",style: TextStyle(color: Colors.red),),
     content: Text("If you click yes your account will be delete permanently.You will be lost you data and find again impossible."),
     actions: <Widget>[
       cancelButton,
       yesButton,
     ],
   );
   showDialog(
       context: context,
       builder:(context){
         return alertDialog;
       }
   );

  }

  //Init State

  @override
  void initState() {
    getCurrentUserUid();

    super.initState();
  }

  // Builld method start


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,

      ),
      body:StreamBuilder(
            stream: FirebaseFirestore.instance.collection(Uid).snapshots(),
            builder: (context,snapshort){
              if(!snapshort.hasData){
                return   Center(child: CircularProgressIndicator());
              }
              else{
                return   SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: _image==null?NetworkImage(snapshort.data.documents[0]["Image"]):FileImage(_image),
                              radius: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: InkWell(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 25,
                                ),
                                onTap: (){
                                  imagePickFromStroge();
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child:cheak? Text(
                                snapshort.data.documents[0]["Username"],
                                style: TextStyle(fontSize: 25),
                              ):Container(
                                width: MediaQuery.of(context).size.width*0.6,
                                child:TextField(
                                  controller: userNameClt,
                                    decoration: InputDecoration(
                                        hintText: "Change Profile Name"
                                    ),



                                  ),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                child: InkWell(
                                  child: Icon(Icons.edit),
                                  onTap: () {
                                    setState(() {
                                      cheak=!cheak;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text( snapshort.data.documents[0]["Email"],),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Create at-"+snapshort.data.documents[0]["Date"],),

                        SizedBox(
                          height: 40,
                        ),
                       
                        SizedBox(height: 30,),
                       /* Visibility(
                          visible:cheak1,
                          child: Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width*0.7,
                            child: Form(
                              autovalidate: true,
                              key:_formkey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      hintText:"Old Password",

                                    ),
                                    validator: (value){
                                      if(value.trim().isEmpty){
                                        return "Empty Feild";
                                      }
                                    },
                                    onSaved: (value){
                                      OldPassword=value;
                                    },
                                    controller: oldPassClt,

                                  ),
                                  SizedBox(height: 10,),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      hintText:"New Password",
                                    ),
                                    validator: (value){
                                      if(value.trim().isEmpty){
                                        return "Empty Feild";
                                      }
                                      else if(value.length<6){
                                        return "Password at least 6 letter";
                                      }
                                    },
                                    onSaved: (value){
                                      NewPassword=value;
                                    },
                                    controller: newPassClt,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
*/

                        Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                          ),
                          child: FlatButton(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: (){
                              updateUserInformation(snapshort.data.documents[0]["Image"]);
                            },
                          ),

                        ),
                        SizedBox(height: 15,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                          ),
                          child: FlatButton(
                            child: Text(
                              "Change Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: (){
                              setState(() {

                              });
                            },
                          ),

                        ),
                        SizedBox(height: 15,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                          ),
                          child: FlatButton(

                              child: Text(
                                "LogOut",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),


                            onPressed: ()async{

                                SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                                sharedPreferences.remove('mail');

                                signOutMethod();

                            },
                          ),

                        ),
                        SizedBox(height: 15,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: FlatButton(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: (){
                             showAlertDialoge(context);
                            },
                          ),

                        ),

                      ],
                    ),
                  ),
                );
              }

            },
          )


      );

  }
}
