

import 'dart:async';


import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mysql1/mysql1.dart';
import 'package:url_launcher/url_launcher.dart';


import 'Loding.dart';
import 'functionPHP.dart';
import 'global.dart';






var result2;

class Orders extends StatefulWidget {


  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => OrdersHomePage( );
}


class OrdersHomePage extends State<Orders> {



  OrdersHomePage();








  Future<void> launchUrlW(String phonenumber) async {
String url_ok="https://api.whatsapp.com/send?phone=964${phonenumber}";
final Uri _url = Uri.parse(url_ok);
        if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<int> UpdateMRow(String table ,int status1,int status2) async {
    updating=true;
    updatingW=true;
    updatingC=0;
    setState(() {

    });




      //print(" $decryptusr         ${data[p]['id']}       ");
      //await conn.query('UPDATE $table SET status = $status1 WHERE id = ${data[p]['id']};');
      await fetchData('UPDATE $table SET status = $status2 WHERE username="$decryptusr" AND status = $status1',0);
      setState(() {
  
});

  




    updating=false;
  
    return 0;


  }

  Future<void> waitFinitState() async {
   await getLoginData2();

    invoiceview=[];




   if(dataH!=null)
     await  getOrdersData3();

    setState(() {

    });


  }

  void initState() {

    super.initState();

 //   waitFinitState();










  }










  Future<void> Delete() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        context = context;
        return const Loading();
      },
    );
 await DeleteRow("invoice",int.parse(invoiceview[0]['id']));
 await getLoginData2();
 await getDataorders("invoice");




    await getOrdersData3();



    Navigator.pop(context);

    await OController.animateToPage(0, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);


