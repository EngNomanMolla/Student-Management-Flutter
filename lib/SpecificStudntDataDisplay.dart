import 'dart:wasm';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/BarChartsDataModel.dart';
import 'package:student_management/StudentFormInformation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:url_launcher/url_launcher.dart';

class specificStudentDataDisplay extends StatefulWidget {
  var firstSem,secondSem,thirdSem,fourthSem,fifthSem,sixthSem,sevenSem,eightSem;
  specificStudentDataDisplay(this.firstSem,this.secondSem,this.thirdSem,this.fourthSem,this.fifthSem,
      this.sixthSem,this.sevenSem,this.eightSem
      );
  @override
  _specificStudentDataDisplayState createState() => _specificStudentDataDisplayState(
   firstSem,secondSem,thirdSem,fourthSem,fifthSem,sixthSem,sevenSem,eightSem
  );
}

class _specificStudentDataDisplayState extends State<specificStudentDataDisplay> {
  var firstSem,secondSem,thirdSem,fourthSem,fifthSem,sixthSem,sevenSem,eightSem;
  _specificStudentDataDisplayState(this.firstSem,this.secondSem,this.thirdSem,this.fourthSem,this.fifthSem,
      this.sixthSem,this.sevenSem,this.eightSem);

  var cheak=true;
  var totalResult=0.0;
  var cheakBoxValue=false;

