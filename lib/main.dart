import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telemed/animations/fadeanimate.dart';
import 'package:telemed/doctor/DoctorScreens/doctorRegistration.dart';
import 'package:telemed/patient/patientLogin.dart';
import 'otherWidgetsAndScreen/category.dart';
import 'package:telemed/doctor/DoctorScreens/doctorLogin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.black,
        primaryColor: Colors.black,

      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      routes: {
        '/PatientLogin' : (context) => PatientLogin(),
        '/DoctorLogin' : (context) => DoctorLogin(),
        '/DoctorRegister' : (context)=> DoctorRegistration(),
//        '/DoctorHome' : (context)=> DoctorHome(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
  with TickerProviderStateMixin{
  AnimationController _scaleController;
  AnimationController _scaleController2;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState(){
    super.initState();
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if(status == AnimationStatus.completed){
              _widthController.forward();
            }
    });
    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _widthAnimation =
    Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _positionController.forward();
        }
      });
    _positionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _positionAnimation =
    Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            hideIcon = true;
          });
          _scaleController2.forward();
        }
      });
    _scaleController2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _scale2Animation = Tween<double>(begin: 1.0, end: 32.0).animate(
        _scaleController2)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // TODO: add category class route

          Navigator.push(context,
              PageTransition(type: PageTransitionType.fade, child: CategoryData()));
        }
      });
  }
          @override
          Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black, // navigation bar color
          statusBarColor: Colors.black.withOpacity(0.1)));
      final double width = MediaQuery.of(context).size.width;
      final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: width,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: height * 0.05,
              left: width - 240,
              child: FadeAnimation(
                1,
                Container(
                  width: width,
                  child: Image(image: AssetImage('assets/hospital.png')),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                height: height * 0.55,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Text(
                          'TeleMed',
                          style: TextStyle(color: Colors.black, fontSize: height * 0.06),
                        )),
                    FadeAnimation(
                        1,
                        Text(
                          "Always With You",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5), fontSize: height * 0.017),
                        )),
                    SizedBox(
                      height: height * 0.26,
                    ),
                    Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.6,
                            AnimatedBuilder(
                              animation: _scaleController,
                              builder: (context, child) => Transform.scale(
                                scale: _scaleAnimation.value,
                                child: Center(
                                  child: AnimatedBuilder(
                                    animation: _widthController,
                                    builder: (context, child) => Container(
                                      width: _widthAnimation.value,
                                      height: 80,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          _scaleController.forward();
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            AnimatedBuilder(
                                              animation: _positionController,
                                              builder: (context, child) => Positioned(
                                                left: _positionAnimation.value,
                                                child: AnimatedBuilder(
                                                  animation: _scaleController2,
                                                  builder: (context, child) =>
                                                      Transform.scale(
                                                          scale: _scale2Animation
                                                              .value,
                                                          child: Container(
                                                              width: 60,
                                                              height: 60,
                                                              decoration:
                                                              BoxDecoration(
                                                                  color:
                                                                  Colors
                                                                      .black,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: hideIcon == false
                                                                  ? Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color: Colors
                                                                    .white,
                                                              )
                                                                  : Container())),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: height * 0.02,),
                        FadeAnimation(
                            1,
                            Text(
                              'Proceed!', textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontSize: 20),
                            )),
                      ],
                    ),
                    SizedBox(height: height * 0.019,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _fcm.configure(
        onMessage: (Map<String,dynamic> message)async{
          print('onMessage : $message');
        },
        onLaunch: (Map<String,dynamic> message)async{
          print('onMessage : $message');
        },
        onResume: (Map<String,dynamic> message)async{
          print('onMessage : $message');
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
