import 'package:encrypt_decrypt_plus/cipher/cipher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Home.dart';
import 'Login.dart';
import 'functionPHP.dart';
import 'global.dart';




String ChPermission='',location='';



void requestMultiplePermissions() async {


  Map<Permission, PermissionStatus> statuses  = await [
    Permission.storage,
    Permission.location,
    Permission.manageExternalStorage,
    Permission.photos,
    Permission.videos,
    Permission.accessMediaLocation,
    Permission.mediaLibrary

  ].request();
  //print("#####################################################");
  ChPermission='${statuses[Permission.storage]}';

  //print("storage permission: ${statuses[Permission.storage]}");



  print("storage permission: ${statuses[Permission.storage]}");
  print("location permission: ${statuses[Permission.location]}");
  print("manageExternalStorage permission: ${statuses[Permission.manageExternalStorage]}");
  print("photos permission: ${statuses[Permission.photos]}");
  print("accessMediaLocation permission: ${statuses[Permission.accessMediaLocation]}");
  print("videos permission: ${statuses[Permission.videos]}");
  print("mediaLibrary permission: ${statuses[Permission.mediaLibrary]}");


  print("#####################################################");
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) { location='Denied';
    print('Location permissions are denied');

    }
    else if(permission == LocationPermission.deniedForever){location='Denied';
    print("'Location permissions are permanently denied");

    }else{ location='Granted';
    print("GPS Location service is granted");

    }
  }else{location='Granted';
  print("GPS Location permission granted.");

  }
  if(location.contains("Denied"))
    print("####################   0000   ####################");
}








void main() async  {

  runApp(MyApp());


}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: second(),
    );
  }
}

class second  extends StatefulWidget {
  @override
  State<second > createState() => _MyTextEditState();
}

class _MyTextEditState extends State<second > {


  final userController = TextEditingController();
  final passController = TextEditingController();
bool ckeckbox=true;
String Status="";
  Future<void> waitFinitState() async {
    await getLoginData2();
    await getDataorders("invoice");
    isconnect=1;
    firstopen=1;

    SController.animateToPage(2, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);

    //await DBfilesinit();

  }



  void initState() {

    super.initState();
   // fetchData('SELECT * FROM  invoice WHERE username=07757582755 ',1);

    CheckLoginData();

  }


  Future<void> CheckLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';

    print("Hi");



    if((username!='' && password!='' )) {

  String decryptusr = cipher.xorDecode(username);
  String decryptpas = cipher.xorDecode(password);

  Status = "{$username} {$password} {$decryptusr} {$decryptpas}";


  print("{$username} {$password} {$decryptusr} {$decryptpas}");


  // Use the retrieved username and password as needed
  setState(() {

  });
  waitFinitState();

    }
    else{

      SController.animateToPage(1, duration: const Duration(microseconds: 1000), curve: Curves.easeIn);

    }

  }




  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: SController,

      onPageChanged: (int page){
        //print("Current Page: " + page.toString());
        int previousPage = page;
        if(page != 0) previousPage--;
        else previousPage = 2;


print(page);

      },
        children: [
          Scaffold(
          backgroundColor: Color(0xffffffff),
          body: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xff3a57e8),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: Color(0x4d9e9e9e), width: 1),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: AssetImage("Files/Photo/logo.jpeg"),
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment(0.0, 1.0),
                  child: Text(
                    "توصيل السريع",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 22,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ],
            ),
          ),
              ),

          Login(),
          Home(),

        ],
      );;
  }
}
