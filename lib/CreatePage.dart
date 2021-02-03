

import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management/Home.dart';
import 'package:student_management/HomePage.dart';
import 'package:student_management/StudentFormInformation.dart';

class CreatePage extends StatefulWidget {
  var isUpdate;
  var gender;
  @override
  _CreatePageState createState() => _CreatePageState(isUpdate,gender);
  CreatePage(this.isUpdate,this.gender);
}

class _CreatePageState extends State<CreatePage> {
  var isUpdate;
  var gender;
  _CreatePageState(this.isUpdate,this.gender);
  var _formkey=GlobalKey<FormState>();

  var selectionGrooupValue;
  var currentUid;
  var item;
  var technology='Computer';
  var documentId;
  var cheak=true;

  //Controller variable
  var nameClt=TextEditingController();
  var rollClt=TextEditingController();
  var regClt=TextEditingController();
  var classGroupClt=TextEditingController();
  var phoneNumberClt=TextEditingController();
  var bloodGroupClt=TextEditingController();
  var religionClt=TextEditingController();
  var nationalityClt=TextEditingController();
  var emailClt=TextEditingController();
  var fatherNameClt=TextEditingController();
  var fatherNumberClt=TextEditingController();
  var motherNameClt=TextEditingController();
  var motherNumberClt=TextEditingController();
  var firstSemClt=TextEditingController();
  var secondSemClt=TextEditingController();
  var thirdSemClt=TextEditingController();
  var fourthSemClt=TextEditingController();
  var fifthSemClt=TextEditingController();
  var sixthSemClt=TextEditingController();
  var sevenSemClt=TextEditingController();
  var eightSemClt=TextEditingController();



  //Student Information feild validation
  var Name;
  var Roll;
  var Regestation;
  var ClassGroup;
  var PhoneNumber;
  var BloodGroup='';
  var Religion;
  var Nationality;
  var Email='';
  var selectionGender;

  // Guirdian Information feild validation
  var FatherName;
  var FatherPhoneNumber='';
  var MotherName;
  var MotherPhoneNumber='';

  // Result Information feild validation
  var firstSemester='';
  var secondSemester='';
  var thirdSemester='';
  var fourthSemester='';
  var fifthSemester='';
  var sixthSemester='';
  var seventhSemester='';
  var eightSemester='';

    Future<Void>updateStudentData()async{


    }
  createRandomNumber(){
   Random random =new Random();
   int documentId=random.nextInt(10000);
   setState(() {
     this.documentId=documentId;
   });
  }

 Future<void> sendDataToFirebase()async{
      List<String> splitList=Roll.split(' ');
      List<String> indexList=[];
      for(int i=0;i<splitList.length;i++){
        for(int j=0;j<=splitList[i].length+i;j++){
          indexList.add(splitList[i].substring(0,j).toLowerCase());
        }
      }

    setState(() {
      cheak=false;
    });
   try{
     await FirebaseFirestore.instance.collection(currentUid+item).doc(documentId.toString()).set({
       'Semester':item,
       'Technology':technology,
       'Name':Name,
       'Roll':Roll,
       'Registation':Regestation,
       'Class Group':ClassGroup,
       'Phone Number':PhoneNumber,
       'Blood Group':BloodGroup,
       'Religion':Religion,
       'Nationality':Nationality,
       'Email':Email,
       'Gender':selectionGender,
       'FatherName':FatherName,
       'FatherPhoneNumber':FatherPhoneNumber,
       'MotherName':MotherName,
       'MotherPhoneNumber':MotherPhoneNumber,
       'FirstSem':firstSemester,
       'SecondSem':secondSemester,
       'ThirdSem':thirdSemester,
       'FourthSem':fourthSemester,
       'FifthSem':fifthSemester,
       'SixthSem':sixthSemester,
       'SevenSem':seventhSemester,
       'EightSem':eightSemester,
       'UniqueId':documentId,
       'IndexList':indexList,
     }).then((value){
       setState(() {
         cheak=true;
       });
       Fluttertoast.showToast(msg: 'Student Information Stored');
     }).catchError((error){
       setState(() {
         cheak=true;
       });
       Fluttertoast.showToast(msg: 'Unable to save data');
     });
   }catch(error){
     setState(() {
       cheak=true;
     });
     Fluttertoast.showToast(msg: 'Unable to save data');
   }

  }

