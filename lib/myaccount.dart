

import 'package:encrypt_decrypt_plus/cipher/cipher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GridHome.dart';
import 'functionPHP.dart';
import 'global.dart';


class Myaccount extends StatefulWidget {

  const Myaccount({Key? key}) : super(key: key);

  @override
  State<Myaccount> createState() => _HomePageState( );
}


class _HomePageState extends State<Myaccount> {


  _HomePageState();




  void initState() {

    super.initState();
    getLoginData2();
    setState(() {

    });

  }









  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color(0xffffffff),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                          child: Text(
                            usernameD,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                name,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
                                  color: Color(0xff000000),
                                ),
                              ),SizedBox(width: 10,),
                              Text(
                                ":اسم مالك الحساب",
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                phone,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12,
                                  color: Color(0xff000000),
                                ),
                              ),SizedBox(width: 10,),
                              Text(
                                ":رقم الهاتف",
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),


                        Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                          child: Text(
                            "حياة صعبة",
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                          child: MaterialButton(
                            onPressed: () {
                              Logout();

                            },
                            color: Color(0xffffffff),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side:
                              BorderSide(color: Color(0xff808080), width: 1),
                            ),
                            padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              "تسجيل الخروج",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            textColor: Color(0xff000000),
                            height: 40,
                            minWidth: 140,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}

