import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management/HomePage.dart';
import 'package:student_management/LoginPage.dart';
import 'package:student_management/StudentFormInformation.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  var email= sharedPreferences.getString('mail');
  runApp(MultiProvider(
      providers:[
        ChangeNotifierProvider.value(value:StudentInformation() )
      ],
      child: MaterialApp(
        home:email==null ?LoginPage():HomePage() ,
      )
  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers:[
       ChangeNotifierProvider.value(value:StudentInformation() )
      ],
   child: MaterialApp(
        home:HomePage() ,
      )
    );
  }
}
