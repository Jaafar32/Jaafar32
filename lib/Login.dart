

import 'package:encrypt_decrypt_plus/cipher/cipher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Loding.dart';
import 'functionPHP.dart';
import 'global.dart';




class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _HomePageState();
}


class _HomePageState extends State<Login> {


  _HomePageState();


  final userController = TextEditingController();
  final passController = TextEditingController();
  bool ckeckbox=true;
  String Status="";




  void initState() {

    super.initState();


  }
  Future<int> saveLoginData(String username, String password) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        context = context;
        return const Loading();
      },
    );
   await checkInternetConnection();
    if(isconnect==0)
{ setState(() {
  Status="لا يوجد اتصال";

});
return 0;}

   // var results = await conn.query("INSERT INTO `users` (`id`, `userid`, `username`, `password`) VALUES ('3', '3', 'hassan', 'Ha123456789');");
  await  fetchData('SELECT * FROM accounts WHERE username="$username"',1);

    bool okuser=false;
    SharedPreferences prefs = await SharedPreferences.getInstance();


if(!dataH.isEmpty)
    for (int c=0;c<dataH.length;c++){

      print("{id: ${dataH[c]['id']},accountname: ${dataH[c]['accountname']},username: ${dataH[c]['username']},password: ${dataH[c]['username']}}");
checkPassword("${dataH[c]['password']}", "$password");
      if(dataH[c]['username']==username && checkpass )

      {
        okuser=true;
        await prefs.setString('useridH', '${dataH[c]['id']}');
        await prefs.setString('nameH', '${dataH[c]['accountname']}');
        await prefs.setString('phoneH', '${dataH[c]['username']}');

      }
    }

print("login 111111111111111 $okuser");

    await prefs.setString('username', '');
    await prefs.setString('password', '');

    /*
    for(int i=0;i<users.length;i++)
    {

      if(users[i]==username && passwords[i]==password)
        okuser=true;
      print("{$username} {$password} ${users[i]} ${passwords[i]} $okuser");

      await prefs.setString('username', '');
      await prefs.setString('password', '');


    }
    */

    if( okuser){

      print("to save {$username} {$password} $okuser");
      Status="{$username} {$password}";
      if(ckeckbox){
        String encryptusr = cipher.xorEncode(username);
        String encryptpas = cipher.xorEncode(password);
        await prefs.setString('username', encryptusr);
        await prefs.setString('password', encryptpas);}

      String encryptusr = cipher.xorEncode(username);
      String encryptpas = cipher.xorEncode(password);
      await prefs.setString('usernameH', encryptusr);
      await prefs.setString('passwordH', encryptpas);


      SController.animateToPage(2, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);

    }
    else{


        print("no username and password");
        Status="اسم المستخدم او رمز المرور خطا";



    }
    Navigator.pop(context);
setState(() {

});

    return 1;
  }


  Future<void> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';


    if(username!='' && password!='' ) {

      String decryptusr = cipher.xorDecode(username);
      String decryptpas = cipher.xorDecode(password);

      Status = "{$username} {$password} {$decryptusr} {$decryptpas}";


      print("{$username} {$password} {$decryptusr} {$decryptpas}");


      // Use the retrieved username and password as needed
      setState(() {

      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0x1fffffff),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.zero,
          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      Status,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),),
              Align(
                alignment: Alignment.center,
                child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: AssetImage("Files/Photo/logo.jpeg"),
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 60,),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: TextField(
                  controller: userController,
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
                      borderSide: BorderSide(color: Color(0xff000000), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Color(0xff000000), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Color(0xff000000), width: 2),
                    ),
                    hintText: "اسم المستخدم",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                    filled: true,
                    fillColor: Color(0xfff2f2f3),
                    isDense: true,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    suffixIcon:
                    Icon(Icons.person, color: Color(0xff212435), size: 24),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  onSubmitted: (value) {
                    saveLoginData(userController.text, passController.text);
                  },
                  controller: passController,
                  obscureText: passowrdshow,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Color(0xff000000), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Color(0xff000000), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Color(0xff000000), width: 2),
                    ),
                    hintText: "كلمة السر",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                    filled: true,
                    fillColor: Color(0xfff2f2f3),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    suffixIcon:
                    InkWell(onTap: () {
                      passowrdshow=!passowrdshow;
                    },child: Icon(Icons.vpn_key, color: Color(0xff212435), size: 24)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Checkbox(
                    onChanged: (value) {

                      setState(() {
                        ckeckbox=!ckeckbox;
                      });


                    },
                    activeColor: Color(0xff3a57e8),
                    autofocus: false,
                    checkColor: Color(0xffffffff),
                    hoverColor: Color(0x42000000),
                    splashRadius: 20,
                    value: ckeckbox,
                  ),
                  Text(
                    "حفظ",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        saveLoginData(userController.text, passController.text);
                        print("jok_${checkconnect()}");
                      },
                      color: Color(0xff1a39ff),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      textColor: Color(0xffffffff),
                      height: 40,
                      minWidth: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

