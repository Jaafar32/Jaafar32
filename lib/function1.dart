
import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:http/http.dart' as http;

import 'global.dart';



Future<void> fetchData(String sqlC,int resType) async {
  final url = Uri.parse('http://$host/sql2.php?functionName=fetchData&sql=$sqlC');


  if(resType==1){
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON

      dataH = List<Map<String, dynamic>>.from(json.decode(response.body));

  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load data');
  }

  print("php: ${dataH.length}      ${dataH[0]}");

  }

  else if(resType==0) {


    await http.get(url);
  }
}













Future<void> DBfilesinit() async {



 db = await openDatabase(path, version: 1);

 //await db.rawQuery('DROP TABLE IF EXISTS invoice;');

 await db.execute('CREATE TABLE IF NOT EXISTS invoice (id INTEGER , order_number INTEGER,order_date DATE,delivery_date DATE,sender_name TEXT ,sender_phone INTEGER ,recipient_name TEXT,recipient_phone INTEGER,total_price INTEGER,address TEXT ,notes TEXT,username TEXT ,status INTEGER ,baghdad_cities TEXT ,province TEXT )');
 int p=0;
 var check = await db.rawQuery('SELECT * FROM invoice;');
while(check.length!=0){
   check = await db.rawQuery('SELECT * FROM invoice;');
   await db.rawQuery('DELETE FROM invoice;');
}
// await db.rawQuery('DELETE FROM invoice;');

for (var row in result){
   String order_date = row['order_date'].toLocal().toIso8601String();
   String delivery_date = row['delivery_date'].toLocal().toIso8601String();
   String order_date1 = "";
   String delivery_date1 = "";
   for(int c=0;c<=9;c++)
     {
       order_date1 = "$order_date1${order_date[c]}";
        delivery_date1 = "$delivery_date1${delivery_date[c]}";

     }
   await db.insert('invoice', {
     'id': row['id'],
     'order_number': row['order_number'],
     'order_date': order_date1,
     'delivery_date': delivery_date1,
     'sender_name': '${row['sender_name']}',
     'sender_phone': row['sender_phone'],
     'recipient_name': '${row['recipient_name']}',
     'recipient_phone': row['recipient_phone'],
     'total_price': '${row['total_price']}',
     'address': '${row['address']}',
     'notes': '${row['notes']}',
     'username': '${row['username']}',
     'status': row['status'],
     'baghdad_cities': '${row['baghdad_cities']}',
     'province': '${row['province']}'

   });



   p++;






 //  String insertStatement = 'insert into invoice(id,order_number,order_date,delivery_date,sender_name,sender_phone,recipient_name,recipient_phone,total_price,address,notes,username,status,baghdad_cities,province) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';

   // Execute the insert statement
   //await db.execute(insertStatement, [row['id'],row['order_number'],order_date,delivery_date,row['sender_name'],row['sender_phone'],row['recipient_name'],row['recipient_phone'],row['total_price'],row['address'],row['notes'],row['username'],row['status'],row['baghdad_cities'],row['province']]);





 }
print("---------------------$p");

// print(" ${tables.length  } ppppp$p ${tables[0]}   ");

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
Future<int> getLoginData2() async {



  SharedPreferences prefs = await SharedPreferences.getInstance();
  username = prefs.getString('usernameH') ?? '';
  password = prefs.getString('passwordH') ?? '';


  userid =prefs.getString('useridH') ?? '';
  name = prefs.getString('nameH') ?? '';
  phone = prefs.getString('phoneH') ?? '';
  address = prefs.getString('addressH') ?? '';


  decryptusr = cipher.xorDecode(username);
  decryptpas = cipher.xorDecode(password);





  usernameD="اسم الحساب:$decryptusr";

  nameD="الاسم:$name";
  phoneD="رقم:$phone";
  addressD="عنوان:$address";
  // Use the retrieved username and password as needed

  return 1;
}



Future<int> Checklogin(String username ,String password) async {

print("start check user:$username");



try {
  conn = await MySqlConnection.connect(settings);
}
catch(e){
 print(e);
  return -1;

}
// var results = await conn.query("INSERT INTO `users` (`id`, `userid`, `username`, `password`) VALUES ('3', '3', 'hassan', 'Ha123456789');");
var result = await conn.query('SELECT * FROM accounts WHERE username="$username";');
bool okuser=false;



  for (var row in result){

    print("{id: ${row[0]},accountname: ${row[1]},username: ${row[2]},password: ${row[3]}}");
    if(row[2]==username && row[3]==password){
      okuser=true;

    }
  }
  if(okuser)
  return 1;

  else
    return 0;


}

Future<int> UpdateRow(String table ,String id1,int status1) async {


  try {
    conn = await MySqlConnection.connect(settings);
  }
  catch(e){


    return -1;

  }



  await conn.query('UPDATE $table SET status = $status1 WHERE id = $id1;');





  return 0;


}


Future<int> DeleteRow(String table ,int id1) async {


  try {
    conn = await MySqlConnection.connect(settings);
  }
  catch(e){


    return -1;

  }


await conn.query('DELETE FROM $table WHERE id = $id1;');





    return 0;


}
Future<int> getCounts() async {
  numbers = [0, 0, 0, 0, 0, 0, 0, 0, 0];


  for (var row in result){
for(int p=1;p<StatusN.length-1;p++)

    if(row['status']==StatusN[p])
      numbers[p]++;
 if(row['status']==7 || row['status']==8 || row['status']==9 || row['status']==90)
   numbers[8]++;
      numbers[0]++;

  }



 // print("$selectordertype     0     000000000000000");
 // print("result $o");

  //numbers.add(o);
print("$numbers");

  return 1;

}


Future<int> getDataorders(String table ) async {

  print("$selectordertype          $decryptusr");
  try {
    conn = await MySqlConnection.connect(settings);
  }
  catch(e){
    print(e);
    return 0;

  }







  print("$selectordertype  $decryptusr   1     11111111111111111");

    result = await conn.query('SELECT * FROM  $table WHERE username="$decryptusr" ;');
 // fetchData('SELECT * FROM  $table WHERE username="$decryptusr" ',1);


  int o=0;
  for (var row in result){o++;}



 // print("$selectordertype     0     000000000000000");
 // print("result $o");



  await getCounts();
 await DBfilesinit();
  return 1;

}

Future<int> checkconnect() async {

  try {
    conn = await MySqlConnection.connect(settings);
  }
  catch(e){


    return -1;

  }

print ("ok");
  return 1;

}


Future<int> getOrdersData3() async {
  data =[];
  db = await openDatabase(path, version: 1);
  if(findController.text==''){
  if(selectordertype==0)
    data = await db.rawQuery('SELECT * FROM invoice;');
  else if(selectordertype==100)
    data = await db.rawQuery('SELECT * FROM invoice WHERE  status=7 OR status=8 OR status=9 OR status=90;');
 else
    data = await db.rawQuery('SELECT * FROM invoice WHERE  status=$selectordertype ;');
 }
  else
  {
    if(selectordertype==0)
      data = await db.rawQuery('SELECT * FROM invoice WHERE id=${int.parse(findController.text)} ;');
    else if(selectordertype==100)
      data = await db.rawQuery('SELECT * FROM invoice WHERE id=${int.parse(findController.text)} AND status=7 OR status=8 OR status=9 OR status=90;');
    else
      data = await db.rawQuery('SELECT * FROM invoice WHERE id=${int.parse(findController.text)} AND status=$selectordertype ;');
  }

  // if(row['status']==selectordertype)
   // if(row['status']==7 || row['status']==8 || row['status']==9 || row['status']==90)
  print(data.length);

return 1;
}



Future<int> getOrdersData() async {
  data =[];


  int i=0;
  if(result!=null)
    for (var row in result){
if(selectordertype==0)
{
      //  print("{id: ${row[0]},userid: ${row[1]},name: ${row[2]},phone: ${row[3]},address: ${row[4]},nameT: ${row[5]} ,phoneT: ${row[6]} ,addressT: ${row[7]} ,addressTG :${row[8]},state :${row[9]}}");
      if(findController.text==''){
        if(SelectI>=0)

        {
          //result = await conn.query('SELECT * FROM orders WHERE state=$state AND userid = $userid;');

          if("${row[12]}"=="$SelectI"  ){

            DateTime dateColumn = row['order_date'];
            String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

            data.insert(i,{
              'id': '${row['id']}',
              'order_number': '${row['order_number']}',
              'order_date': '${formattedDate}',
              'delivery_date': '${row['delivery_date']}',
              'sender_name': '${row['sender_name']}',
              'sender_phone': '${row['sender_phone']}',
              'recipient_name': '${row['recipient_name']}',
              'recipient_phone': '${row['recipient_phone']}',
              'total_price': '${row['total_price']}',
              'address': '${row['address']}',
              'notes': '${row['notes']}',
              'username': '${row['username']}',
              'status': '${row['status']}',
              'baghdad_cities': '${row['baghdad_cities']}',
              'province': '${row['province']}'

            });

            i++;


          }
        }
        else

        {
          //  result = await conn.query('SELECT * FROM orders WHERE userid = $userid ;');
          {
            DateTime dateColumn = row['order_date'];
            String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

            data.insert(i,{
              'id': '${row['id']}',
              'order_number': '${row['order_number']}',
              'order_date': '${formattedDate}',
              'delivery_date': '${row['delivery_date']}',
              'sender_name': '${row['sender_name']}',
              'sender_phone': '${row['sender_phone']}',
              'recipient_name': '${row['recipient_name']}',
              'recipient_phone': '${row['recipient_phone']}',
              'total_price': '${row['total_price']}',
              'address': '${row['address']}',
              'notes': '${row['notes']}',
              'username': '${row['username']}',
              'status': '${row['status']}',
              'baghdad_cities': '${row['baghdad_cities']}',
              'province': '${row['province']}'

            });

            i++;


          }
        }
      }else if(int.parse(findController.text)>=0)
      {
        if(SelectI>=0)
        {
          // result = await conn.query('SELECT * FROM orders WHERE state=$state AND userid = $userid AND id = ${int.parse(findController.text)} ;');

          if("${row[12]}"=="$SelectI"   && "${row[0]}"=="${int.parse(findController.text)}"){
            DateTime dateColumn = row['order_date'];
            String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

            data.insert(i,{
              'id': '${row['id']}',
              'order_number': '${row['order_number']}',
              'order_date': '${formattedDate}',
              'delivery_date': '${row['delivery_date']}',
              'sender_name': '${row['sender_name']}',
              'sender_phone': '${row['sender_phone']}',
              'recipient_name': '${row['recipient_name']}',
              'recipient_phone': '${row['recipient_phone']}',
              'total_price': '${row['total_price']}',
              'address': '${row['address']}',
              'notes': '${row['notes']}',
              'username': '${row['username']}',
              'status': '${row['status']}',
              'baghdad_cities': '${row['baghdad_cities']}',
              'province': '${row['province']}'

            });
            i++;


          }
        }

        else

        {
          //result = await conn.query('SELECT * FROM orders WHERE userid = $userid AND id = ${int.parse(findController.text)};');

          if( "${row[0]}"=="${int.parse(findController.text)}"){
            DateTime dateColumn = row['order_date'];
            String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

            data.insert(i,{
              'id': '${row['id']}',
              'order_number': '${row['order_number']}',
              'order_date': '${formattedDate}',
              'delivery_date': '${row['delivery_date']}',
              'sender_name': '${row['sender_name']}',
              'sender_phone': '${row['sender_phone']}',
              'recipient_name': '${row['recipient_name']}',
              'recipient_phone': '${row['recipient_phone']}',
              'total_price': '${row['total_price']}',
              'address': '${row['address']}',
              'notes': '${row['notes']}',
              'username': '${row['username']}',
              'status': '${row['status']}',
              'baghdad_cities': '${row['baghdad_cities']}',
              'province': '${row['province']}'

            });
            i++;


          }
        }
      }

}




else if(selectordertype==100)
  if(row['status']==7 || row['status']==8 || row['status']==9 || row['status']==90)
  {
    //  print("{id: ${row[0]},userid: ${row[1]},name: ${row[2]},phone: ${row[3]},address: ${row[4]},nameT: ${row[5]} ,phoneT: ${row[6]} ,addressT: ${row[7]} ,addressTG :${row[8]},state :${row[9]}}");
    if(findController.text==''){
      if(SelectI>=0)

      {
        //result = await conn.query('SELECT * FROM orders WHERE state=$state AND userid = $userid;');

        if("${row[12]}"=="$SelectI"  ){

          DateTime dateColumn = row['order_date'];
          String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

          data.insert(i,{
            'id': '${row['id']}',
            'order_number': '${row['order_number']}',
            'order_date': '${formattedDate}',
            'delivery_date': '${row['delivery_date']}',
            'sender_name': '${row['sender_name']}',
            'sender_phone': '${row['sender_phone']}',
            'recipient_name': '${row['recipient_name']}',
            'recipient_phone': '${row['recipient_phone']}',
            'total_price': '${row['total_price']}',
            'address': '${row['address']}',
            'notes': '${row['notes']}',
            'username': '${row['username']}',
            'status': '${row['status']}',
            'baghdad_cities': '${row['baghdad_cities']}',
            'province': '${row['province']}'

          });

          i++;


        }
      }
      else

      {
        //  result = await conn.query('SELECT * FROM orders WHERE userid = $userid ;');
        {
          DateTime dateColumn = row['order_date'];
          String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

          data.insert(i,{
            'id': '${row['id']}',
            'order_number': '${row['order_number']}',
            'order_date': '${formattedDate}',
            'delivery_date': '${row['delivery_date']}',
            'sender_name': '${row['sender_name']}',
            'sender_phone': '${row['sender_phone']}',
            'recipient_name': '${row['recipient_name']}',
            'recipient_phone': '${row['recipient_phone']}',
            'total_price': '${row['total_price']}',
            'address': '${row['address']}',
            'notes': '${row['notes']}',
            'username': '${row['username']}',
            'status': '${row['status']}',
            'baghdad_cities': '${row['baghdad_cities']}',
            'province': '${row['province']}'

          });

          i++;


        }
      }
    }else if(int.parse(findController.text)>=0)
    {
      if(SelectI>=0)
      {
        // result = await conn.query('SELECT * FROM orders WHERE state=$state AND userid = $userid AND id = ${int.parse(findController.text)} ;');

        if("${row[12]}"=="$SelectI"   && "${row[0]}"=="${int.parse(findController.text)}"){
          DateTime dateColumn = row['order_date'];
          String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

          data.insert(i,{
            'id': '${row['id']}',
            'order_number': '${row['order_number']}',
            'order_date': '${formattedDate}',
            'delivery_date': '${row['delivery_date']}',
            'sender_name': '${row['sender_name']}',
            'sender_phone': '${row['sender_phone']}',
            'recipient_name': '${row['recipient_name']}',
            'recipient_phone': '${row['recipient_phone']}',
            'total_price': '${row['total_price']}',
            'address': '${row['address']}',
            'notes': '${row['notes']}',
            'username': '${row['username']}',
            'status': '${row['status']}',
            'baghdad_cities': '${row['baghdad_cities']}',
            'province': '${row['province']}'

          });
          i++;


        }
      }

      else

      {
        //result = await conn.query('SELECT * FROM orders WHERE userid = $userid AND id = ${int.parse(findController.text)};');

        if( "${row[0]}"=="${int.parse(findController.text)}"){
          DateTime dateColumn = row['order_date'];
          String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

          data.insert(i,{
            'id': '${row['id']}',
            'order_number': '${row['order_number']}',
            'order_date': '${formattedDate}',
            'delivery_date': '${row['delivery_date']}',
            'sender_name': '${row['sender_name']}',
            'sender_phone': '${row['sender_phone']}',
            'recipient_name': '${row['recipient_name']}',
            'recipient_phone': '${row['recipient_phone']}',
            'total_price': '${row['total_price']}',
            'address': '${row['address']}',
            'notes': '${row['notes']}',
            'username': '${row['username']}',
            'status': '${row['status']}',
            'baghdad_cities': '${row['baghdad_cities']}',
            'province': '${row['province']}'

          });
          i++;


        }
      }
    }

  }




    if(row['status']==selectordertype)
    {
      //  print("{id: ${row[0]},userid: ${row[1]},name: ${row[2]},phone: ${row[3]},address: ${row[4]},nameT: ${row[5]} ,phoneT: ${row[6]} ,addressT: ${row[7]} ,addressTG :${row[8]},state :${row[9]}}");
      if(findController.text==''){
        if(SelectI>=0)

        {
          //result = await conn.query('SELECT * FROM orders WHERE state=$state AND userid = $userid;');

          if("${row[12]}"=="$SelectI"  ){

            DateTime dateColumn = row['order_date'];
            String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

            data.insert(i,{
              'id': '${row['id']}',
              'order_number': '${row['order_number']}',
              'order_date': '${formattedDate}',
              'delivery_date': '${row['delivery_date']}',
              'sender_name': '${row['sender_name']}',
              'sender_phone': '${row['sender_phone']}',
              'recipient_name': '${row['recipient_name']}',
              'recipient_phone': '${row['recipient_phone']}',
              'total_price': '${row['total_price']}',
              'address': '${row['address']}',
              'notes': '${row['notes']}',
              'username': '${row['username']}',
              'status': '${row['status']}',
              'baghdad_cities': '${row['baghdad_cities']}',
              'province': '${row['province']}'

            });

            i++;


          }
        }
        else

        {
          //  result = await conn.query('SELECT * FROM orders WHERE userid = $userid ;');
          {
            DateTime dateColumn = row['order_date'];
            String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

            data.insert(i,{
              'id': '${row['id']}',
              'order_number': '${row['order_number']}',
              'order_date': '${formattedDate}',
              'delivery_date': '${row['delivery_date']}',
              'sender_name': '${row['sender_name']}',
              'sender_phone': '${row['sender_phone']}',
              'recipient_name': '${row['recipient_name']}',
              'recipient_phone': '${row['recipient_phone']}',
              'total_price': '${row['total_price']}',
              'address': '${row['address']}',
              'notes': '${row['notes']}',
              'username': '${row['username']}',
              'status': '${row['status']}',
              'baghdad_cities': '${row['baghdad_cities']}',
              'province': '${row['province']}'

            });

            i++;


          }
        }
      }else if(int.parse(findController.text)>=0)
      {
        if(SelectI>=0)
        {
          // result = await conn.query('SELECT * FROM orders WHERE state=$state AND userid = $userid AND id = ${int.parse(findController.text)} ;');

          if("${row[12]}"=="$SelectI"   && "${row[0]}"=="${int.parse(findController.text)}"){
            DateTime dateColumn = row['order_date'];
            String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

            data.insert(i,{
              'id': '${row['id']}',
              'order_number': '${row['order_number']}',
              'order_date': '${formattedDate}',
              'delivery_date': '${row['delivery_date']}',
              'sender_name': '${row['sender_name']}',
              'sender_phone': '${row['sender_phone']}',
              'recipient_name': '${row['recipient_name']}',
              'recipient_phone': '${row['recipient_phone']}',
              'total_price': '${row['total_price']}',
              'address': '${row['address']}',
              'notes': '${row['notes']}',
              'username': '${row['username']}',
              'status': '${row['status']}',
              'baghdad_cities': '${row['baghdad_cities']}',
              'province': '${row['province']}'

            });
            i++;


          }
        }

        else

        {
          //result = await conn.query('SELECT * FROM orders WHERE userid = $userid AND id = ${int.parse(findController.text)};');

          if( "${row[0]}"=="${int.parse(findController.text)}"){
            DateTime dateColumn = row['order_date'];
            String formattedDate = DateFormat('yyyy-MM-dd').format(dateColumn);

            data.insert(i,{
              'id': '${row['id']}',
              'order_number': '${row['order_number']}',
              'order_date': '${formattedDate}',
              'delivery_date': '${row['delivery_date']}',
              'sender_name': '${row['sender_name']}',
              'sender_phone': '${row['sender_phone']}',
              'recipient_name': '${row['recipient_name']}',
              'recipient_phone': '${row['recipient_phone']}',
              'total_price': '${row['total_price']}',
              'address': '${row['address']}',
              'notes': '${row['notes']}',
              'username': '${row['username']}',
              'status': '${row['status']}',
              'baghdad_cities': '${row['baghdad_cities']}',
              'province': '${row['province']}'

            });
            i++;


          }
        }
      }

    }






    }



  return 1;

}