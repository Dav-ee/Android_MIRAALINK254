import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grocery_app/LoginPage.dart';
import 'package:grocery_app/RegisterPage.dart';
import 'package:grocery_app/StartUpPage.dart';

import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/constants/argon_theme.dart';
//widgets
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/HomePage.dart';

class ConfirmOTP extends StatefulWidget {
  const ConfirmOTP({Key? key}) : super(key: key);

  @override
  State<ConfirmOTP> createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends State<ConfirmOTP> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late Timer timer;

  TextEditingController myController = TextEditingController()..text = 'Your initial value';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
      if(loggedInUser.email != null){
        setState(() {
          isLoading = false;
        });
      }
    });

    user?.sendEmailVerification();
    timer =  Timer.periodic(Duration(seconds: 1), (timer)
    {
      checkEmailVerified();
    });

  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  late String _otp;
  String verificationIDreceived = "";
  final formkey = GlobalKey<FormState>();

  final requiredValidator =
  RequiredValidator(errorText: 'This field is required');

  //FormType formType = FormType.login;

  checkFields() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/imgs/register-bg.png"),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 24.0, right: 24.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                  color: ArgonColors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: ArgonColors.muted))),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text("ONE TIME EMAIL VERIFICATION",
                                            style: TextStyle(
                                                color: ArgonColors.text,
                                                fontSize: 16.0)),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                      ],
                                    ),
                                  ),
                                  // Divider()
                                ],
                              )),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.63,
                              color: Color.fromRGBO(244, 245, 247, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      (isLoading)
                                          ? Center(
                                            child: SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: CircularProgressIndicator(
                                                color: Colors.blueAccent,
                                                strokeWidth: 3,

                                              ),
                                            ),
                                          )
                                          :Padding(
                                        padding: const EdgeInsets.only(
                                            top: 24.0, bottom: 24.0),
                                        child: Center(
                                          child: Text(
                                              "A verification code has been sent to your email address(${loggedInUser.email})."
                                                  " Kindly check your email inbox and verify via the link provided.",
                                              style: TextStyle(
                                                  color: ArgonColors.text,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 16)),
                                        ),
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Center(
                                          child: FlatButton(
                                            textColor: ArgonColors.white,
                                            color: ArgonColors.primary,
                                            onPressed:  () {

                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(4.0),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 12,
                                                    bottom: 12),
                                                child: Text("CONTINUE",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16.0))),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
                ),
              ]),
            )
          ],
        ));
  }

  Future<void> checkEmailVerified() async {
    user = FirebaseAuth.instance.currentUser;
  await user?.reload();
    if(user!.emailVerified){
timer.cancel();
Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => StartUpPage(
          )));
    }
  }


}

