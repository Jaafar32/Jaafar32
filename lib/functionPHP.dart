
import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:password_hash_plus/password_hash_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:http/http.dart' as http;

import 'global.dart';



Future<void> fetchData(String sqlC,int resType) async {
  print("start php file ");
 await checkInternetConnection();

  final url = Uri.parse('${host}${sqlC}');
  print("resType:$resType   $url");
  var response = await http.get(url);


  if(resType==1){

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON

      dataH =await List<Map<String, dynamic>>.from(json.decode(response.body));

  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load data');
  }

  print("php: ${dataH.length}      ");

  }


}


Future<void > checkInternetConnection() async {
  // Replace "google.iq" with the actual URL you want to test
  String url = "$host";

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      isconnect=1;
      print('Connected successfully to $url');
    } else {isconnect=0;

      print('Failed to connect to $url. Status code: ${response.statusCode}');
    }
  } catch (e) {isconnect=0;

    print('Error connecting to $url: $e');
  }
}




Future<String> hashPassword(String password) async {
  final String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
  // Print the hashed password
  print('Original Password: $password');
  print('Hashed Password: $hashed');

  return hashed;
}


Future<bool> checkPassword(String hashed,String password) async {
  hashPassword(password);
  print('Password: $password:$hashed');
   checkpass = BCrypt.checkpw(password, hashed);

  print('checkPassword: $checkpass');
  return checkpass;
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

for (int v=0;v<dataH.length;v++){


   String order_date = dataH[v]['order_date'];
   String delivery_date = dataH[v]['delivery_date'];
   //print (order_date);
   String order_date1 = "";
   String delivery_date1 = "";
   for(int c=0;c<=9;c++)
     {
       order_date1 = "$order_date1${order_date[c]}";
        delivery_date1 = "$delivery_date1${delivery_date[c]}";

     }
   await db.insert('invoice', {
     'id': dataH[v]['id'],
     'order_number': dataH[v]['order_number'],
     'order_date': order_date1,
     'delivery_date': delivery_date1,
     'sender_name': '${dataH[v]['sender_name']}',
     'sender_phone': dataH[v]['sender_phone'],
     'recipient_name': '${dataH[v]['recipient_name']}',
     'recipient_phone': dataH[v]['recipient_phone'],
     'total_price': '${dataH[v]['total_price']}',
     'address': '${dataH[v]['address']}',
     'notes': '${dataH[v]['notes']}',
     'username': '${dataH[v]['username']}',
     'status': dataH[v]['status'],
     'baghdad_cities': '${dataH[v]['baghdad_cities']}',
     'province': '${dataH[v]['province']}'

   });



   p++;






 //  String insertStatement = 'insert into invoice(id,order_number,order_date,delivery_date,sender_name,sender_phone,recipient_name,recipient_phone,total_price,address,notes,username,status,baghdad_cities,province) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';

   // Execute the insert statement
   //await db.execute(insertStatement, [row['id'],row['order_number'],order_date,delivery_date,row['sender_name'],row['sender_phone'],row['recipient_name'],row['recipient_phone'],row['total_price'],row['address'],row['notes'],row['username'],row['status'],row['baghdad_cities'],row['province']]);





 }
  check = await db.rawQuery('SELECT * FROM invoice;');
print("---------------------${check.length} ");

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


  nameController.text = name;
  phoneController.text = phone;




  nameD="اسم مالك الحساب :$name";

print("info: $name $decryptusr $phone");
  // Use the retrieved username and password as needed

  return 1;
}



Future<int> Checklogin(String username ,String password) async {

print("start check user:$username");



// var results = await conn.query("INSERT INTO `users` (`id`, `userid`, `username`, `password`) VALUES ('3', '3', 'hassan', 'Ha123456789');");
//var result = await conn.query('SELECT * FROM accounts WHERE username="$username";');
await fetchData('SELECT * FROM accounts WHERE username="$username"',1);
bool okuser=false;



  for (int c=0;c<dataH.length;c++){

    print("{id: ${dataH[c]['id']},accountname: ${dataH[c]['accountname']},username: ${dataH[c]['username']},password: ${dataH[c]['username']}}");

    checkPassword("${dataH[c]['password']}", "$password");
    if(dataH[c]['username']==username && checkpass )
    {
      okuser=true;

    }
  }


  if(okuser)
  return 1;

  else
    return 0;


}

Future<int> UpdateRow(String table ,String id1,int status1) async {



 await fetchData('UPDATE $table SET status = $status1 WHERE id = $id1',0);
  //await conn.query('UPDATE $table SET status = $status1 WHERE id = $id1;');





  return 0;


}


Future<int> DeleteRow(String table ,int id1) async {





//await conn.query('DELETE FROM $table WHERE id = $id1;');
 await fetchData('DELETE FROM $table WHERE id = $id1',0);




    return 0;


}
Future<int> getCounts() async {
  numbers = [0, 0, 0, 0, 0, 0, 0, 0, 0];

 var check = await db.rawQuery('SELECT * FROM invoice;');
  for (int c=0;c<check.length;c++){

for(int p=1;p<StatusN.length-1;p++)

    if(check[c]['status']==StatusN[p])
      numbers[p]++;
 if(check[c]['status']==7 || check[c]['status']==8 || check[c]['status']==9 || check[c]['status']==90)
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








  print("$selectordertype  $decryptusr   1     111111111111111112");

   // result = await conn.query('SELECT * FROM  $table WHERE username="$decryptusr" ;');

 await fetchData('SELECT * FROM  $table WHERE username="$decryptusr" ',1);






  // print("$selectordertype     0     000000000000000");
 // print("result $o");




 await DBfilesinit();
  await getCounts();
  return 1;

}

Future<int> checkconnect() async {

  return 1;

}


Future<int> getOrdersData3() async {
  data =[];
  print("Hi 00000000000");
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