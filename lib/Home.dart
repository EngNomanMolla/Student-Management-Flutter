import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:student_management/CreatePage.dart';
import 'package:student_management/SpecificStudntDataDisplay.dart';
import 'package:student_management/StudentFormInformation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentUid;
  var semester = '1st';
  var cheak = false;
  var number;
  var searchString;
  var colorlist = [
    Colors.lightBlueAccent,
    Colors.black26,
    Colors.green[200],
    Colors.deepPurpleAccent[200],
    Colors.amber[200]
  ];

  void getCurrentUid() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User user = await firebaseAuth.currentUser;
    setState(() {
      currentUid = user.uid.toString();
    });
  }

  getRandomNumber() {
    Random random = new Random();
    setState(() {
      this.number = random.nextInt(5);
    });
  }

  @override
  void initState() {
    getCurrentUid();
    getRandomNumber();
    // semester = '1st';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<StudentInformation>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: width,
            height: height / 2 * 0.2 + 12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.lightBlueAccent]),
                boxShadow: [
                  BoxShadow(color: Colors.black54, blurRadius: 10.0)
                ]),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(left: 13, right: 13),
                    child: DropdownButton(
                      iconSize: 30,
                      isExpanded: true,
                      hint: Text(semester),
                      underline: SizedBox(),
                      items: [
                        DropdownMenuItem(
                          value: "1st",
                          child: Text("1st"),
                        ),
                        DropdownMenuItem(
                          value: "2nd",
                          child: Text("2nd"),
                        ),
                        DropdownMenuItem(
                          value: "3rd",
                          child: Text("3rd"),
                        ),
                        DropdownMenuItem(
                          value: "4th",
                          child: Text("4th"),
                        ),
                        DropdownMenuItem(
                          value: "5th",
                          child: Text("5th"),
                        ),
                        DropdownMenuItem(
                          value: "6th",
                          child: Text("6th"),
                        ),
                        DropdownMenuItem(
                          value: "7th",
                          child: Text("7th"),
                        ),
                        DropdownMenuItem(
                          value: "8th",
                          child: Text("8th"),
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          semester = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Visibility(
                    visible: cheak,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.all(6),
                      child: TextField(
                        decoration:
                            InputDecoration(hintText: 'Search with roll...'),
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            searchString=value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          cheak = !cheak;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream:(searchString==null||searchString.toString().trim()=='')? FirebaseFirestore.instance
                    .collection(currentUid.toString() + semester)
                    .snapshots():FirebaseFirestore.instance.collection(currentUid.toString()+semester).where('IndexList',arrayContains: searchString).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return snapshot.data.documents.length == 0
                        ? Container(
                            child: Center(
                                child: Text(
                              'No student have $semester semester ',
                              style: TextStyle(fontSize: 20),
                            )),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: colorlist[number],
                                    child: Text(snapshot
                                        .data.documents[index]['Name'][0]
                                        .toString()
                                        .toUpperCase()),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                        snapshot.data.documents[index]["Name"]),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                        snapshot.data.documents[index]['Roll']),
                                  ),
                                  onLongPress: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                FlatButton(
                                                  child: Text(
                                                    'Update',
                                                    style:TextStyle(
                                                        color:
                                                        Colors.lightBlue,
                                                      fontSize: 18
                                                    ),


                                                  ),
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePage(true,snapshot.data.documents[index]["Gender"])));

                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text('Delete',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.red,
                                                        fontSize: 18
                                                    ),
                                                  ),
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                    Widget cancelButton=new FlatButton(
                                                        child: Text('No'),onPressed: (){Navigator.pop(context);}
                                                    );
                                                    Widget yesButton=new FlatButton(
                                                        child: Text('Yes'),onPressed: ()async{
                                                      getCurrentUid();
                                                      var uniqeId= snapshot
                                                          .data.documents[index]["UniqueId"];
                                                      var semester= snapshot
                                                          .data.documents[index]["Semester"];
                                                      var collectionId=(currentUid+semester).toString();
                                                      Navigator.pop(context);

                                                      final collectionReference= await FirebaseFirestore.instance.collection(collectionId);
                                                      await collectionReference.doc(uniqeId.toString()).delete().then((value) {
                                                        Fluttertoast.showToast(msg: "Student delete sucessfull ");

                                                      }).catchError((onError){
                                                        Fluttertoast.showToast(msg: "Student delete not  sucessfull ");
                                                      });
                                                    }
                                                    );

                                                    AlertDialog alertDialog=new AlertDialog(
                                                      title: Text("Delete",style: TextStyle(color: Colors.red),),
                                                      content: Text("Are you sure want to delete this student?"),
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

                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                    data.uniqeId= snapshot
                                        .data.documents[index]["UniqueId"].toString();

                                    data.Semester = snapshot
                                        .data.documents[index]["Semester"];
                                    data.Name =
                                    snapshot.data.documents[index]["Name"];
                                    data.Technology = snapshot
                                        .data.documents[index]["Technology"];
                                    data.Number = snapshot.data.documents[index]
                                    ["Phone Number"];
                                    data.Roll =
                                    snapshot.data.documents[index]["Roll"];
                                    data.Registation = snapshot
                                        .data.documents[index]["Registation"];
                                    data.ClassGroup = snapshot
                                        .data.documents[index]["Class Group"];
                                    data.PhoneNumber = snapshot
                                        .data.documents[index]["Phone Number"];
                                    data.BloodGroup = snapshot
                                        .data.documents[index]["Blood Group"];
                                    data.Religion = snapshot
                                        .data.documents[index]["Religion"];
                                    data.Nationality = snapshot
                                        .data.documents[index]["Nationality"];
                                    data.Email =
                                    snapshot.data.documents[index]["Email"];
                                    data.Gender = snapshot.data.documents[index]
                                    ["Gender"];
                                    data.FathersName = snapshot
                                        .data.documents[index]["FatherName"];

                                    data.Mothersnumber =
                                    snapshot.data.documents[index]
                                    ["FatherPhoneNumber"];

                                    data.MothersName = snapshot
                                        .data.documents[index]["MotherName"];

                                    data.Mothersnumber =
                                    snapshot.data.documents[index]
                                    ["MotherPhoneNumber"];


                                    data.firstSem = snapshot
                                        .data.documents[index]["FirstSem"];
                                    data.secondSem = snapshot
                                        .data.documents[index]["SecondSem"];
                                    data.thirdSem = snapshot
                                        .data.documents[index]["ThirdSem"];
                                    data.fourthSem = snapshot
                                        .data.documents[index]["FourthSem"];
                                    data.fifthSem = snapshot
                                        .data.documents[index]["FifthSem"];
                                    data.sixthSem = snapshot
                                        .data.documents[index]["SixthSem"];
                                    data.seventhSem = snapshot
                                        .data.documents[index]["SevenSem"];
                                    data.eighthSem = snapshot
                                        .data.documents[index]["EightSem"];
                                  },
                                  onTap: () {
                                    data.Semester = snapshot
                                        .data.documents[index]["Semester"];
                                    data.Name =
                                        snapshot.data.documents[index]["Name"];
                                    data.Technology = snapshot
                                        .data.documents[index]["Technology"];
                                    data.Number = snapshot.data.documents[index]
                                        ["Phone Number"];
                                    data.Roll =
                                        snapshot.data.documents[index]["Roll"];
                                    data.Registation = snapshot
                                        .data.documents[index]["Registation"];
                                    data.ClassGroup = snapshot
                                        .data.documents[index]["Class Group"];
                                    data.PhoneNumber = snapshot
                                        .data.documents[index]["Phone Number"];
                                    data.BloodGroup = snapshot
                                        .data.documents[index]["Blood Group"];
                                    data.Religion = snapshot
                                        .data.documents[index]["Religion"];
                                    data.Nationality = snapshot
                                        .data.documents[index]["Nationality"];
                                    data.Email =
                                        snapshot.data.documents[index]["Email"];
                                    data.Gender = snapshot.data.documents[index]
                                        ["Gender"];
                                    data.FathersName = snapshot
                                        .data.documents[index]["FatherName"];
                                    data.FathersNumber = snapshot.data.documents[index]["FatherPhoneNumber"];

                                    data.MothersName = snapshot
                                        .data.documents[index]["MotherName"];
                                    data.Mothersnumber = snapshot.data.documents[index]["MotherPhoneNumber"];

                                    data.firstSem = snapshot
                                        .data.documents[index]["FirstSem"];
                                    data.secondSem = snapshot
                                        .data.documents[index]["SecondSem"];
                                    data.thirdSem = snapshot
                                        .data.documents[index]["ThirdSem"];
                                    data.fourthSem = snapshot
                                        .data.documents[index]["FourthSem"];
                                    data.fifthSem = snapshot
                                        .data.documents[index]["FifthSem"];
                                    data.sixthSem = snapshot
                                        .data.documents[index]["SixthSem"];
                                    data.seventhSem = snapshot
                                        .data.documents[index]["SevenSem"];
                                    data.eighthSem = snapshot
                                        .data.documents[index]["EightSem"];

                                    Route route = MaterialPageRoute(
                                        builder: (context) =>
                                            specificStudentDataDisplay(
                                              snapshot.data.documents[index]["FirstSem"],
                                            snapshot.data.documents[index]["SecondSem"],
                                             snapshot.data.documents[index]["ThirdSem"],
                                         snapshot.data.documents[index]["FourthSem"],
                                                snapshot.data.documents[index]["FifthSem"],
                                               snapshot.data.documents[index]["SixthSem"],
                                                snapshot.data.documents[index]["SevenSem"],
                                              snapshot.data.documents[index]["EightSem"],


                                            ));
                                    Navigator.push(context, route);
                                  },
                                ),
                              );
                            });
                  }
                }),
          )
        ],
      ),
    );
  }
}
