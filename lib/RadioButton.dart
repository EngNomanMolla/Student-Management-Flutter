import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RadioButton extends StatefulWidget {
  @override
  _RadioButtonState createState() => _RadioButtonState();
}


class _RadioButtonState extends State<RadioButton> {
  String _radioValue='one';
  String choice;
  @override
  void initState() {
  _radioValue;

  super.initState();
  }

  void radioButtonChange(String value){

    setState(() {
      _radioValue=value;
      switch(value){
        case 'two':
          choice=value;
          break;
        case 'two':
          choice=value;
          break;
        default:
          choice=null;
          break;
      }
      debugPrint(choice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value:'one',//one
                  groupValue:_radioValue ,
                  onChanged: (value){
                    radioButtonChange(value);
                  },
                ),
                Text('Male')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value:'two' ,
                  groupValue:_radioValue ,
                  onChanged: (value){
                    radioButtonChange(value);
                  },
                ),
                Text('Femail')
              ],
            )
          ],
        ),
      ),
    );
  }
}
