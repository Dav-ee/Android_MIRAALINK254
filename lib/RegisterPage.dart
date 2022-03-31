import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grocery_app/HomePage.dart';
import 'package:grocery_app/LoginPage.dart';
import 'package:grocery_app/StartUpPage.dart';

import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/constants/argon_theme.dart';
//widgets
import 'package:grocery_app/widgets/argon_input.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/HomePage.dart';
import 'package:grocery_app/models/usermodel.dart';
import 'package:grocery_app/models/farmermodel.dart';
import 'package:grocery_app/confirm_otp.dart';





class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

//Enum FormType{ login,  register};
class _RegisterPageState extends State<RegisterPage> {
  late String _email;
  late String _password;
  late String _name;
  late String _phone;

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


  RegisterUser(){
    if(checkFields()){
LinearProgressIndicator();
      Fluttertoast.showToast(msg: "${_email}");

      Fluttertoast.showToast(msg: "${_password}");

      Fluttertoast.showToast(msg: "${_phone}");

      Fluttertoast.showToast(msg: "${_name}");

      Fluttertoast.showToast(msg: "AUTHENTICATION TAKING PLACE.....");

//  do this
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)
          .then((uid) => { postValuesToFirestore()}
      ).catchError((e){
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

  postValuesToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values to user db
    userModel.phone = _phone;
    userModel.email = _email;
    userModel.uid = user?.uid;
    userModel.name = _name;
    await firebaseFirestore.collection("users").doc(user?.uid).set(
      userModel.toMap(),
    );

    //writing data to farmers db
    // FarmerModel farmerModel = FarmerModel();
    // farmerModel.uid = user?.uid;
    // farmerModel.name = _name;
    // farmerModel.phone = _phone;
    // await firebaseFirestore.collection("farmers").doc(user?.uid).set(
    //   farmerModel.toMap(),
    // );

    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.pop(context);
    Navigator.push(context,
         MaterialPageRoute(builder: (context) => ConfirmOTP()));

  }


  // postValuesToFirestore(){
  //   CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('users');
  //   _firebaseFirestore.add({'email': _email , 'password': _password, 'phone': _phone,
  //     'name': _name  }).whenComplete(() {
  //   }).catchError((e){
  //     Fluttertoast.showToast(
  //         msg: e!.message,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER_LEFT,
  //         timeInSecForIosWeb: 4,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   });
  //   Fluttertoast.showToast(msg: "User data registered successfully ${_name}",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER_LEFT,
  //       timeInSecForIosWeb: 4,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0
  //   );
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => HomePage()));
  //
  // }






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
                                        child: Text("Sign up with",
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
                                          child: ElevatedButton(
                                            onPressed: null,
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
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .google,
                                                          size: 13),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("GOOGLE",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
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
                                                          FontAwesomeIcons
                                                              .facebook,
                                                          size: 13),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("FACEBOOK",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
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
                              height: MediaQuery.of(context).size.height * 0.83,
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


                                       Form(
                                         key: formkey,
                                         child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                    cursorColor: ArgonColors.muted,
                                                    autofocus: false,
                                                    validator: requiredValidator,
                                                    onChanged: (val) => _name = val,
                                                    style:
                                                    TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
                                                    textAlignVertical: TextAlignVertical(y: 0.6),
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: ArgonColors.white,
                                                        hintStyle: TextStyle(
                                                          color: ArgonColors.muted,
                                                        ),
                                                        suffixIcon: Icon(Icons.person),
                                                        prefixIcon: Icon(Icons.contact_mail_sharp),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(4.0),
                                                            borderSide: BorderSide(
                                                                color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(4.0),
                                                            borderSide: BorderSide(
                                                                color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                                                        hintText: "Enter Full Name")),

                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                    cursorColor: ArgonColors.muted,
                                                    autofocus: false,
                                                    validator: requiredValidator,
                                                    onChanged: (val) => _phone = val,
                                                    style:
                                                    TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
                                                    textAlignVertical: TextAlignVertical(y: 0.6),
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: ArgonColors.white,
                                                        hintStyle: TextStyle(
                                                          color: ArgonColors.muted,
                                                        ),
                                                        suffixIcon: Icon(Icons.phone),
                                                        prefixIcon: Icon(Icons.phone),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(4.0),
                                                            borderSide: BorderSide(
                                                                color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(4.0),
                                                            borderSide: BorderSide(
                                                                color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                                                        hintText: "Enter phone number")),

                                              ),

                                              Padding(
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
                                                        hintText: "Enter email address")),

                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                    cursorColor: ArgonColors.muted,
                                                    autofocus: false,
                                                    validator: passwordValidator,
                                                    onChanged: (val) => _password = val,
                                                    style:
                                                    TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
                                                    textAlignVertical: TextAlignVertical(y: 0.6),
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: ArgonColors.white,
                                                        hintStyle: TextStyle(
                                                          color: ArgonColors.muted,
                                                        ),
                                                        suffixIcon: Icon(Icons.password),
                                                        prefixIcon: Icon(Icons.lock),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(4.0),
                                                            borderSide: BorderSide(
                                                                color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(4.0),
                                                            borderSide: BorderSide(
                                                                color: ArgonColors.border, width: 1.0, style: BorderStyle.solid)),
                                                        hintText: "Enter password"))
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 24.0),
                                                child: RichText(
                                                    text: TextSpan(
                                                        text: "password should be more than 4 characters long: ",
                                                        style: TextStyle(
                                                            color:
                                                            ArgonColors.muted),
                                                        children: [
                                                          TextSpan(
                                                              text: "strong",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  color: ArgonColors
                                                                      .success))
                                                        ])),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Center(
                                                  child: FlatButton(
                                                    textColor: ArgonColors.white,
                                                    color: ArgonColors.primary,
                                                    onPressed:  () {
                                                      RegisterUser();
                                                      // Navigator.push(context,
                                                      //     MaterialPageRoute(builder: (context) => StartUpPage()));
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
                                                        child: Text("REGISTER NOW",
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
                                            Text("Already have an account? ",
                                                style: TextStyle(
                                                    color: ArgonColors.muted,
                                                    fontWeight:
                                                    FontWeight.w200)),
                                            GestureDetector(
                                                onTap:  () {
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) =>LoginRegisterPage()));
                                                }
                                                ,
                                                child: Container(
                                                  margin:
                                                  EdgeInsets.only(left: 5),
                                                  child: Text("LOGIN NOW",
                                                      style: TextStyle(
                                                          color: ArgonColors
                                                              .primary)),
                                                )),
                                          ],
                                        ),
                                      ),
                                    //removed reg btn here
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
  controller() {}
  tap() {}
}

