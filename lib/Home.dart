

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Contact_Us.dart';
import 'GridHome.dart';
import 'Invoice.dart';
import 'Loding.dart';
import 'Orders.dart';
import 'functionPHP.dart';
import 'global.dart';
import 'myaccount.dart';





class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomePageState();
}


class _HomePageState extends State<Home> {



  _HomePageState();




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
  String res='تم الاضافة ';


  List<Map<String, dynamic>> data=[];

  Future<void> waitSaveordder() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        context = context;
        return const Loading();
      },
    );
    print("saving");
    await Saveordder();
    await getLoginData2();
    await getDataorders("invoice");
    Navigator.pop(context);
    showDialog(
        context: context, builder: (_)=>AlertDialog(
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ) ,
        content:Text(res,textAlign: TextAlign.center,style: TextStyle(fontSize: 25))




    ));
    //await DBfilesinit();

  }


  Future<void> waitFinitState() async {
    await getLoginData2();
    await getDataorders("invoice");

   //await DBfilesinit();

  }

  void initState() {

    super.initState();
     getLoginData2();
if(firstopen==0)
    getLoginData(0);

    firstopen=0;
    print("info: $name $decryptusr $phone");
  //  fetchData("SELECT * FROM accounts",1);
  }


  DateTime selectedDate = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        setState(() {
          formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        });
      });
  }

  Future<int> Saveordder() async {




    //await conn.query('CREATE TABLE IF NOT EXISTS orders(id INTEGER PRIMARY KEY, name TEXT,phone TEXT,address TEXT,nameT TEXT,phoneT TEXT,addressT TEXT,state INTEGER)');
int order_number=2;
    if(dro1==0)
      order_number=1;









    String formattedDate = selectedDate.toLocal().toIso8601String();
    DateTime date = DateTime(0, 0, 0);
    String formattedDate2 = date.toLocal().toIso8601String();

  if(phoneTController.text!='' && phoneController.text!='' && SaleController.text!=''){
      String colums="insert into invoice(order_number,order_date,delivery_date,sender_name,sender_phone,recipient_name,recipient_phone,total_price,address,notes,username,status,baghdad_cities,province) values";
      try {


        int.parse(phoneController.text);
        int.parse(phoneTController.text);
        String formattedDate1 = DateFormat('yyyy-MM-dd').format(selectedDate);
        String formattedDate2 = DateFormat('yyyy-MM-dd').format(date);
        print("12345678           $decryptusr");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        username = prefs.getString('usernameH') ?? '';
        password = prefs.getString('passwordH') ?? '';

        decryptusr = cipher.xorDecode(username);
        decryptpas = cipher.xorDecode(password);

        String values="(${order_number},'$formattedDate1','$formattedDate2','${nameController.text}',${phoneController.text},'${nameTController.text}',${phoneTController.text},${int.parse(SaleController.text)},'${addressTController.text}','${notesTController.text}','$decryptusr',1,'${list2[dro2]}','${list[dro1]}')";
      String sqlCom="$colums $values";
       print(sqlCom);
    await  fetchData(sqlCom,0);
        nameTController.text='';
        addressTController.text='';
        notesTController.text='';
        phoneTController.text='';
}
      // await conn.query('insert into invoice(order_number,order_date,delivery_date,sender_name,sender_phone,recipient_name,recipient_phone,total_price,address,notes,username,status,baghdad_cities,province) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)', ['${order_number}',formattedDate,formattedDate2,'${nameController.text}','${phoneTController.text}','${nameTController.text}','${phoneTController.text}',int.parse(SaleController.text),"${addressTController.text}",'${notesTController.text}','$decryptusr',1,'','${list[dro1]}']);

    catch(e){
    print("452222222222222           $e");
    res='رقم الهاتف خطا ';
    }
}
  else
    res='رقم الهاتف او سعر غير موجود ';






   //print ("${list[dro1]}-${nameController.text}-${phoneController.text}-${SaleController.text}-${nameTController.text}-${phoneTController.text}-${addressTController.text}");

    return 1;















  }
  Future<int> getLoginData(int resp) async {
     isconnect=0;
     print(" ---------------------------+$firstopen");
setState(() {

});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('usernameH') ?? '';
    password = prefs.getString('passwordH') ?? '';


    userid =prefs.getString('useridH') ?? '';
    name = prefs.getString('nameH') ?? '';
    phone = prefs.getString('phoneH') ?? '';

     nameController.text = name;
     phoneController.text = phone;



      decryptusr = cipher.xorDecode(username);
      decryptpas = cipher.xorDecode(password);
     int x=1;
      if(resp==2)
       x= await Checklogin(decryptusr,decryptpas);

      if(x==0){
        Logout();
        isconnect=x;
      }
     else  if(x==1)
      {
       await waitFinitState();


      // await getDataorders("invoice",decryptusr);

/*
        String host = '192.254.237.211';

        var settings = new ConnectionSettings(
            host: '$host',
            port: 3306,
            user: 'sultaraq_zeopost',
            password: 'zeopost1984\$',
            db: 'sultaraq_zeopost'
        );

        var conn ;
        try {
          conn = await MySqlConnection.connect(settings);
        }
        catch(e){
          print(e);
          return 0;

        }

        result = await conn.query('SELECT * FROM  invoice WHERE username=$decryptusr;');
        getOrdersData( result);
        */


        // Use the retrieved username and password as needed


        if(resp==1)
          showDialog(
              context: context, builder: (_)=>AlertDialog(
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ) ,
              content:Text(res,textAlign: TextAlign.center,style: TextStyle(fontSize: 25))




          ));

        setState(() {
          isconnect=x;
          print("connect Ok0");
        });
      }
   else if(x==-1)
    {
      isconnect=x;
      res='انت غير متصل ';
      if(resp==1)
      showDialog(
          context: context, builder: (_)=>AlertDialog(
          shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ) ,
          content:Text(res,textAlign: TextAlign.center,style: TextStyle(fontSize: 25))




      ));

      Timer(Duration(milliseconds: 5000), () {

        getLoginData(0);
       // waitFinitState();
      });
      setState(() {

      });
      return 0;
    }




     Timer(Duration(seconds: 30), () {

       getLoginData(0);
     //  waitFinitState();
     });
     return 1;
     setState(() {

     });

  }






  void onItemTapped(int index) {
if(index==0){
  HController.animateToPage(0, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);

  setState(() {
    selectedIndex = index;
  });
  }
if(index==1 && isconnect==1){
  HController.animateToPage(1, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);
  setState(() {
    selectedIndex = index;
  });
}


if(index==2 ){
  HController.animateToPage(2, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);
  setState(() {
    selectedIndex = index;
  });
}
if(index==3 ){
  HController.animateToPage(4, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);
  setState(() {
    selectedIndex = index;
  });
}




  }


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(floatingActionButton: selectedIndex ==1?FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        child: Icon(Icons.arrow_back),
        onPressed: () {

          HController.animateToPage(0, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);

          setState(() {
            selectedIndex =0;
          });

          // Handle FAB press
        },
      ):SizedBox(),
        appBar: AppBar(backgroundColor: Colors.blueAccent,
            centerTitle: true,
            title: Text(selectedText),
          leading: isconnect==0 || isconnect==-1?
          isconnect==0?InkWell(onTap: (){

           getLoginData(0);
          // waitFinitState();
            },
            child: Container(
              child: Icon(
              Icons.access_time_filled,
              color: Color(0xff212435),
              size: 24,
                      ),
            ),
          ):InkWell(onTap: (){


           getLoginData(0);
          //  waitFinitState();
            },
            child: Container(
              child: Icon(
                Icons.check_box,
                color: Color(0xfff60505),
                size: 24,
              ),
            ),
          ):
          InkWell(onTap: (){

           getLoginData(0);
           //waitFinitState();
            },
            child: Container(
              child: Icon(
                Icons.check_box,
                color: Color(0xff3de30f),
                size: 24,
              ),
            ),
          )
          ,

        ),

        body: Center(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: HController,

            onPageChanged: (int page){
              //print("Current Page: " + page.toString());
              int previousPage = page;
              if(page != 0) previousPage--;
              else previousPage = 3;

              print("$page   $previousPage");
setState(() {

});
            },
          children: [
            GridHome(),



            Scaffold(
              backgroundColor: Colors.blueAccent,
              body: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [

                              Container(width: (MediaQuery.of(context).size.width)/1.8,
                                child: TextField(
                                  controller: TextEditingController(text: "$formattedDate"),
                                  obscureText: false,
                                  textAlign: TextAlign.center,
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

                                    hintText: ":تاريخ",
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xfff2f2f3),
                                    isDense: false,
                                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                    suffixIcon:
                                    InkWell(onTap: () {
                                      selectDate(context);



                                    },
                                        child: Icon(Icons.calendar_today, color: Color(0xff212435), size: 24)),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ":تاريخ",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 24,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: TextField(
                            controller: nameController,
                  obscureText: false,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              hintText: "اسم المرسل",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: Color(0xfff2f2f3),
                              isDense: false,
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                        TextField(
                          controller: phoneController,
                          obscureText: false,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                            ),
                            hintText: "رقم المرسل",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: Color(0xfff2f2f3),
                            isDense: false,
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          ),
                        ),
                        /*
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 30),
                          child: TextField(
                            controller: addressController,
                            obscureText: false,
                            textAlign: TextAlign.center,
                            maxLines: 5,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              hintText: "عنوان المرسل",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: Color(0xfff2f2f3),
                              isDense: false,
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),*/

                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "معلومات المستلم",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 24,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
                          child: TextField(
                            controller: nameTController,
                            obscureText: false,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              hintText: "اسم المستلم",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: Color(0xfff2f2f3),
                              isDense: false,
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                        TextField(
                          controller: phoneTController,
                          obscureText: false,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                            ),
                            hintText: "رقم المستلم",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: Color(0xfff2f2f3),
                            isDense: false,
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: TextField(
                            controller: SaleController,
                            obscureText: false,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              hintText: "السعر الكلي",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: Color(0xfff2f2f3),
                              isDense: false,
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
Padding(
  padding: EdgeInsets.fromLTRB(0, 25, 0, 16),
  child: Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [


      dro1==0?DropdownButton<String>(
        value: dropdownValue2,
        icon: const Icon(Icons.arrow_drop_down,color: Colors.cyan,),
        elevation: 16,
        style: const TextStyle(color: Colors.black ,fontSize: 20),
        underline: Container(
          height: 2,
          color: Colors.white,
        ),
        onChanged: (String? value) {

          setState(() {
            for (int i=0;i<list2.length;i++)
              if (list2[i]==value!)
                dro2=i;
            dropdownValue2= value!;
          });
          print('$dro2');
          setState(() {});
        },
        items: list2.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ):SizedBox(),
      SizedBox(width: 50,),
      DropdownButton<String>(
        value: dropdownValue1,
        icon: const Icon(Icons.arrow_drop_down,color: Colors.cyan,),
        elevation: 16,
        style: const TextStyle(color: Colors.black ,fontSize: 20),
        underline: Container(
          height: 2,
          color: Colors.white,
        ),
        onChanged: (String? value) {

          setState(() {
            for (int i=0;i<list.length;i++)
              if (list[i]==value!)
                dro1=i;
            dropdownValue1 = value!;
          });
          print('$dro1');
          setState(() {});
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),

    ],
  ),
),           TextField(
                          controller: addressTController,
                          obscureText: false,
                          textAlign: TextAlign.center,
                          maxLines:3,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                            ),
                            hintText: "عنوان المستلم",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 25,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: Color(0xfff2f2f3),
                            isDense: false,
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,bottom: 16),
                          child: TextField(
                            controller: notesTController,
                            obscureText: false,
                            textAlign: TextAlign.center,
                            maxLines:3,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide:
                                BorderSide(color: Color(0x00ffffff), width: 1),
                              ),
                              hintText: "ملاحظات",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 25,
                                color: Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: Color(0xfff2f2f3),
                              isDense: false,
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: MaterialButton(
                            onPressed: () {
                              if(isconnect==1){
                                waitSaveordder();


                             // getLoginData(1);
                              //waitFinitState();

                              }
                              else
                                {


                                }


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
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),





            Myaccount(),
            Orders(),
            Contact_Us(),



          ],
          ),
        ),
        endDrawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: Text("نظام التوصيل",style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  color: Color(0xff000000),
                ),textAlign: TextAlign.end),
              ),
              ListTile(
                title: const Text('طلباتي',textAlign: TextAlign.end,style: TextStyle(fontSize: 25)),
                trailing: Container(child: Icon(Icons.shopping_cart)),
                selected: selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  selectedText='طلباتي';
                  onItemTapped(0);

                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(

                title: const Text('طلب جديد',textAlign: TextAlign.end,style: TextStyle(fontSize: 25)),
                trailing: Container(child: Icon(Icons.add)),
                selected: selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                  selectedText='طلب جديد';
                  onItemTapped(1);

                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Text('راسلنا',textAlign: TextAlign.end,style: TextStyle(fontSize: 25)),
                trailing: Container(child: Icon(Icons.shopping_cart)),
                selected: selectedIndex == 3,
                onTap: () {
                  // Update the state of the app
                  selectedText='راسلنا';
                  onItemTapped(3);

                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('حسابي',textAlign: TextAlign.end,style: TextStyle(fontSize: 25)),
                trailing: Container(child: Icon(Icons.account_box)),
                selected: selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                  selectedText='حسابي';
                  onItemTapped(2);

                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
  }


}

