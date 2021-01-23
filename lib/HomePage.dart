import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:student_management/CreatePage.dart';
import 'package:student_management/Home.dart';
import 'package:student_management/Profile.dart';
class HomePage extends StatefulWidget {
      @override
      _HomePageState createState() => _HomePageState();
    }

    class _HomePageState extends State<HomePage> {
  var _page=1;
  final pages=[CreatePage(false,'Male'),Home(),Profile()];
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            index: 1,
            color: Colors.white,
            buttonBackgroundColor: Colors.blue,
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index){
              setState(() {
                _page=index;
              });

            },
            items: <Widget>[
              Icon(Icons.create),
              Icon(Icons.home),
              Icon(Icons.person),

            ],
          ),

          body:pages[_page]
        );
      }
    }
