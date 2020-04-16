import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:telemed/doctor/DoctorScreens/AppointmentList.dart';
import 'package:telemed/doctor/DoctorScreens/doctorHome.dart';
import 'package:telemed/doctor/DoctorScreens/patientLog.dart';



class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification Log'),backgroundColor: Colors.redAccent,),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Hivindu Amaradeva'),
              accountEmail: Text('h.amaradeva@gmail.com'),
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
                return Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> DoctorHome()));
              },
            ),
            ListTile(
              title: Text('Patient Log'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                return Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> PatientLog()));
              },
            ),
            ListTile(
              title: Text('Appointment List'),
              trailing:  Icon(Icons.arrow_forward_ios),
              onTap: (){
                return Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> AppointmentLog()));
              },
            ),
            ListTile(
              title: Text('Notifications'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                return Navigator.of(context).pop();
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
      body: Center(
        child: Text('Notification Log'),
      ),
    );
  }
}
