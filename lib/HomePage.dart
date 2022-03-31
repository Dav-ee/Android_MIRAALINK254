import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:grocery_app/constants/Style.dart';
import 'package:grocery_app/ProductInfo.dart';
import 'package:grocery_app/farmer2.dart';
import 'package:grocery_app/farmer3.dart';
import 'package:grocery_app/farmer4.dart';
import 'package:grocery_app/farmer5.dart';
import 'package:grocery_app/farmer6.dart';
import 'package:grocery_app/farmer7.dart';
import 'package:grocery_app/farmer8.dart';
import 'package:grocery_app/farmer9.dart';
import 'package:grocery_app/farmer10.dart';
import 'package:grocery_app/farmer11.dart';
import 'package:grocery_app/farmer12.dart';
import 'package:grocery_app/models/usermodel.dart';
import 'package:grocery_app/models/farmermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('farmers');
  UserModel loggedInUser = UserModel();
  FarmerModel getFarmer = FarmerModel();
  bool isLoading = true;
  User? user = FirebaseAuth.instance.currentUser;

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
      if (loggedInUser.email != null) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  List<String> suggestions = [
    "Miraa",
    "Khat",
    "Veve",
    "Muguka",
    "Jaba",
  ];
  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (isLoading)
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
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    title: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(22))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: SimpleAutoCompleteTextField(
                                key: key,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search Item "),
                                suggestions: suggestions,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                textChanged: (text) => currentText = text,
                                clearOnSubmit: true,
                                textSubmitted: (text) => setState(() {
                                  if (text != "") {
                                    added.add(text);
                                  }
                                }),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 0,
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                      onPressed: () {},
                                      color: Colors.black,
                                      icon: Icon(Icons.search))
                                ],
                              )),
                        ],
                      ),
                    ),
                    // backgroundColor: Colors.white,
                    expandedHeight: 100,
                    flexibleSpace: FlexibleSpaceBar(
                      background: new SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Carousel(
                          images: [
                            AssetImage("images/banner1.jpg"),
                            AssetImage("images/banner2.jpg"),
                            AssetImage("images/banner3.jpg"),
                            AssetImage("images/banner4.jpg"),
                          ],
                          dotBgColor: Colors.transparent,
                          animationDuration: Duration(milliseconds: 700),
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${loggedInUser.name}, Welcome to MIRAALINK 254. ",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "+${loggedInUser.phone}",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "OUR TOP  VENDORS",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                height: 0.5,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer1.jpg"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "KANYE FARM",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.verified_rounded,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "LOCATION: Chepareria - WEST POKOT",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer2.jpg"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "ALEX MUSIO FARM",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.verified_rounded,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "LOCATION: Laare - MERU COUNTY",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage2,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer3.jpg"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "FARM DELTA",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.verified_rounded,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "LOCATION: Igembe  - MERU COUNTY",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage3,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer4.jpg"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "ANDREW AND SONS FARM",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.verified_rounded,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "LOCATION: Tigania  - MERU COUNTY ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage4,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer5.jpg"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "MUTEMBEI FARM",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.verified_rounded,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "LOCATION: MAUA  - EMBU COUNTY ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage5,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer9.jpg"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "NDANU FARM",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.verified_rounded,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "LOCATION:  MERU COUNTY ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage9,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer10.jpg"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "ISAKA FARM",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.verified_rounded,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "LOCATION:  MERU COUNTY ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage10,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "OTHER VENDORS",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                height: 0.5,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer6.png"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "CAROO FARM",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "LOCATION:  EMBU COUNTY ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage6,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer7.png"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "KIFEE FARM",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "LOCATION:  MERU COUNTY ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage7,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer8.png"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "KINUTHIA FARM",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),

                                    ],
                                  ),
                                  Text(
                                    "LOCATION:  MERU COUNTY ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage8,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer11.png"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "HOMEHALLOW FARM",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "LOCATION:  MERU COUNTY ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage11,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/imgs/farmer12.png"))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "GABU FARM",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "LOCATION:  MERU COUNTY ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: openHotelPage12,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn),
                                child: Text(
                                  "MORE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),


                        SingleChildScrollView(
                          padding: EdgeInsets.only(bottom: 20),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                height:
                                    MediaQuery.of(context).size.height * 0.80,
                                padding: EdgeInsets.symmetric(
                                    vertical: 40, horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    color: blue,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 0,
                                          offset: Offset(0, 10),
                                          blurRadius: 0,
                                          color: blue.withOpacity(0.4))
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "ABOUT US",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.arrow_back_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "MIRAALINK254 is Kenya's no. 1 online retailer  established in March 2022 with the aim and vision to become "
                                      "the one-stop shop for retail of Miraa in Kenya with implementation of best"
                                      " practices both online and offline. The logistics service enables the delivery of"
                                      " bulk Miraa through a network of local partners while the payment services facilitate the"
                                      " payments of online transactions within MIRAALINK254's ecosystem. It has partnered with"
                                      " more than 5 active Miraa bulk sellers/individuals.",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          height: 1.2,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "OUR SERVICES",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.miscellaneous_services,
                                          color: Colors.white,
                                          size: 19,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "MIRAALINK254   is a platform for Miraa buyers to meet Miraa vendors/sellers. "
                                      "All services ranging from delivery, packaging in Nairobi and across Kenya are "
                                      "offered here. Buyer locate seller of his/her "
                                      "likings make contact either offline or through the app",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "CONTACT US NOW",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.contact_mail_outlined,
                                              color: Colors.white,
                                              size: 19,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.blue,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "PHONE:  254745682815",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.whatsapp_rounded,
                                          color: Colors.lightGreen,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "WHATSAPP:  254745682815",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: Colors.orangeAccent,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "EMAIL:  MIRAALINK254@GMAIL.COM",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  // Row placesWidget(String img, String name, String desc )
  // {
  // return Row(
  //   children: [
  //     Container(
  //       height: 80,
  //       width: 80,
  //       decoration: BoxDecoration(
  //           image: DecorationImage(
  //               image: AssetImage("assets/imgs/$img.jpg")
  //           )
  //       ),
  //     ),
  //     SizedBox(
  //       width: 20,
  //     ),
  //     Expanded(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Text("$name", style: TextStyle(
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.w600
  //               ),),
  //               Icon(
  //                 Icons.verified_rounded,
  //                 color: Colors.blue,
  //                 size: 16,
  //               ),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               Icon(Icons.star, size: 15, color: Colors.orange,),
  //               Icon(Icons.star, size: 15, color: Colors.orange,),
  //               Icon(Icons.star, size: 15, color: Colors.orange,),
  //               Icon(Icons.star, size: 15, color: Colors.orange,),
  //               Icon(Icons.star, size: 15, color: Colors.orange,),
  //             ],
  //           ),
  //           Text( '$desc', style: TextStyle(
  //               fontSize: 12,
  //           ),)
  //         ],
  //       ),
  //     ),
  //     InkWell(
  //       onTap: openHotelPage,
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(40)),
  //             color: greenBtn
  //         ),
  //         child: Text("MORE", style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 12,
  //             fontWeight: FontWeight.w700
  //         ),),
  //       ),
  //     )
  //   ],
  // );
  // }
  void openHotelPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => hotelPage()));
  }

  void openHotelPage2() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Farmer2()));
  }

  void openHotelPage3() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Farmer3()));
  }

  void openHotelPage4() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Farmer4()));
  }

  void openHotelPage5() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Farmer5()));
  }

  void openHotelPage6() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Farmer6()));
  }

  void openHotelPage7() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Farmer7()));
  }

  void openHotelPage8() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Farmer8()));
  }

  void openHotelPage9() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Farmer9()));
  }

  void openHotelPage10() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Farmer10()));
  }
  void openHotelPage11() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Farmer11()));
  }
  void openHotelPage12() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Farmer12()));
  }
}
