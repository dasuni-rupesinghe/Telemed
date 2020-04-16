import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telemed/doctor/DoctorScreens/doctorPatientView.dart';
import 'newNote.dart';


class Notes extends StatefulWidget {
  Notes({this.room});
  final String room;


  @override
  NotesState createState() => NotesState(room: this.room, );
}

class NotesState extends State<Notes> {
  NotesState({this.room});
  String room;
  Future _data;

  Future getPosts() async
  {
    var firestore = Firestore.instance;
    QuerySnapshot qs = await firestore.collection('Note').where('room', isEqualTo: this.room).getDocuments();
    return qs.documents;
  }

  navigateToDetail(DocumentSnapshot snap){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsPatient(detils: snap,)));
  }

  @override
  void initState() {

    super.initState();
    _data= getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes'),backgroundColor: Colors.redAccent,),
      body:Container(
        child: FutureBuilder(
            future: _data,
            builder: (_,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return Center(child: SpinKitFoldingCube(
                  color: Colors.white,
                  size: 50.0,
                  duration:Duration(microseconds: 1200),
                ),
                );
              }
              else
              {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_,index)
                    {
                      return ListTile(
                        title: Text(snapshot.data[index].data['note']),
                        onTap: (){

                        },
                      );
                    }
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=> NewNote(room: this.room,),
            fullscreenDialog: true,
          ),
          );
        },
      ),
    );
  }
}
