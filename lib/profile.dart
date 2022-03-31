import 'package:grocery_app/constants/app_properties.dart';
import 'package:grocery_app/faq_page.dart';
import 'package:grocery_app/payment_page.dart';
import 'package:grocery_app/OrderHistoryPage.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/settings/settings_page.dart';
import 'package:grocery_app/settings/legal_about_page.dart';
import 'package:grocery_app/settings/support.dart';
import 'package:grocery_app/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:avatars/avatars.dart';

    class ProfilePage extends StatefulWidget {
      const ProfilePage({Key? key}) : super(key: key);

      @override
      State<ProfilePage> createState() => _ProfilePageState();
    }

    class _ProfilePageState extends State<ProfilePage> {

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
        return Scaffold(
          backgroundColor: Color(0xffF9F9F9),
          body: SafeArea(
            top: true,
            child:   (isLoading)
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
                :SingleChildScrollView(
              child: Padding(
                padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
                child: Column(
                  children: <Widget>[
                    // CircleAvatar(
                    //   maxRadius: 48,
                    //   backgroundImage: AssetImage('assets/background.jpg'),
                    // ),
                    Avatar(
                      elevation: 3,
                      shape: AvatarShape.rectangle(
                          100, 100, BorderRadius.all(new Radius.circular(20.0))),
                      name: '${loggedInUser.name}', // Uses name initials (up to two)
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${loggedInUser.name}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: transparentYellow,
                                blurRadius: 4,
                                spreadRadius: 1,
                                offset: Offset(0, 1))
                          ]),
                      height: 150,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: <Widget>[
                            //     IconButton(
                            //       icon: Image.asset('assets/icons/wallet.png'),
                            //       onPressed:() {}
                            //     ),
                            //     Text(
                            //       'Wallet',
                            //       style: TextStyle(fontWeight: FontWeight.bold),
                            //     )
                            //   ],
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Image.asset('assets/icons/truck.png'),
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) => TrackingPage())),
                                ),
                                Text(
                                  'Shipped',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Image.asset('assets/icons/card.png'),
                                  onPressed:()=> Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => PaymentPage())),
                                ),
                                Text(
                                  'E-Wallet',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Image.asset('assets/icons/contact_us.png'),
                                  onPressed:()=> Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => SupportPage())),
                                ),
                                Text(
                                  'Support',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Settings'),
                      subtitle: Text('Privacy and logout'),
                      leading: Image.asset('assets/icons/settings_icon.png', fit: BoxFit.scaleDown, width: 30, height: 30,),
                      trailing: Icon(Icons.chevron_right, color: yellow),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SettingsPage())),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Help & Support'),
                      subtitle: Text('Help center and legal support'),
                      leading: Image.asset('assets/icons/support.png'),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: yellow,
                      ),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => LegalAboutPage())),


                    ),
                    Divider(),
                    ListTile(
                      title: Text('FAQ'),
                      subtitle: Text('Questions and Answer'),
                      leading: Image.asset('assets/icons/faq.png'),
                      trailing: Icon(Icons.chevron_right, color: yellow),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => FaqPage())),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }

