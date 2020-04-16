
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorInfoDatabase{
  String doctorName='';
  String email='';

  String getName(String mail)
  {
   this.email = mail;
    StreamBuilder(
      stream: Firestore.instance.collection('DoctorName').where('email', isEqualTo: this.email).snapshots(),
      builder:(context, snapshot){
        if(!snapshot.hasData)
          return Text('Connecting');
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context , index){
            DocumentSnapshot ds = snapshot.data.documents[0];
            return doctorName=ds['name'];
          },
        );
      } ,
    );
    return doctorName;
  }
  }
  