  Widget design(var heading, var value) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                child: Text(
                  heading,
                  style: TextStyle(fontSize: 18),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 18),
                ),
              )),
        ],
      ),
    );
  }
  static var chartsDisplay;
  @override
  void initState() {
    var data=[
      BarChartsDataModel('1st', firstSem==''?0.0:double.parse(firstSem.toString())),
      BarChartsDataModel('2nd', secondSem==''?0.0:double.parse(secondSem.toString())),
      BarChartsDataModel('3rd',  thirdSem==''?0.0:double.parse(thirdSem.toString())),
      BarChartsDataModel('4th',  fourthSem==''?0.0:double.parse(fourthSem.toString())),
      BarChartsDataModel('5th',  fifthSem==''?0.0:double.parse(fifthSem.toString()) ),
      BarChartsDataModel('6th', sixthSem==''?0.0:double.parse(sixthSem.toString()) ),
      BarChartsDataModel('7th',  sevenSem==''?0.0:double.parse( sevenSem.toString())),
      BarChartsDataModel('8th', eightSem==''?0.0:double.parse(eightSem.toString())),
    ];
    var series=[charts.Series(
        domainFn: (BarChartsDataModel b,_)=>b.lebel,
        measureFn: (BarChartsDataModel b,_)=>b.value,
        id: 'BarChartsDataModel',
        data: data

    )];
    chartsDisplay=charts.BarChart(
      series,
      animationDuration: Duration(microseconds: 2000),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<StudentInformation>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.lightBlueAccent,
                        child: Text(
                          'Student Information',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      design('Name:', data.Name),
                      design('Roll:', data.Roll),
                      design('Registation:', data.Registation),
                      design('Semester:', data.Semester),
                      design('Technology:', data.Technology),
                      design('Class Group:', data.ClassGroup),
                      design('Religion:', data.Religion),
                      design('Nationality:', data.Nationality),
                      design('Email:', data.Email),
                      design('Gender:', data.Gender),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    data.Number,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    child: CircleAvatar(
                                      radius: 13,
                                  child: IconButton(
                                    icon: Icon(Icons.call,size:13,color: Colors.white,),
                                    onPressed: (){
                                      launch('tel:+${data.Number}');
                                    },
                                  ),
                                ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    child: CircleAvatar(
                                      radius: 13,
                                      child: IconButton(
                                        icon: Icon(Icons.message,size:13,color: Colors.white,),
                                        onPressed: (){
                                          launch('sms:+${data.Number}');
                                        },
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(height:20,)
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.lightBlueAccent,
                        child: Text(
                          'Gurdian Information',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      design("Father's Name:", data.FathersName),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    data.FathersNumber==""?"017XXXXXXXX":data.FathersNumber,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    child: CircleAvatar(
                                      radius: 13,
                                      child: IconButton(
                                        icon: Icon(Icons.call,size:13,color: Colors.white,),
                                        onPressed: (){
                                          if(data.FathersNumber==""){

                                          }
                                          else{
                                            launch('tel:+${data.FathersNumber}');
                                          }
                                        },
                                      ),
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    child: CircleAvatar(
                                      radius: 13,
                                      child: IconButton(
                                        icon: Icon(Icons.message,size:13,color: Colors.white,),
                                        onPressed: (){
                                          if(data.FathersNumber==""){

                                          }
                                          else{
                                            launch('sms:${data.FathersNumber}');
                                          }
                                        },
                                      ),

                                    ))),
                          ],
                        ),
                      ),
                      design("Mother's Name:", data.MothersName),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    data.Mothersnumber==""?"017XXXXXXXX":data.Mothersnumber,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    child: CircleAvatar(
                                      radius: 13,
                                      child: IconButton(
                                        icon: Icon(Icons.call,size:13,color: Colors.white,),
                                        onPressed: (){
                                          if(data.Mothersnumber==""){

                                          }
                                          else{
                                            launch('tel:+${data.Mothersnumber}');
                                          }
                                        },
                                      ),
                                    ))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    child: CircleAvatar(
                                      radius: 13,
                                      child: IconButton(
                                        icon: Icon(Icons.message,size:13,color: Colors.white,),
                                        onPressed: (){
                                          if(data.Mothersnumber==""){

                                          }
                                          else{
                                            launch('sms:${data.Mothersnumber}');
                                          }
                                        },
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(height:20,)
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.lightBlueAccent,
                        child: Text(
                          'Result Information',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child: Column(
                                children: <Widget>[
                                  Text('1st Semester',style: TextStyle(fontSize: 15),),
                                  Text(data.firstSem,style: TextStyle(fontSize: 15),),
                                ],
                              ),
                            ),
                            Expanded(
                              flex:1,
                              child: Column(
                                children: <Widget>[
                                  Text('2nd Semester',style: TextStyle(fontSize: 15),),
                                  Text(data.secondSem,style: TextStyle(fontSize: 15),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1,color: Colors.lightBlue,endIndent: 10.0,indent: 10.0,),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child: Column(
                                children: <Widget>[
                                  Text('3rd Semester',style: TextStyle(fontSize: 15),),
                                  Text(data.thirdSem,style: TextStyle(fontSize: 15),),
                                ],
                              ),
                            ),
                            Expanded(
                              flex:1,
                              child: Column(
                                children: <Widget>[
                                  Text('4th Semester',style: TextStyle(fontSize: 15),),
                                  Text(data.fourthSem,style: TextStyle(fontSize: 15),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1,color: Colors.lightBlue,endIndent: 10.0,indent: 10.0,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child: Column(
                                children: <Widget>[
                                  Text('5th Semester',style: TextStyle(fontSize: 15),),
                                  Text(data.fifthSem,style: TextStyle(fontSize: 15),),
                                ],
                              ),
                            ),
                            Expanded(
                              flex:1,
                              child: Column(
                                children: <Widget>[
                                  Text('6th Semester',style: TextStyle(fontSize: 15),),
                                  Text(data.sixthSem,style: TextStyle(fontSize: 15),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1,color: Colors.lightBlue,endIndent: 10.0,indent: 10.0,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child: Column(
                                children: <Widget>[
                                  Text('7th Semester',style: TextStyle(fontSize: 15),),
                                  Text(data.seventhSem,style: TextStyle(fontSize: 15),),
                                ],
                              ),
                            ),
                            Expanded(
                              flex:1,
                              child: Column(
                                children: <Widget>[
                                  Text('8th Semester',style: TextStyle(fontSize: 15),),
                                  Text(data.eighthSem,style: TextStyle(fontSize: 15),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height:20,)
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),  color: Colors.lightBlueAccent,),

                child: FlatButton(
                  child: Text(cheak?'Count CGPA':totalResult.toStringAsFixed(2),style: TextStyle(color: Colors.white,fontSize:15,fontWeight:FontWeight.bold),),
                  onPressed: (){
                    var totalCGPA=0.0;
                    if(data.firstSem==''){
                      totalCGPA=totalCGPA+0.0;
                    }
                    else{
                     totalCGPA=totalCGPA+double.parse(data.firstSem)*0.05;                 // firstSem*0.05;
                    }
                    if(data.secondSem==''){
                      totalCGPA=totalCGPA+0.0;
                    }
                    else{
                      totalCGPA=totalCGPA+double.parse(data.secondSem)*0.05;
                    }
                    if(data.thirdSem==''){
                      totalCGPA=totalCGPA+0.0;
                    }
                    else{
                      totalCGPA=totalCGPA+double.parse(data.thirdSem)*0.05;
                    }
                    if(data.fourthSem==''){
                      totalCGPA=totalCGPA+0.0;
                    }
                    else{
                      totalCGPA=totalCGPA+double.parse(data.fourthSem)*0.1;
                    }
                    if(data.fifthSem==''){
                      totalCGPA=totalCGPA+0.0;
                    }
                    else{
                      totalCGPA=totalCGPA+double.parse(data.fifthSem)*0.15;
                    }
                    if(data.sixthSem==''){
                      totalCGPA=totalCGPA+0.0;
                    }
                    else{
                      totalCGPA=totalCGPA+double.parse(data.sixthSem)*0.2;
                    }
                    if(data.seventhSem==''){
                      totalCGPA=totalCGPA+0.0;
                    }
                    else{
                      totalCGPA=totalCGPA+double.parse(data.seventhSem)*0.25;
                    }
                    if(data.eighthSem==''){
                      totalCGPA=totalCGPA+0.0;
                    }
                    else{
                      totalCGPA=totalCGPA+double.parse(data.eighthSem)*0.15;
                    }
                    setState(() {
                      totalResult=totalCGPA;
                      cheak=false;

                    });
                  },
                ),
              ),

              Row(
                children: <Widget>[
                  Checkbox(
                    value:cheakBoxValue ,
                    onChanged: (value){
                      setState(() {
                        cheakBoxValue=value;
                      });
                    },

                  ),
                  Text('Show result chart'),

                ],
              ),
              Visibility(
                visible:cheakBoxValue ,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 400,
                    width:MediaQuery.of(context).size.width,
                    child: chartsDisplay,
                  ),
                ),
              ),
              SizedBox(height:20,),
            ],
          ),
        ),
      ),
    );
  }
}
