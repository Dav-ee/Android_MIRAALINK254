import 'package:grocery_app/constants/app_properties.dart';
import 'package:grocery_app/constants/color_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:grocery_app/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';



class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  final requiredValidator =
  RequiredValidator(errorText: 'This field is required');
  final formkey = GlobalKey<FormState>();
  late String _amount;

  Color active = Colors.red;
  TextEditingController cardNumber = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController month = TextEditingController();
  TextEditingController cvc = TextEditingController();
  TextEditingController cardHolder = TextEditingController();

  ScrollController scrollController = ScrollController();


  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

 bool isLoading = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection.index == 1) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });

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

  String convertCardNumber(String src, String divider) {
    String newStr = '';
    int step = 4;
    for (int i = 0; i < src.length; i += step) {
      newStr += src.substring(i, math.min(i + step, src.length));
      if (i + step < src.length) newStr += divider;
    }
    return newStr;
  }

  String convertMonthYear(String month, String year) {
    if (month.isNotEmpty)
      return month + '/' + year;
    else
      return '';
  }

  checkFields() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }


      Future<dynamic> startTransaction() async {
        if (checkFields()) {

          Fluttertoast.showToast(msg: "${loggedInUser.phone}");
          Fluttertoast.showToast(msg: "${_amount}");

          dynamic transactionInitialization;
          //Wrap it with a try-catch
          try {
            //Run it
            transactionInitialization =
            await MpesaFlutterPlugin.initializeMpesaSTKPush(
                businessShortCode:
                "174379",
                //use your store number if the transaction type is CustomerBuyGoodsOnline
                transactionType: TransactionType
                    .CustomerPayBillOnline,
                //or CustomerBuyGoodsOnline for till numbers
                amount: 1.0,
                partyA: "${loggedInUser.phone}",
                partyB: "174379",
                callBackURL: Uri(
                    scheme: "https",
                    host: "1234.1234.co.ke",
                    path: "/1234.php"),
                accountReference: "DAV_EE",
                phoneNumber: "${loggedInUser.phone}",
                baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
                transactionDesc: "MIRAALINK 254",
                passKey:
                "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

            var result = transactionInitialization as Map<String, dynamic>;

            if (result.keys.contains("ResponseCode")) {
              String mResponseCode = result["ResponseCode"];
              print("Resulting Code: " + mResponseCode);
              // if (mResponseCode == '0') {
              //   updateAccount(result["CheckoutRequestID"]);
              // }
            }
            print("RESULT: " + transactionInitialization.toString());
          } catch (e) {
            //you can implement your exception handling here.
            //Network Reachability is a sure exception.
            print("Err");
            print("Exception Caught: " + e.toString());
          }
        }
      }


  @override
  Widget build(BuildContext context) {
    TextEditingController phone = TextEditingController()..text = "${loggedInUser.phone}";
    Widget addThisCard = InkWell(
     onTap: () {
       MpesaFlutterPlugin.setConsumerKey('2guyy9F7n0qxFGcx3yx7qriOy6a0fzhP');
       MpesaFlutterPlugin.setConsumerSecret('CUimti3is5ZXwHft');
       startTransaction();
     },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("DEPOSIT FUNDS",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, constraints) => GestureDetector(
          onPanDown: (val) {},
          behavior: HitTestBehavior.opaque,
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
            controller: scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: kToolbarHeight),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'MY E-WALLET',
                          style: TextStyle(
                            color: darkGrey,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CloseButton()
                      ],
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                          color: active,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'M-PESA GATEWAY',
                            style: TextStyle(color: Colors.white),
                          ),

                          SizedBox(height: 16.0),
                          Text(
                            'AVAILABLE FUNDS : KES 20,003',
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 5,
                                width: 150,
                                color: Colors.yellow,
                              ),
                              Flexible(
                                  child: Center(
                                      child: Text(
                                          convertCardNumber(
                                              cardNumber.text, '-'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)))),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(convertMonthYear(month.text, year.text),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text(cvc.text,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Spacer(),
                          Text(cardHolder.text,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Colors.red,
                          Colors.blue,
                          Colors.purple[700],
                          Colors.green[700],
                          Colors.lightBlueAccent
                        ]
                            .map((c) => InkWell(
                          onTap: () {
                            setState(() {
                              active = c ?? Colors.red;
                            });
                          },
                          child: Transform.scale(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ColorOption(c ?? Colors.red),
                              ),
                              scale: active == c ? 1.2 : 1),
                        ))
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 16.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5)),
                                color: Colors.grey[200],
                              ),
                              child: TextField(
                                controller: phone,
                                onChanged: (val) {
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Mobile Number'),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 16.0),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      color: Colors.grey[200],
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Amount'),
                                      validator: requiredValidator,
                                      onChanged: (val) =>
                                      _amount = val,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),


                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: addThisCard,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