setState(() {
  selectedIndex = 0;
});


  }
  Future<void> UpdateAR(int stateC,int stateCC) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        context = context;
        return const Loading();
      },
    );
      await UpdateMRow("invoice",stateC, stateCC);


    await getLoginData2();
    await getDataorders("invoice");




    await getOrdersData3();




      updatingW=false;
      setState(() {

      });
    Navigator.pop(context);
    await HController.animateToPage(0, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);





  }

  Future<void> UpdateR(int stateC) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        context = context;
        return const Loading();
      },
    );

  await  UpdateRow("invoice","${invoiceview[0]['id']}",stateC);

    await getLoginData2();
    await getDataorders("invoice");




    await getOrdersData3();




    Navigator.pop(context);
     OController.animateToPage(0, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);



    setState(() {
      selectedIndex = 0;
    });


  }



  @override
  Widget build(BuildContext context) {

    return
      PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: OController,

        onPageChanged: (int page){
          //print("Current Page: " + page.toString());
          int previousPage = page;
          if(page != 0) previousPage--;
          else previousPage = 3;
setState(() {

});
          print("$page   $previousPage");

        },
        children: [
          Scaffold(floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              selectordertype==1 || selectordertype==20? FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                child: !updating?Center(child: !updatingW? Icon(Icons.verified_rounded):Text("انتظر"),):Text("${data.length}"),
                onPressed: () {
                  print(selectordertype);
                  if(selectordertype==1)
                  UpdateAR(1,20);
                  else if(selectordertype==20)
                    UpdateAR(20,1);

                  // Handle FAB press
                },
              ):SizedBox(width: 16.0),
              SizedBox(width: 16.0),
              FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,

                child: Icon(Icons.arrow_back),
                onPressed: () {

                  HController.animateToPage(0, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);
                  setState(() {
                    selectedIndex = 0;
                  });

                  // Handle FAB press
                },
              ),
            ],
          ),

            backgroundColor: Color(0xffffffff),
            body: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [

                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: TextField(
                      onSubmitted: (controller) {
                        waitFinitState();
                      },
                      onChanged:(controller) {
                        waitFinitState();
                      },
                      controller: findController,
                      obscureText: false,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        hintText: "رقم الطلب",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                        filled: true,
                        fillColor: Color(color[selectcoloer]),
                        isDense: false,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        suffixIcon:
                        InkWell(onTap:() {


                          print("jokishere:${findController.text}");
                          waitFinitState();


                        }, child: Icon(Icons.search, color: Color(0xff212435), size: 24)),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(0),
                      shrinkWrap: false,
                      physics: ScrollPhysics(),
                      children: [

                        Container(
                          height:  MediaQuery.of(context).size.height-200
                          ,width: double.maxFinite,

                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder:(context,i) {

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                              InkWell(onTap: (){
                                //print('#########1#########');
                                //print('${myArray[i]} $i');
                                //print('#########2#########');



                              },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:  Color(color[selectcoloer]),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),

                                      //bottomRight: Radius.zero,

                                    ),
                                  ),



                                  child: ListTile(
                                    title: InkWell(
                                      onTap: (){



                                        invoiceview.insert(0,{
                                          'id': '${data[i]['id']}',
                                          'order_number': '${data[i]['order_number']}',
                                          'order_date': '${data[i]["order_date"]}',
                                          'delivery_date': '${data[i]['delivery_date']}',
                                          'sender_name': '${data[i]['sender_name']}',
                                          'sender_phone': '${data[i]['sender_phone']}',
                                          'recipient_name': '${data[i]['recipient_name']}',
                                          'recipient_phone': '${data[i]['recipient_phone']}',
                                          'total_price': '${data[i]['total_price']}',
                                          'address': '${data[i]['address']}',
                                          'notes': '${data[i]['notes']}',
                                          'username': '${data[i]['username']}',
                                          'status': '${data[i]['status']}',
                                          'baghdad_cities': '${data[i]['baghdad_cities']}',
                                          'province': '${data[i]['province']}'

                                        });
                                        setState(() {

                                        });


                                          OController.animateToPage(1, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);




                                        if(false)
                                        showDialog(
                                            context: context, builder: (_)=>AlertDialog(
                                            shape:RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20)
                                            ) ,
                                            content:Container(height: 250,
                                              child:Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [

                                                    Text("اسم المرسل:${data[i]["sender_name"]}",textAlign: TextAlign.end,style: TextStyle(fontSize: 14)),
                                                    Text("رقم المرسل:${data[i]["sender_phone"]}",textAlign: TextAlign.end,style: TextStyle(fontSize: 14)),
                                                    Text("عنوان المرسل:${data[i]["address"]}",textAlign: TextAlign.end,style: TextStyle(fontSize: 14)),

                                                    Text("اسم المستلم:${data[i]["recipient_name"]}",textAlign: TextAlign.end,style: TextStyle(fontSize: 14)),
                                                    Text("رقم المستلم:${data[i]["recipient_phone"]}",textAlign: TextAlign.end,style: TextStyle(fontSize: 14)),
                                                    Text("عنوان المستلم:${data[i]["address"]}",textAlign: TextAlign.end,style: TextStyle(fontSize: 14)),
                                                    Text("وقت الطلب:${data[i]["order_date"]}",textAlign: TextAlign.end,style: TextStyle(fontSize: 14)),


                                                  ],
                                                ),

                                            )




                                        ));

                                      },
                                      child:Container(
                                        child:SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${data[i]["id"]}",textAlign: TextAlign.start,style: TextStyle(fontSize: 25)),
                                              SizedBox(width: 60,),
                                              Container(
                                                decoration: BoxDecoration(
                                                color:  Color(0x20FFFFFF),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10.0),
                                                  topRight: Radius.circular(10.0),
                                                  bottomLeft: Radius.circular(10.0),
                                                  bottomRight: Radius.circular(10.0),

                                                  //bottomRight: Radius.zero,

                                                ),
                                              ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Column(

                                                  children: [
                                                    Text("${data[i]["recipient_name"]}",textAlign: TextAlign.start,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,
                                                      fontStyle: FontStyle.normal,) ),
                                                    Text("محافظة:${data[i]["province"]}",textAlign: TextAlign.end,style: TextStyle(fontSize: 14) ),
                                                   // Text("عنوان:${data[i]["address"]}",textAlign: TextAlign.end,style: TextStyle(fontSize: 14) ),
                                                    Text('تاريخ الطلب:${data[i]["order_date"]}'),

                                                  ],
                                                                                              ),
                                                ),
                                              ),




                                            ],



                                          ),
                                        ),


                                      )
                                    ),
          /*
                                    subtitle:Container(height: 25,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),

                                          //bottomRight: Radius.zero,

                                        ),
                                      ),
                                      child: Text('iiii',style: TextStyle(color: Colors.white),),
                                    ),

                                    */

                                    // leading: Row ( children: [ Text('${data[i]["name"]}') , SizedBox(width: 20),ElevatedButton(onPressed: (){deleteData(data[i]["id"]);}, child:Text('حذف') )]),
                                    // trailing:Text(data[i]["EX"]),


                                  ),
                                ),
                              ),

                            );



                          },


                        ),
                      ),],
                    ),
                  ),



                ],
              ),

            ),
          ),
        Scaffold( floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          child: Icon(Icons.arrow_back),
          onPressed: () {

            OController.animateToPage(0, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);
            setState(() {
              selectedIndex = 1;
            });

            // Handle FAB press
          },
        ),
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
                              image: AssetImage("Files/Photo/logo.jpeg"),
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
                              !invoiceview.isEmpty?  BarcodeWidget(color: Colors.black,
                                barcode: Barcode.code128(), // Barcode type and settings
                                data: '${invoiceview[0]['id']}', // Content
                                width: 120,
                                height: 60,
                              ):SizedBox(),
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
                              !invoiceview.isEmpty?  Text(
                                '${invoiceview[0]['order_date']}',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ):SizedBox(),
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
                                          Flexible(
                                            child: Container(
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
                                            child: !invoiceview.isEmpty? Text(
                                              '${invoiceview[0]['recipient_name']}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14,
                                                color: Color(0xffb68b8b),
                                              ),
                                            ):SizedBox(),
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
                                          Flexible(
                                            child: Container(
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
                                            child:!invoiceview.isEmpty?  Text(
                                              '${invoiceview[0]['sender_name']}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14,
                                                color: Color(0xffb58b8b),
                                              ),
                                            ):SizedBox(),
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
                                          Flexible(
                                            child: Container(
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
                                          ),
                                          InkWell(onTap: () {
                                            launchUrlW('${invoiceview[0]['recipient_phone']}');
                                          },
                                            child: Container(
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
                                              child: !invoiceview.isEmpty? Text(
                                                '${invoiceview[0]['recipient_phone']}',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 14,
                                                  color: Color(0xffb68c8c),
                                                ),
                                              ):SizedBox(),
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
                                          Flexible(
                                            child: Container(
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
                                          ),
                                          InkWell(onTap: () {
                                            launchUrlW('${invoiceview[0]['sender_phone']}');
                                          },
                                            child: Container(
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
                                              child: !invoiceview.isEmpty? Text(
                                                '${invoiceview[0]['sender_phone']}',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 14,
                                                  color: Color(0xffb68b8b),
                                                ),
                                              ):SizedBox(),
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
                                          Flexible(
                                            child: Container(
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
                                            child: !invoiceview.isEmpty? Text(
                                              '${invoiceview[0]['address']}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14,
                                                color: Color(0xffb58d8d),
                                              ),
                                            ):SizedBox(),
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
                                          Flexible(
                                            child: Container(
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
                                            child: !invoiceview.isEmpty? Text(
                                              '${invoiceview[0]['total_price']}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14,
                                                color: Color(0xffbc9393),
                                              ),
                                            ):SizedBox(),
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
                                    Flexible(
                                      child: Container(
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
                                      child: !invoiceview.isEmpty? Text(
                                        '${invoiceview[0]['notes']}',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xffbc9393),
                                        ),
                                      ):SizedBox(),
                                    ),
                                  ],
                                ),
                              ),

                              !invoiceview.isEmpty && invoiceview[0]['status']=="1"? Padding(
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
                                          UpdateR(20);

                                        },
                                        color: Color(0xffffd261),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(22.0),
                                        ),
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                          "ترحيل الطلب",
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


                                          Delete();


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
                              ):SizedBox(),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }
}

