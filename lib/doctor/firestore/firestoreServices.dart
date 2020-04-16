import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'taskData.dart';



class FirestoreServices{

  String name;
  String time;
  String hospital;

  final   CollectionReference myCollection = Firestore.instance.collection('DoctorSchedule');

  Future<Task> craeteTODOtask({name,time,hospital}) async{

    final TransactionHandler createTransaction=(Transaction tx) async{
      final DocumentSnapshot ds =await tx.get(myCollection.document());


      final Task task = Task(name,time,hospital);
      final Map<String,dynamic>data = task.tomap();
      await tx.set(ds.reference, data);
      return data;
    };
    return Firestore.instance.runTransaction(createTransaction).then((mapData){
      return Task.fromMap(mapData);
    }).catchError((onError){

      print('error: $onError');
      return null;
    });
  }

  Stream<QuerySnapshot> getTaskList({int offset, int limit}){
    Stream<QuerySnapshot> ss = myCollection.where('name',isEqualTo: this.name).snapshots();
    if(offset != null)
      {
        ss= ss.skip(offset);
      }
    if(limit != null)
      {
        ss= ss.take(limit);
        return ss;
      }
  }
}