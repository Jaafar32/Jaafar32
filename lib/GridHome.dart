


import 'dart:async';

import 'package:first_app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'functionPHP.dart';



List<Map<String, dynamic>> data=[];
final findController = TextEditingController();
int SelectI=-1;
var result2;

class GridHome extends StatefulWidget {

  const GridHome({Key? key}) : super(key: key);

  @override
  State<GridHome> createState() => _HomePageState( );
}


class _HomePageState extends State<GridHome> {



  _HomePageState();






  Future<void> waitFinitState() async {
    await getLoginData2();

    invoiceview=[];





    if(dataH!=null)
      await  getOrdersData3();
setState(() {

});

      HController.animateToPage(3, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);


  }


  void initState() {

    super.initState();




  }











  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {

            HController.animateToPage(1, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);
            setState(() {
              selectedIndex = 1;
            });

          // Handle FAB press
        },
      ),
      backgroundColor: Color(0xffffffff),

      body: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,

          children: [
            InkWell(onTap: () {
if(isconnect==1)
  {

    selectordertype=0;
    selectcoloer=8;
    waitFinitState();



              setState(() {
                selectedIndex = 3;
              });}
            },
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width-30,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6s8SUWJ9Vr681FKY0JlN1ve-CV13jYvEAZQ&usqp=CAU"),

                        Container( color: Color(colorgrid[8]),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          // fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Color(0x6e000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "${numbers[0]}",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 50,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),SizedBox(width: 30,),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "جميع الطلبات",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 28,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: InkWell(onTap: () {
                if(isconnect==1)
                {
                  selectordertype=100;
                  selectcoloer=8;
                  waitFinitState();

                }
              },
                child: Container(
                width: MediaQuery.of(context).size.width-30,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child:

                      ///***If you have exported images you must have to copy those images in assets/images directory.
                      // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6s8SUWJ9Vr681FKY0JlN1ve-CV13jYvEAZQ&usqp=CAU"),

                      Container( color: Color(colorgrid[8]),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        // fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Color(0x6e000000),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "${numbers[8]}",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 50,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),SizedBox(width: 30,),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "الشحنات المنجزة",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 28,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                          ),
              ),
            ),

            GridView(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2,
                mainAxisExtent:80,
              ),
              children: [
                InkWell(onTap: () {
                  print("20");
                  if(isconnect==1)
                  {
                    selectordertype=20;
                    selectcoloer=0;
                    waitFinitState();
                  }


                },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6s8SUWJ9Vr681FKY0JlN1ve-CV13jYvEAZQ&usqp=CAU"),

                        Container( color: Color(colorgrid[0]),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          // fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Color(0x6e000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                      ),
                         Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "${numbers[2]}",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 30,
                              color: Color(0xff000000),
                            ),
                          ),
                            Text(
                            "جاهز للنقل",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                            color: Color(0xff000000),
                            ),
                            ),

                            ],
                            ),
                                    ],
                  ),
                ),
                InkWell(onTap: () {





    if(isconnect==1)
    {
      selectcoloer=1;
      selectordertype=1;
      waitFinitState();

    }






                },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6s8SUWJ9Vr681FKY0JlN1ve-CV13jYvEAZQ&usqp=CAU"),

                        Container( color: Color(colorgrid[1]),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          // fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Color(0x6e000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                      ),
                        Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${numbers[1]}",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 30,
                        color: Color(0xff000000),
                      ),
                    ),
                  Text(
                  "طلبات الحديثة",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                    fontSize: 12,
                  color: Color(0xff000000),
                  ),
                  ),

                  ],
                  ),
                    ],
                  ),
                ),
                InkWell(onTap: () {
                  print("2");

                  if(isconnect==1)
                  {
                    selectcoloer=2;
                    selectordertype=2;
                    waitFinitState();

                  }
                },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6s8SUWJ9Vr681FKY0JlN1ve-CV13jYvEAZQ&usqp=CAU"),

                        Container( color: Color(colorgrid[2]),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          // fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Color(0x6e000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                        children: [

                          Text(
                            "${numbers[3]}",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 30,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            "الشحنات تم تأكيد استلامها",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(onTap: () {
                  if(isconnect==1)
                  {
                    selectordertype=20;
                    selectcoloer=3;
                    waitFinitState();

                  }
                },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6s8SUWJ9Vr681FKY0JlN1ve-CV13jYvEAZQ&usqp=CAU"),

                        Container( color: Color(colorgrid[3]),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          // fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Color(0x6e000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                        children: [

                          Text(
                            "${numbers[2]}",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 30,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            "الشحنات قيد تأكيد الاستلام",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(onTap: (){

                  if(isconnect==1)
                  {
                    selectordertype=4;
                    selectcoloer=4;
                    waitFinitState();
                  }


                },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6s8SUWJ9Vr681FKY0JlN1ve-CV13jYvEAZQ&usqp=CAU"),

                        Container( color: Color(colorgrid[4]),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          // fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Color(0x6e000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                        children: [

                          Text(
                            "${numbers[5]}",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 30,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            "الشحنات الناجحة ولم تحاسب",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(onTap: () {
                  if(isconnect==1)
                  {
                    selectordertype=3;
                    selectcoloer=5;
                    waitFinitState();
                  }
                },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6s8SUWJ9Vr681FKY0JlN1ve-CV13jYvEAZQ&usqp=CAU"),

                        Container( color: Color(colorgrid[5]),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          // fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Color(0x6e000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                        children: [

                          Text(
                            "${numbers[4]}",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 30,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            "الشحنات قيد التوصيل",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(onTap: () {

                  if(isconnect==1)
                  {
                    selectordertype=6;
                    selectcoloer=6;
                    waitFinitState();
                  }
                },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6s8SUWJ9Vr681FKY0JlN1ve-CV13jYvEAZQ&usqp=CAU"),

                        Container( color: Color(colorgrid[6]),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          // fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Color(0x6e000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                        children: [

                          Text(
                            "${numbers[7]}",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 30,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            "الشحنات الواصلة جزئيا",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(onTap: () {
                  if(isconnect==1)
                  {
                    selectordertype=5;
                    selectcoloer=7;
                    waitFinitState();
                  }
                },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child:

                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6s8SUWJ9Vr681FKY0JlN1ve-CV13jYvEAZQ&usqp=CAU"),

                        Container( color: Color(colorgrid[7]),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          // fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Color(0x6e000000),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
                        children: [

                          Text(
                            "${numbers[6]}",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 30,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            "الشحنات الراجعة ولم تستلم",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


              ],
            ),
            ],
        ),
      ),
    );
  }
}

