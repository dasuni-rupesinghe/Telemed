import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class TreatmentLog extends StatefulWidget {
  TreatmentLog({this.name});
  final String name;

  @override
  TreatmentLogState createState() => TreatmentLogState(name: this.name);
}

class TreatmentLogState extends State<TreatmentLog> {
  TreatmentLogState({this.name});
  String name = '';
  Future _data;

  Future getPosts() async
  {
    var firestore = Firestore.instance;
    QuerySnapshot qs = await firestore.collection('TreatmentLog').where('name', isEqualTo: this.name).getDocuments();
    return qs.documents;
  }

  @override
  void initState() {

    super.initState();
    _data= getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Treatment Log'),backgroundColor: Colors.redAccent,),
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
                      String n = snapshot.data[index].data['Treatment'];
                      return ListTile(
                        title: Text(n),
                      );
                    }
                );
              }
            }),
      ),
    );
  }
}
