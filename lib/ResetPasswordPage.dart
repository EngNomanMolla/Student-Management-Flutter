import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var _formKey=GlobalKey<FormState>();
  var Email;
  var cheak=false;
  resetPasswordMethod(context)async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      FirebaseAuth firebaseAuth=FirebaseAuth.instance;
     await firebaseAuth.sendPasswordResetEmail(email: Email);
      SnackBar snackBar=new SnackBar(content: Text("We sent a reset link in your mail",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      );
      Scaffold.of(context).showSnackBar(snackBar);

    }

  }
  @override
  Widget build(BuildContext context) {
   // SnackBar snackBar=new SnackBar(content: Text("We sent a reset link in your mail"));
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        centerTitle: true,

      ),
      body:SingleChildScrollView(
      child: Builder(
        builder: (context){
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key:_formKey ,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText:"Enter your account email",
                      ),
                      validator: (value){
                       if(value.trim().isEmpty){
                         return "Empty Feild";
                       }
                      },
                      onSaved: (value){
                        Email=value;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    color: Colors.blue,
                    child: FlatButton(
                      child: Text("Reset Password",style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        resetPasswordMethod(context);
                      },
                    ),
                  ),

                  //cheak?Scaffold.of(context).showSnackBar(snackBar):Container(),
                ],
              ),
            ),
          );
        },
      ),
    ) ,
    );



  }
}
