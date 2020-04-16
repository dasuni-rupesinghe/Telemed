import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Task{

  String _name;
  String _hospital;
  String _time;

  Task(this._name,this._time,this._hospital);

  Task.map(dynamic obj){
    this._hospital= obj['hospital'];
    this._name= obj['name'];
    this._time= obj['time'];
  }

  String get name => _name;
  String get hospital => _hospital;
  String get time => _time;

  Map<String,dynamic> tomap(){
    var map = new   Map<String,dynamic>();
    map['name']=_name;
    map['hospital']=_hospital;
    map['time']=_time;
  }

  Task.fromMap(Map<String,dynamic> map){
    this._time= map['time'];
    this._name= map['name'];
    this._hospital= map['hospital'];
  }

}