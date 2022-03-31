import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grocery_app/LoginPage.dart';
import 'package:grocery_app/RegisterPage.dart';
import 'package:grocery_app/StartUpPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/constants/argon_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
//widgets
import 'package:grocery_app/widgets/argon_input.dart';


class ResetPassword extends StatefulWidget {
  //const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  late String _email;
  late String _password;
  final formkey = GlobalKey<FormState>();

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address')
  ]);
  checkFields() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }




  void Resetpassword() async {
    Fluttertoast.showToast(msg: "${_email}");

    if(checkFields()){
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email)
          .then((uid) => {
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => LoginRegisterPage())),

      Fluttertoast.showToast(
      msg: "E-mail has been sent successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER_LEFT,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
      ),

      })
          .catchError((e) {
        Fluttertoast.showToast(
            msg:  e!.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_LEFT,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                        child: Text("FORGOT YOUR PASSWORD",
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 24.0, bottom: 24.0),
                                        child: Center(
                                          child: Text(
                                              "Enter your valid email address and instructions will be sent to you.",
                                              style: TextStyle(
                                                  color: ArgonColors.text,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 16)),
                                        ),
                                      ),
                                      Form(
                                        key: formkey,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
    Padding(
    padding: const EdgeInsets.all(8.0),
    child:                                               Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
    cursorColor: ArgonColors.muted,
    autofocus: false,
    validator: emailValidator,
    onChanged: (val) => _email = val,
    style:
    TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
    textAlignVertical: TextAlignVertical(y: 0.6),
    decoration: InputDecoration(
    filled: true,
    fillColor: ArgonColors.white,
    hintStyle: TextStyle(
    color: ArgonColors.muted,
    ),
    suffixIcon: Icon(Icons.email),
    prefixIcon: Icon(Icons.email),
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
    borderSide: BorderSide(
    color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.0),
    borderSide: BorderSide(
    color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
    hintText: "Enter your email address")),

    ),
    ),

                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Center(
                                                child: FlatButton(
                                                  textColor: ArgonColors.white,
                                                  color: ArgonColors.primary,
                                                  onPressed:  () {
                                                    Resetpassword();
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
                                                      child: Text("RESET PASSWORD",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize: 16.0))),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 0, bottom: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            // Checkbox(
                                            //     activeColor:
                                            //     ArgonColors.primary,
                                            //     onChanged: onChanged(), value: ,
                                            // ),
                                            Text("Remember Your password?",
                                                style: TextStyle(
                                                    color: ArgonColors.muted,
                                                    fontWeight:
                                                    FontWeight.w200)),
                                            GestureDetector(
                                                onTap:  () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => LoginRegisterPage()));
                                                }
                                                ,
                                                child: Container(
                                                  margin:
                                                  EdgeInsets.only(left: 5),
                                                  child: Text("BACK TO LOGIN",
                                                      style: TextStyle(
                                                          color: ArgonColors
                                                              .primary)),
                                                )),
                                          ],
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

  tap() {}

  controller() {}

}
