import 'package:grocery_app/constants/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddAddressForm extends StatefulWidget {
  const AddAddressForm({Key? key}) : super(key: key);

  @override
  State<AddAddressForm> createState() => _AddAddressFormState();
}

class _AddAddressFormState extends State<AddAddressForm> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
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
  }



  @override
  Widget build(BuildContext context) {

    TextEditingController fullname = TextEditingController()..text = "${loggedInUser.name}";
    TextEditingController phone = TextEditingController()..text = "${loggedInUser.phone}";
    TextEditingController email = TextEditingController()..text = "${loggedInUser.email}";


    return     (isLoading)
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
        : SizedBox (
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextField(
              controller: fullname,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Full Name'),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextField(
              controller: phone,
              decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Phone Number'),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextField(
              controller: email,
              decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Email Address'),
            ),
          ),

          Row(
            children: <Widget>[
              Checkbox(
                value: true,
                onChanged: (_) {},
              ),
              Text('I consent that all my info submitted herein are correct')
            ],
          )
        ],
      ),
    );
  }
}
