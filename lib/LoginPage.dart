import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grocery_app/HomePage.dart';
import 'package:grocery_app/RegisterPage.dart';
import 'package:grocery_app/StartUpPage.dart';
import 'package:grocery_app/ResetPassword.dart';
import 'package:grocery_app/confirm_otp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/constants/argon_theme.dart';
//widgets
import 'package:grocery_app/widgets/argon_input.dart';
import 'package:grocery_app/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRegisterPage extends StatefulWidget {
  //const LoginRegisterPage({Key? key}) : super(key: key);
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

//Enum FormType{ login,  register};
class _LoginRegisterPageState extends State<LoginRegisterPage> {

   User? user = FirebaseAuth.instance.currentUser;
   UserModel loggedInUser = UserModel();

  @override
  void initState() {
     super.initState();
     if(user != null){
       FirebaseFirestore.instance
           .collection("users")
           .doc(user!.uid)
           .get()
           .then((value) {
         loggedInUser = UserModel.fromMap(value.data());
         if (loggedInUser.phone != null) {
           Navigator.push(context,
               MaterialPageRoute(builder: (context) =>
                   StartUpPage(
                   )));
         }
       });
     }



  }


  late String _email;
  late String _password;
  final formkey = GlobalKey<FormState>();

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address')
  ]);
  final requiredValidator =
      RequiredValidator(errorText: 'This field is required');
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText:
            'Passwords must have at least one special character i.e /*&%%(')
  ]);

  checkFields() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  loginUser() {
    if (checkFields()) {
      Fluttertoast.showToast(msg: "${_email}");

      Fluttertoast.showToast(msg: "${_password}");

      Fluttertoast.showToast(msg: "AUTHENTICATION TAKING PLACE.....");

      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((uid) {
        Fluttertoast.showToast(
            msg: "Login  successfull ${_email}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_LEFT,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => StartUpPage(
        //     )));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ConfirmOTP()));
      }).catchError((e) {
        Fluttertoast.showToast(
            msg: e!.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER_LEFT,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
                                      width: 0.5, color: ArgonColors.muted))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Login  with",
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
                                    Container(
                                      // width: 0,
                                      height: 36,
                                      child: RaisedButton(
                                          textColor: ArgonColors.primary,
                                          color: ArgonColors.secondary,
                                          onPressed: () {},
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10,
                                                  top: 10,
                                                  left: 14,
                                                  right: 14),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Icon(FontAwesomeIcons.github,
                                                      size: 13),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text("GITHUB",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13))
                                                ],
                                              ))),
                                    ),
                                    Container(
                                      // width: 0,
                                      height: 36,
                                      child: RaisedButton(
                                          textColor: ArgonColors.primary,
                                          color: ArgonColors.secondary,
                                          onPressed: () {},
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10,
                                                  top: 10,
                                                  left: 8,
                                                  right: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Icon(
                                                      FontAwesomeIcons.facebook,
                                                      size: 13),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text("FACEBOOK",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13))
                                                ],
                                              ))),
                                    ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Form(
                                    key: formkey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                                initialValue: 'DAVIES.LANGATT@GMAIL.COM',
                                                cursorColor: ArgonColors.muted,
                                                autofocus: false,
                                                validator: emailValidator,
                                                onChanged: (val) =>
                                                    _email = val,
                                                style: TextStyle(
                                                    height: 0.85,
                                                    fontSize: 14.0,
                                                    color: ArgonColors.initial),
                                                textAlignVertical:
                                                    TextAlignVertical(y: 0.6),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        ArgonColors.white,
                                                    hintStyle: TextStyle(
                                                      color: ArgonColors.muted,
                                                    ),
                                                    suffixIcon:
                                                        Icon(Icons.email),
                                                    prefixIcon:
                                                        Icon(Icons.email),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4.0),
                                                        borderSide: BorderSide(
                                                            color: ArgonColors
                                                                .border,
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4.0),
                                                        borderSide: BorderSide(
                                                            color: ArgonColors
                                                                .border,
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid)),
                                                    hintText: "Enter email address")),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                                initialValue: 'DAVIES.LANGATT@GMAIL.COM',
                                                obscureText: true,
                                                cursorColor: ArgonColors.muted,
                                                autofocus: false,
                                                validator: passwordValidator,
                                                onChanged: (val) =>
                                                    _password = val,
                                                style: TextStyle(
                                                    height: 0.85,
                                                    fontSize: 14.0,
                                                    color: ArgonColors.initial),
                                                textAlignVertical:
                                                    TextAlignVertical(y: 0.6),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        ArgonColors.white,
                                                    hintStyle: TextStyle(
                                                      color: ArgonColors.muted,
                                                    ),
                                                    suffixIcon:
                                                        Icon(Icons.password),
                                                    prefixIcon:
                                                        Icon(Icons.lock),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4.0),
                                                        borderSide: BorderSide(
                                                            color: ArgonColors
                                                                .border,
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4.0),
                                                        borderSide: BorderSide(
                                                            color: ArgonColors
                                                                .border,
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid)),
                                                    hintText: "Enter password")),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Center(
                                            child: FlatButton(
                                              textColor: ArgonColors.white,
                                              color: ArgonColors.primary,
                                              onPressed: () {
                                                loginUser();
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
                                                  child: Text("LOGIN",
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 0, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Checkbox(
                                        //     activeColor:
                                        //     ArgonColors.primary,
                                        //     onChanged: onChanged(), value: ,
                                        // ),
                                        Text("Don\'t have an account?",
                                            style: TextStyle(
                                                color: ArgonColors.muted,
                                                fontWeight: FontWeight.w200)),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterPage()));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Text("REGISTER NOW",
                                                  style: TextStyle(
                                                      color:
                                                          ArgonColors.primary)),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 0, bottom: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Checkbox(
                                        //     activeColor:
                                        //     ArgonColors.primary,
                                        //     onChanged: onChanged(), value: ,
                                        // ),
                                        Text("Forgot your password?",
                                            style: TextStyle(
                                                color: ArgonColors.muted,
                                                fontWeight: FontWeight.w200)),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ResetPassword()));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Text("RESET NOW",
                                                  style: TextStyle(
                                                      color:
                                                          ArgonColors.primary)),
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