  radioButtonChange(var  value){
      setState(() {
      selectionGrooupValue=value;
        switch(value){
          case 'Male':
            selectionGender=value;
            break;
          case 'Female':
            selectionGender=value;
            break;
          case 'Others':
            selectionGender=value;
            break;
          default:
            break;
        }
      });

  }

  void getCurrentUid()async{
   FirebaseAuth firebaseAuth=FirebaseAuth.instance;
   User user=await firebaseAuth.currentUser;
   setState(() {
     currentUid=user.uid;
   });
  }

  @override
  void initState() {
   setState(() {
     selectionGender='Male';
     selectionGrooupValue=gender;
     item='Select One';
   });
    getCurrentUid();

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final data= Provider.of<StudentInformation>(context);

    return Scaffold(
      body:  Stack(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.blue,
                      height: height * 0.4,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Container(
                    child: Form(
                      key:_formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                        isUpdate?Container(): Card(
                            elevation: 10,
                            child: Container(
                              width: width * 0.9,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Divider(
                                          height: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Select Semester',
                                              ))),
                                      Expanded(
                                        flex: 1,
                                        child: Divider(
                                          height: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    // padding: EdgeInsets.only(left: 13,right: 13),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: width * 0.8,
                                    child: DropdownButton(
                                      isExpanded: true,
                                      iconSize: 30,
                                      hint: Text(item),
                                      items: [
                                        DropdownMenuItem(
                                          value: "1st",
                                          child: Text("1st Semester"),
                                        ),
                                        DropdownMenuItem(
                                          value: "2nd",
                                          child: Text("2nd Semester"),
                                        ),
                                        DropdownMenuItem(
                                          value: "3rd",
                                          child: Text("3rd Semester"),
                                        ),
                                        DropdownMenuItem(
                                          value: "4th",
                                          child: Text("4th Semester"),
                                        ),
                                        DropdownMenuItem(
                                          value: "5th",
                                          child: Text("5th Semester"),
                                        ),
                                        DropdownMenuItem(
                                          value: "6th",
                                          child: Text("6th Semester"),
                                        ),
                                        DropdownMenuItem(
                                          value: "7th",
                                          child: Text("7th Semester"),
                                        ),
                                        DropdownMenuItem(
                                          value: "8th",
                                          child: Text("8th Semester"),
                                        )
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          item = value;
                                        });
                                      },
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),




                          SizedBox(
                            height:5,
                          ),
                          Card(
                            elevation: 10,
                            child: Container(
                              width: width * 0.9,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Divider(
                                          height:1,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Technology',
                                              ))),
                                      Expanded(
                                        flex: 1,
                                        child: Divider(
                                          height: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    width: width * 0.8,
                                    child: Row(
                                      children: <Widget>[
                                        Radio(
                                          value:'value',
                                          groupValue:'value',
                                          activeColor: Colors.blue,
                                          onChanged:null
                                        ),
                                        Text('Computer')

                                      ],
                                    )
                                  )



                                ],
                              ),
                            ),
                          ),






                          SizedBox(
                            height: 5,
                          ),
                          Card(
                            elevation:4,
                            child: Container(
                              width: width * 0.9,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Divider(
                                          height: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Student Informatiion',
                                              ))),
                                      Expanded(
                                        flex: 1,
                                        child: Divider(
                                          height: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: width * 0.9,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(13),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.Name:null,
                                           // controller: nameClt,
                                            decoration: InputDecoration(
                                                hintText: "Name",
                                                filled: true,
                                                fillColor: Colors.grey[200]),
                                            validator: (value){
                                              if(value.trim().isEmpty){
                                                return 'Empty Feild';
                                              }
                                            },
                                            onSaved: (value){
                                              Name=value;
                                            },

                                          ),

                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.Roll:null,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: "Roll",
                                                filled: true,
                                                fillColor: Colors.grey[200]),
                                            validator: (value){
                                              if(value.trim().isEmpty){
                                                return 'Empty Feild';
                                              }
                                            },
                                            onSaved: (value){
                                              Roll=value.toString();
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.Registation:null,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: "Regestation",
                                                filled: true,
                                                fillColor: Colors.grey[200]),
                                            validator: (value){
                                              if(value.trim().isEmpty){
                                                return 'Empty Feild';
                                              }
                                            },
                                            onSaved: (value){
                                              Regestation=value;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.ClassGroup:null,
                                            decoration: InputDecoration(
                                                hintText: "Class Group",
                                                filled: true,
                                                fillColor: Colors.grey[200]),
                                            validator: (value){
                                              if(value.trim().isEmpty){
                                                return 'Empty Feild';
                                              }
                                            },
                                            onSaved: (value){
                                              ClassGroup=value;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.PhoneNumber:null,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: "Phone Number",
                                                filled: true,
                                                fillColor: Colors.grey[200]),
                                            validator: (value){
                                              if(value.trim().isEmpty){
                                                return 'Empty Feild';
                                              }
                                            },
                                            onSaved: (value){
                                              PhoneNumber=value;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.BloodGroup:null,
                                            decoration: InputDecoration(
                                                hintText: "Blood Group (Optional)",
                                                filled: true,
                                                fillColor: Colors.grey[200]),

                                            onSaved: (value){
                                              BloodGroup=value;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.Religion:null,
                                            decoration: InputDecoration(
                                                hintText: "Religion",
                                                filled: true,
                                                fillColor: Colors.grey[200]),
                                            validator: (value){
                                              if(value.trim().isEmpty){
                                                return 'Empty Feild';
                                              }
                                            },
                                            onSaved: (value){
                                              Religion=value;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.Nationality:null,
                                            decoration: InputDecoration(
                                                hintText: "Nationality",
                                                filled: true,
                                                fillColor: Colors.grey[200]),
                                            validator: (value){
                                              if(value.trim().isEmpty){
                                                return 'Empty Feild';
                                              }
                                            },
                                            onSaved: (value){
                                              Nationality=value;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.Email:null,
                                            decoration: InputDecoration(
                                                hintText: "Email (Optional)",
                                                filled: true,
                                                fillColor: Colors.grey[200]),

                                            onSaved: (value){
                                              Email=value;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(left: 5),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Gender',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                            )),

                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Column(

                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Radio(
                                                    value:'Male',//one
                                                    groupValue:selectionGrooupValue ,
                                                    onChanged: (value){
                                                      radioButtonChange(value);
                                                    },
                                                  ),
                                                  Text('Male')
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Radio(
                                                    value:'Female',//one
                                                    groupValue:selectionGrooupValue ,
                                                    onChanged: (value){
                                                      radioButtonChange(value);
                                                    },
                                                  ),
                                                  Text('Female')
                                                ],
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Radio(
                                                    value:'Others',//one
                                                    groupValue:selectionGrooupValue ,
                                                    onChanged: (value){
                                                      radioButtonChange(value);
                                                    },
                                                  ),
                                                  Text('Others')
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                         SizedBox(height:5),

                          Card(
                            elevation:4,
                            child: Container(
                              width: width * 0.9,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Divider(
                                          height: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Gurdian Informatiion',
                                              ))),
                                      Expanded(
                                        flex: 1,
                                        child: Divider(
                                          height: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: width * 0.9,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(13),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.FathersName:null,
                                            decoration: InputDecoration(
                                                hintText: "Father's Name",
                                                filled: true,
                                                fillColor: Colors.grey[200]),
                                            validator: (value){
                                              if(value.trim().isEmpty){
                                                return 'Empty Feild';
                                              }
                                            },
                                            onSaved: (value){
                                              FatherName=value;
                                            },

                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.FathersNumber:null,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: "Phone Number (Optional)",
                                                filled: true,
                                                fillColor: Colors.grey[200]),

                                            onSaved: (value){
                                              FatherPhoneNumber=value;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.MothersName:null,
                                            decoration: InputDecoration(
                                                hintText: "Mother's Name",
                                                filled: true,
                                                fillColor: Colors.grey[200]),
                                            validator: (value){
                                              if(value.trim().isEmpty){
                                                return 'Empty Feild';
                                              }
                                            },
                                            onSaved: (value){
                                              MotherName=value;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: width * 0.8,
                                          child: TextFormField(
                                            initialValue:isUpdate?data.Mothersnumber:null,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: "Phone Number (Optional)",
                                                filled: true,
                                                fillColor: Colors.grey[200]),

                                            onSaved: (value){
                                              MotherPhoneNumber=value;
                                            },
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height:5),
                          Card(
                            elevation:4,
                            child: Container(
                              width: width * 0.9,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Divider(
                                          height: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Result Informatiion',
                                              ))),
                                      Expanded(
                                        flex: 1,
                                        child: Divider(
                                          height: 2,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:10
                                  ),
                                  Container(
                                    width: width * 0.9,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(13),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: width*0.8,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                  child: Container(
                                                    padding: EdgeInsets.only(right: 5),
                                                    child: TextFormField(
                                                      initialValue:isUpdate?data.firstSem:null,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.grey[200],
                                                        hintText: '1st Semester'
                                                      ),
                                                      onSaved: (value){
                                                        firstSemester=value;
                                                      },
                                                    )
                                                    ,)
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding: EdgeInsets.only(left: 5),
                                                    child: TextFormField(
                                                      initialValue:isUpdate?data.secondSem:null,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.grey[200],
                                                          hintText: '2st Semester'
                                                      ),
                                                      onSaved: (value){
                                                        secondSemester=value;
                                                      },
                                                    )
                                                    ,)
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8.0,),
                                        Container(
                                          width: width*0.8,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding: EdgeInsets.only(right: 5),
                                                    child: TextFormField(
                                                      initialValue:isUpdate?data.thirdSem:null,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.grey[200],
                                                          hintText: '3rd Semester'
                                                      ),
                                                      onSaved: (value){
                                                        thirdSemester=value;
                                                      },
                                                    )
                                                    ,)
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding: EdgeInsets.only(left: 5),
                                                    child: TextFormField(
                                                      initialValue:isUpdate?data.fourthSem:null,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.grey[200],
                                                          hintText: '4th Semester'
                                                      ),
                                                      onSaved: (value){
                                                        fourthSemester=value;
                                                      },
                                                    )
                                                    ,)
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8.0,),
                                        Container(
                                          width: width*0.8,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding: EdgeInsets.only(right: 5),
                                                    child: TextFormField(
                                                      initialValue:isUpdate?data.fifthSem:null,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.grey[200],
                                                          hintText: '5th Semester'
                                                      ),
                                                      onSaved: (value){
                                                        fifthSemester=value;
                                                      },
                                                    )
                                                    ,)
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding: EdgeInsets.only(left: 5),
                                                    child: TextFormField(
                                                      initialValue:isUpdate?data.sixthSem:null,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.grey[200],
                                                          hintText: '6th Semester'
                                                      ),
                                                      onSaved: (value){
                                                        sixthSemester=value;
                                                      },
                                                    )
                                                    ,)
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8.0,),
                                        Container(
                                          width: width*0.8,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding: EdgeInsets.only(right: 5),
                                                    child: TextFormField(
                                                      initialValue:isUpdate?data.seventhSem:null,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.grey[200],
                                                          hintText: '7th Semester'
                                                      ),
                                                      onSaved: (value){
                                                        seventhSemester=value;
                                                      },
                                                    )

