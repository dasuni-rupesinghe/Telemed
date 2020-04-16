import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorRegistration extends StatefulWidget  {
  @override
  _DoctorRegistrationState createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {

  final _formkey= GlobalKey<FormState>();

  String id;
  final db = Firestore.instance;


   String email='';
   String name='';
   String password = '';
   String error ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style:
                    TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Form(
                  key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val)=> val.isEmpty? 'Enter Your Email': null,
                      decoration: InputDecoration(

                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          // hintText: 'EMAIL',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      onChanged: (val){
                        setState(() {

                          email =val;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (val)=> val.length<6? 'Enter password 6+ values': null,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),

                      obscureText: true,
                      onChanged: (val){
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (val)=> val.isEmpty? 'Enter Your Name': null,
                      decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                          ),
                      ),
                      onChanged: (val){
                        setState(() {
                          name = val.trim();
                        });
                      },
                    ),
                    SizedBox(height: 50.0),
                    Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: (){
                              createData();
                              signUp();

                            },
                            child: Center(
                              child: Text(
                                'SIGNUP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();

                          },
                          child:
                          Center(
                            child: Text('Go Back',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                    ),
                    Text(error,style: TextStyle(fontSize: 20.0),)
                  ],
                ),
              )),
          // SizedBox(height: 15.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Text(
          //       'New to Spotify?',
          //       style: TextStyle(
          //         fontFamily: 'Montserrat',
          //       ),
          //     ),
          //     SizedBox(width: 5.0),
          //     InkWell(
          //       child: Text('Register',
          //           style: TextStyle(
          //               color: Colors.green,
          //               fontFamily: 'Montserrat',
          //               fontWeight: FontWeight.bold,
          //               decoration: TextDecoration.underline)),
          //     )
          //   ],
          // )
        ]));
  }


  Future<void> signUp() async{
    final form = _formkey.currentState;
    if(form.validate())
    {
      form.save();

      //TODO: login to firebase
      try{
        AuthResult use = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
        return Alert(
          context: context,
          type: AlertType.info,
          title: "Your Account Has been Created Successfully!",
          desc: "Your Email is $email and your Password is $password",
          buttons: [
            DialogButton(child: Text('OK', style: TextStyle(color: Colors.black87),),
              color: Colors.greenAccent,
              onPressed: (){Navigator.pushNamed(context, '/DoctorLogin');
              },
            ),
          ],

        ).show();

      }
      catch(e)
      {
        return Alert(
          context: context,
          type: AlertType.error,
          title: "Error!",
          desc: "$e",
          buttons: [
            DialogButton(child: Text('OK', style: TextStyle(color: Colors.black87),),
              color: Colors.greenAccent,
              onPressed: (){Navigator.pop(context);
              },
            ),
          ],

        ).show();
      }
    }
  }

  void createData() async{
    if(_formkey.currentState.validate())
      {
        _formkey.currentState.save();
        DocumentReference ref = await db.collection('DoctorName').add({'name': '$name','email': '$email'});
        setState(() {
          id=ref.documentID;
          print(ref.documentID);
        });
      }
  }

}
