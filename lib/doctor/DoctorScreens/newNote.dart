import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telemed/doctor/firestore/firestoreServices.dart';

class NewNote extends StatefulWidget {

  final String room;
  NewNote({this.room});
  @override
  NewNoteState createState() => NewNoteState(room: this.room);
}

class NewNoteState extends State<NewNote> {
  NewNoteState({this.room});
  String room='';
  String note='';




  createData()
  {
    DocumentReference ds =Firestore.instance.collection('Note').document();
    Map<String,dynamic> tsks={
      'note':note,
      'room':room,
    };
    ds.setData(tsks).whenComplete(() => print('Note Added'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Note'),backgroundColor:  Colors.redAccent,),
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
                      this.note = e;
                    },
                    decoration: InputDecoration(labelText: 'Note'),
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
                  Navigator.pop(context);
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
