import 'dart:async';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/LoginPage.dart';

class sliderpage extends StatefulWidget {
  const sliderpage({Key? key}) : super(key: key);

  @override
  _sliderpageState createState() => _sliderpageState();
}

class _sliderpageState extends State<sliderpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Carousel(
        showIndicator: true,
        animationDuration: Duration(milliseconds: 500),
        images: [
          AssetImage('images/slider1.jpg'),
          AssetImage('images/slider2.jpg'),
          AssetImage('images/slider3.jpg'),
          AssetImage('images/slider4.jpg')
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: Opacity(
                    opacity: 1.0,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.orangeAccent),
                    ),
                  ),
                );
              });
          Timer(
            Duration(seconds: 3),
            () =>
 gotoNextpage());
        },
        label: Text(
          'Start',
        ),
        icon: Icon(Icons.arrow_right),
        backgroundColor: Colors.orangeAccent,
        elevation: 30,
      ),
    );
  }

  gotoNextpage() {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginRegisterPage()));
  }
}
