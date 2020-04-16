import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telemed/doctor/DoctorScreens/noteLog.dart';
import 'package:telemed/doctor/DoctorScreens/patientTreatrments.dart';

class DetailsPatient extends StatefulWidget {
  final DocumentSnapshot detils;
  DetailsPatient({this.detils});
  @override
  _DetailsPatientState createState() => _DetailsPatientState();
}

class _DetailsPatientState extends State<DetailsPatient> {

  final DbRef = FirebaseDatabase.instance.reference();

  String heart;
  String temp;
  String pressure;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.heart=readData();
    if(this.heart== null)
      {
        heart = 'no data';
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detils.data['name']),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(

                child: Image(image: AssetImage('assets/patient.png'),)
              ),
              Expanded(
                child: Column(

                  children: <Widget>[
                    Text(
                        widget.detils.data['name'],
                      style: TextStyle(
                        fontSize: 25,

                      ),
                    ),
                    Text(
                      ''
                    ),
                    Text(
                       widget.detils.data['age'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                        widget.detils.data['Hospital'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                        widget.detils.data['roomNo'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Image(image: AssetImage('assets/heart.png'),width: 150.0,height: 150.0,)
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '$heart%',
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Image(image: AssetImage('assets/temperature-1.png'),
                  )
              ),
              Expanded(
                child: Column(

                  children: <Widget>[
                    Text(
                        widget.detils.data['name'],
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Center(
                    child: Text('BPM',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                        widget.detils.data['name'],
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 100.0,),

          GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> TreatmentLog(name:widget.detils.data['name'])));
            },
            child: Row(
              children: <Widget>[
                Text('Treatment Log'),
                SizedBox(
                  width: 20.0,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> Notes(room: widget.detils.data['roomNo'],)));
            },
            child: Row(
              children: <Widget>[
                Text(
                  'Patient Notes',
                ),
                SizedBox(
                  width: 20.0,
                ),
                Icon(
                    Icons.arrow_forward_ios
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String readData(){
    String heart;
    try {
      DbRef.child(widget.detils.data['roomNo']).once().then((DataSnapshot ds) {
        heart = ds.value['heart'].toString();
      });
    }
    catch(nullException)
    {
      heart= 'No Data';
    }
    return heart;
  }
}
