import 'package:grocery_app/LoginPage.dart';
import 'package:grocery_app/constants/app_properties.dart';
import 'package:grocery_app/constants/custom_background.dart';
import 'package:grocery_app/settings/change_password.dart';
import 'package:grocery_app/settings/legal_about_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
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
          child: LayoutBuilder(
              builder:(builder,constraints)=> SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'General',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text(
                            'Account',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                        ListTile(
                          title: Text('Change Password'),
                          leading: Image.asset('assets/icons/change_pass.png'),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ChangePasswordPage())),
                        ),
                        ListTile(
                          title: Text('Sign out'),
                          leading: Image.asset('assets/icons/sign_out.png'),
                          onTap: () {
Signout();
Navigator.pop(context);
Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => LoginRegisterPage()));
                          },
                        ),],
                    ),
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}

class Signout {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
