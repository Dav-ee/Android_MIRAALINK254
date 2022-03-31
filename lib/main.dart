// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocery_app/HomePage.dart';
import 'package:grocery_app/sliderpage.dart';
import 'package:grocery_app/ProductInfo.dart';
import 'package:grocery_app/StartUpPage.dart';
import 'package:grocery_app/RegisterPage.dart';
import 'package:grocery_app/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.black),
    home: SplashScreen(),
  // home: LoginRegisterPage(),
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAf_eQHs89WxlVdERPZs4wHtM9N_6AP02M",
        appId: "1:1012629664469:android:68a90bda0e577973be685c",
        messagingSenderId: "1012629664469",
        projectId: "miraalink-67207",
      ),
      );
}

class SplashScreen extends StatefulWidget {
  //const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Future<void> initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => sliderpage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: new CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 150,
                child: Image.asset('images/load.gif'),
              )),
            ],
          ),
        )),
      ),
    );
  }
}
