import 'package:encrypt_decrypt_plus/cipher/cipher.dart';
import 'package:flutter/cupertino.dart';

import 'package:mysql1/mysql1.dart';

import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class GlobalReflectable extends Reflectable {
  const GlobalReflectable() : super();
}

@GlobalReflectable()
List<Map<String, dynamic>> data=[];
List<Map<String, dynamic>> dataH = [];
List<Map<String, dynamic>> invoiceview=[];

final findController = TextEditingController();
final userController = TextEditingController();
final passController = TextEditingController();
final dateController = TextEditingController();
final nameController = TextEditingController();
final phoneController = TextEditingController();
final SaleController = TextEditingController();
final nameTController = TextEditingController();

final phoneTController = TextEditingController();
final addressTController = TextEditingController();
final notesTController = TextEditingController();

int firstopen=0;
int SelectI=-1;
int isconnect=0;
int selectcoloer=0;
bool updating=false;
int updatingC=0;
bool updatingW=false;
bool checkpass=false;
bool passowrdshow=false;
String selectedText=' طلباتي';
int selectedIndex = 0;
final SController = PageController();
final HController = PageController();
final OController = PageController();
var result;
List<int> color = <int>[0xFF927BC4,0xFF4E733D,0xFFDC8686,0x88265073,0xFfF4DFC8,0xFFA2A378,0x86007EFF,0xFFE08E6D,0xFF4E733D];
List<int> colorgrid = <int>[0xFFC6ABFF,0xFF9ADE7B,0xFFDC8686,0x88265073,0xFfF4DFC8,0xFFA2A378,0x86007EFF,0xFFE08E6D,0xFF9ADE7B];

Cipher cipher = Cipher(secretKey: "jok51744");
int selectordertype = 0;
var globalVariable = "Hello, I'm a global variable!";
List<int> StatusN = <int>[0,1,20,2,3,4,5,6,100];

List<int> numbers = [0, 0, 0, 0, 0, 0, 0, 0, 0];


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
int hh=0;

final path = 'Files/database/database.db';
late Database db;

//String host = '192.254.237.211';
//String host = "http://192.168.192.1/sql2.php?functionName=fetchData&sql=";
//String host = "http://192.168.192.1/sql1.php?functionName=fetchData&sql=";
String host = "https://jok51744.000webhostapp.com/sql.php?functionName=fetchData&sql=";

var settings = new ConnectionSettings(
    host: '$host',
    port: 3306,
    user: 'sultaraq_zeopost',
    password: 'zeopost1984\$',
    db: 'sultaraq_zeopost'
);

var conn ;
const List<String> list2 = <String>[
  "1بغداد",
  "1الموصل",
  "1بصرة",
  "1اربيل",
  "1سليمانية",
  "1دهوك",
  "1كركوك",
  "1حلبجة",
  "1واسط",
  "1ديالى",
  "1القادسية",
  "النجف1",
  "بابل1",
  "1كربلاء",
  "المثنى1",
  "1صلاح الدين",
  "1ذي قار",
  "1الانبار",
  "1ميسان",];
const List<String> list = <String>["بغداد",
  "الموصل",
  "بصرة",
  "اربيل",
  "سليمانية",
  "دهوك",
  "كركوك",
  "حلبجة",
  "واسط",
  "ديالى",
  "القادسية",
  "النجف",
  "بابل",
  "كربلاء",
  "المثنى",
  "صلاح الدين",
  "ذي قار",
  "الانبار",
  "ميسان",];
String dropdownValue1 = list.first;int dro1=0;
String dropdownValue2 = list2.first;int dro2=0;