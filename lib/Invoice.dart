


import 'dart:async';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'Orders.dart';
import 'functionPHP.dart';
import 'global.dart';


class Invoice extends StatefulWidget {

  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _HomePageState( );
}


class _HomePageState extends State<Invoice> {


  _HomePageState();


  final userController = TextEditingController();
  final passController = TextEditingController();
  bool ckeckbox=true;
  String usernameD="";
  String nameD="";
  String phoneD="";
  String addressD = '';
  String username = '';
  String password = '';
  String decryptusr = '';
  String decryptpas = '';

  String userid = '';
  String name = '';
  String phone = '';
  String address = '';


  void initState() {

    super.initState();
    getLoginData();

  }

  Future<void> Logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', '');
    await prefs.setString('password', '');
    await prefs.setString('usernameH', '');
    await prefs.setString('passwordH', '');
    await prefs.setString('useridH', '');
    await prefs.setString('nameH', '');
    await prefs.setString('phoneH', '');
    await prefs.setString('addressH', '');
    SController.animateToPage(1, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);

  }



  Future<void> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     username = prefs.getString('usernameH') ?? '';
     password = prefs.getString('passwordH') ?? '';


     userid =prefs.getString('useridH') ?? '';
     name = prefs.getString('nameH') ?? '';
     phone = prefs.getString('phoneH') ?? '';
    address = prefs.getString('addressH') ?? '';



       decryptusr = cipher.xorDecode(username);
       decryptpas = cipher.xorDecode(password);
    int x= await Checklogin(decryptusr,decryptpas);
    if(x==0)
      Logout();
    if(x==1)
    {

      print("connect Ok");
    }

        usernameD="اسم الحساب:$decryptusr";

        nameD="الاسم:$name";
        phoneD="رقم:$phone";
       addressD="عنوان:$address";
      // Use the retrieved username and password as needed
      setState(() {

      });

  }




  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color(0xffffffff),

        body: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0x00ff0000),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
            border: Border.all(color: Color(0x4d9e9e9e), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Color(0xc51511de),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Color(0x4d9e9e9e), width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0x1f000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.zero,
                          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                        child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        Image(
                          image: NetworkImage(
                              "https://zeopost.zeo-iq.com/img/logo.jpeg"),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "رقم الوصل",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: Color(0xff000000),
                            ),
                          ),
              BarcodeWidget(color: Colors.black,
                barcode: Barcode.code128(), // Barcode type and settings
                data: '${invoiceview[0]['id']}', // Content
                width: 120,
                height: 60,
              ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "تاريخ الطلب",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            '${invoiceview[0]['order_date']}',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: GridView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1.2,
                              ),
                              children: [
                                Container(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  width: 200,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0x1f000000),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        decoration: BoxDecoration(
                                          color: Color(0x80000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          " اسم المستلم",
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xfff7d6d6),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height*0.116,
                                        decoration: BoxDecoration(
                                          color: Color(0x1f000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          '${invoiceview[0]['recipient_name']}',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffb68b8b),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  width: 200,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0x1f000000),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        decoration: BoxDecoration(
                                          color: Color(0x80000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          "اسم البيج",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height*0.116,
                                        decoration: BoxDecoration(
                                          color: Color(0x1f000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          '${invoiceview[0]['sender_name']}',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffb58b8b),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  width: 200,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0x1f000000),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        decoration: BoxDecoration(
                                          color: Color(0x7f000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          "هاتف المستلم",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: MediaQuery.of(context).size.width,
                                        height:MediaQuery.of(context).size.height*0.116,
                                        decoration: BoxDecoration(
                                          color: Color(0x1f000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          '${invoiceview[0]['recipient_phone']}',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffb68c8c),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  width: 200,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0x1f000000),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height*0.05,
                                        decoration: BoxDecoration(
                                          color: Color(0x80000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          "هاتف البيج",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height*0.116,
                                        decoration: BoxDecoration(
                                          color: Color(0x1f000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          '${invoiceview[0]['sender_phone']}',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffb68b8b),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  width: 200,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0x1f000000),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height*0.05,
                                        decoration: BoxDecoration(
                                          color: Color(0x80000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          "العنوان",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height*0.116,
                                        decoration: BoxDecoration(
                                          color: Color(0x1f000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          '${invoiceview[0]['address']}',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffb58d8d),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  width: 200,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0x1f000000),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: 200,
                                        height: MediaQuery.of(context).size.height*0.05,
                                        decoration: BoxDecoration(
                                          color: Color(0x7f000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          "المبلغ الكلي",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height*0.116,
                                        decoration: BoxDecoration(
                                          color: Color(0x1f000000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.zero,
                                          border: Border.all(
                                              color: Color(0x4d9e9e9e), width: 1),
                                        ),
                                        child: Text(
                                          '${invoiceview[0]['total_price']}',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xffbc9393),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            width: 400,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0x1f000000),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.zero,
                              border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.05,
                                  decoration: BoxDecoration(
                                    color: Color(0x7f000000),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                    border: Border.all(
                                        color: Color(0x4d9e9e9e), width: 1),
                                  ),
                                  child: Text(
                                    "الملاحظات",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.075,
                                  decoration: BoxDecoration(
                                    color: Color(0x1f000000),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.zero,
                                    border: Border.all(
                                        color: Color(0x4d9e9e9e), width: 1),
                                  ),
                                  child: Text(
                                    '${invoiceview[0]['notes']}',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xffbc9393),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: MaterialButton(
                                    onPressed: () {
                                    },
                                    color: Color(0xffffd261),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.0),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      "انشاء طلب",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    textColor: Color(0xff4d4d4d),
                                    height: 50,
                                    minWidth: MediaQuery.of(context).size.width*0.2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: MaterialButton(
                                    onPressed: () {

                                      //DeleteRow("invoice",int.parse(invoiceview[0]['id']));
                                       getDataorders("invoice");
                                      getOrdersData();

                                      OController.animateToPage(0, duration: const Duration(microseconds: 800), curve: Curves.easeIn);
setState(() {

});
                                    },
                                    color: Color(0xffffd261),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.0),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      "حذف",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    textColor: Color(0xff4d4d4d),
                                    height: 50,
                                    minWidth: MediaQuery.of(context).size.width*0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}

