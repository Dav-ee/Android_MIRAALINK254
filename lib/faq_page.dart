import 'package:grocery_app/constants/app_properties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  List<Panel> panels = [
    Panel(
        'HOW CAN I CHANGE MY PASSWORD?',
        'Head to Settings page> change password',
        false),
    Panel(
        'HOW CAN I UPDATE MY PROFILE?',
        'Profile page> Touch the avatar icon> then upload',
        false),
    Panel(
        'HOW CAN I TRACK MY ORDERS & PAYMENT?',
        'On the Order page, you will see order progress',
        false),
    Panel(
        'HOW LONG WILL IT TAKE FOR MY ORDER TO ARRIVE AFTER I MAKE PAYMENT?',
        'AT most 1 DAY',
        false),
    Panel(
        'HOW DO YOU SHIP MY ORDERS?',
        'Depends with clients mode of delivery.',
        false),
    Panel(
        'HOW DO I MAKE PAYMENTS USING MPESA? HOW DOES IT WORK?',
        'PROFILE>> WALLET >> THEN DEPOSIT',
        false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:24.0,right:24.0,bottom: 16.0),
                child: Text(
                  'FAQ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),... panels.map((panel)=>ExpansionTile(
                  title: Text(
                    panel.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600]),
                  ),

                  children: [Container(
                      padding: EdgeInsets.all(16.0),
                      color: Color(0xffFAF1E2),
                      child: Text(
                          panel.content,
                          style:
                          TextStyle(color: Colors.grey, fontSize: 12)))])).toList(),

            ],
          ),
        ),
      ),
    );
  }
}

class Panel {
  String title;
  String content;
  bool expanded;

  Panel(this.title, this.content, this.expanded);
}