                                                    ,)
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding: EdgeInsets.only(left: 5),
                                                    child: TextFormField(
                                                      initialValue:isUpdate?data.eighthSem:null,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.grey[200],
                                                          hintText: '8th Semester'
                                                      ),
                                                      onSaved: (value){
                                                        eightSemester=value;
                                                      },
                                                    )
                                                    ,)
                                              ),
                                            ],
                                          ),
                                        )




                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Card(
                            elevation: 5,
                            child: Container(
                              width: width*0.9,
                              child: Row(
                                children: <Widget>[
                                 /* Expanded(
                                    flex: 1,
                                    child: Container(
                                      //  color: Colors.blue,
                                      alignment: Alignment.center,
                                          child: FlatButton(
                                            child: Icon(CupertinoIcons.refresh_bold),
                                            onPressed: (){
                                              nameClt.clear();
                                            },
                                          ),


                                    ),
                                  ),
*/
                                  Expanded(
                                   // flex: 4,
                                    child: Container(
                                          // padding: EdgeInsets.only(right: 60),
                                            child: FlatButton(
                                              child:cheak?Text(isUpdate?'UPDATE':'SAVE',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),):CircularProgressIndicator(),
                                               onPressed: ()async{
                                                print(data.uniqeId);
                                                if(isUpdate){

                                                }
                                                else{
                                                  if(item=='Select One'){
                                                    Fluttertoast.showToast(msg: 'Please select semester');
                                                    return;
                                                  }
                                                }

                                                 if(_formkey.currentState.validate()){
                                                  _formkey.currentState.save();
                                                  createRandomNumber();
                                                  if(isUpdate){
                                                    setState(() {
                                                      cheak=false;
                                                    });

                                                    CollectionReference users=FirebaseFirestore.instance.collection(currentUid.toString()+data.Semester);
                                                    await users.doc(data.uniqeId).update({
                                                      //'Semester':item,
                                                      'Technology':technology,
                                                      'Name':Name,
                                                      'Roll':Roll,
                                                      'Registation':Regestation,
                                                      'Class Group':ClassGroup,
                                                      'Phone Number':PhoneNumber,
                                                      'Blood Group':BloodGroup,
                                                      'Religion':Religion,
                                                      'Nationality':Nationality,
                                                      'Email':Email,
                                                      'Gender':selectionGender,
                                                      'FatherName':FatherName,
                                                      'FatherPhoneNumber':FatherPhoneNumber,
                                                      'MotherName':MotherName,
                                                      'MotherPhoneNumber':MotherPhoneNumber,
                                                      'FirstSem':firstSemester,
                                                      'SecondSem':secondSemester,
                                                      'ThirdSem':thirdSemester,
                                                      'FourthSem':fourthSemester,
                                                      'FifthSem':fifthSemester,
                                                      'SixthSem':sixthSemester,
                                                      'SevenSem':seventhSemester,
                                                      'EightSem':eightSemester,
                                                      'UniqueId':data.uniqeId,


                                                    }).then((value){
                                                      setState(() {
                                                        cheak=true;
                                                      });
                                                      Fluttertoast.showToast(msg: 'Student Data Updated');
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                                    }).catchError((error){
                                                      Fluttertoast.showToast(msg: 'Student Data Update fail');
                                                    });
                                                    return;
                                                  }
                                                  else{
                                                    sendDataToFirebase();
                                                  }

                                                }
                                               },
                                            ),

                                    ),
                                  ),
                                 /* Expanded(
                                    flex: 1,
                                    child:isUpdate?Container(
                                      child: FlatButton(
                                        child: Icon(Icons.home),
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                        },
                                      ),
                                    ): Container(
                                      alignment: Alignment.center,
                                      child: FlatButton(

                                      ),

                                    ),
                                  ),*/

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,)


                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
    );
  }
}
