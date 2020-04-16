import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telemed/doctor/firestore/firestoreServices.dart';

class NewAppointment extends StatefulWidget {

  final String name;
  NewAppointment({this.name});
  @override
  NewAppointmentState createState() => NewAppointmentState(name: this.name);
}

class NewAppointmentState extends State<NewAppointment> {
  NewAppointmentState({this.name});
  String name='';
  String hospital='';
  String time='';



  createData()
  {
      DocumentReference ds =Firestore.instance.collection('DoctorSchedule').document();
      Map<String,dynamic> tsks={
        'hospital':hospital,
        'name':name,
        'time':time
      };
      ds.setData(tsks).whenComplete(() => print('task created'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Schedule'),backgroundColor:  Colors.redAccent,),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-200.0,
            child: ListView(
              children: <Widget>[
                Padding(
                    padding:EdgeInsets.only(left: 16.0,right: 16.0),
                    child:TextField(
                      onChanged: (var e){
                        this.hospital = e;
                      },
                      decoration: InputDecoration(labelText: 'Hospital'),
                    ),
                ),
                Padding(
                  padding:EdgeInsets.only(left: 16.0,right: 16.0),
                  child:TextField(
                    onChanged: (var e){
                      this.time = e;
                    },
                    decoration: InputDecoration(labelText: 'Time'),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.redAccent[700],
                elevation: 7.0,
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed:(){

                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.redAccent[700],
                elevation: 7.0,
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed:(){
                  createData();
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
