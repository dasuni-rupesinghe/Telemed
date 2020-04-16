import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:telemed/doctor/DoctorScreens/AppointmentList.dart';
import 'package:telemed/doctor/DoctorScreens/Notification.dart';
import 'package:telemed/doctor/DoctorScreens/doctorHome.dart';
import 'package:telemed/doctor/DoctorScreens/doctorPatientView.dart';



class PatientLog extends StatefulWidget {
  PatientLog({this.email,this.name});
 final String email;
  final String name;

  @override
  PatientLogState createState() => PatientLogState(mail: this.email, name: this.name);
}

class PatientLogState extends State<PatientLog> {
  PatientLogState({this.mail,this.name});
  String mail;
  String name = '';
  Future _data;

  Future getPosts() async
  {
    var firestore = Firestore.instance;
    QuerySnapshot qs = await firestore.collection('PatientLog').where('DoctorName', isEqualTo: this.name).getDocuments();
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
      appBar: AppBar(title: Text('Patient Log'),backgroundColor: Colors.redAccent,),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('$name'),
              accountEmail: Text('$mail'),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill ,
                  image: NetworkImage("https://storage.pixteller.com/designs/designs-images/2019-03-27/05/simple-background-backgrounds-passion-simple-1-5c9b95c3a34f9.png"),

                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                return Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> DoctorHome(mail: this.mail,)));
              },
            ),
            ListTile(
              title: Text('Patient Log'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                return Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Appointment List'),
              trailing:  Icon(Icons.arrow_forward_ios),
              onTap: (){
                return Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> AppointmentLog(name: this.name,email: this.mail,)));
              },
            ),
            ListTile(
              title: Text('Notifications'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                return Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> NotificationList()));
              },
            ),
            Divider(height:400.0 ,),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.redAccent[700],
              elevation: 7.0,
              child: Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed:(){
                return Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "LOG OUT",
                  desc: "Are you sure You Want To Log Out",
                  buttons: [
                    DialogButton(child: Text('Yes', style: TextStyle(color: Colors.black87),),
                      color: Colors.greenAccent,
                      onPressed: (){Navigator.pushNamed(context, '/DoctorLogin');
                      },
                    ),
                    DialogButton(child: Text('No', style: TextStyle(color: Colors.black87),),
                      color: Colors.greenAccent,
                      onPressed: (){Navigator.of(context).pop();
                      },
                    ),
                  ],

                ).show();
              } ,
            ),
          ],
        ),
      ),
      body:Container(
        color: Color(0xFFFCE4EC),
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
                      title: Text(snapshot.data[index].data['name']),
                      onTap: (){
                        navigateToDetail(snapshot.data[index]);
                      },
                    );
                  }
              );
            }
        }),
      ),
    );
  }
}
