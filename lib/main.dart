import 'dart:io';
import 'package:employee_mango/view/add_campain.dart';
import 'package:employee_mango/view/add_reels.dart';
import 'package:employee_mango/view/campain_orders_details.dart';
import 'package:employee_mango/view/client_profile.dart';
import 'package:employee_mango/view/employee.dart';
import 'package:employee_mango/view/login.dart';
import 'package:employee_mango/view/reals_order_datails.dart';
import 'package:employee_mango/view/search.dart';
import 'package:employee_mango/view/notification.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:employee_mango/prov/prov.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('id');
  await Hive.openBox('name');
  await Hive.openBox('specialization');
  await Hive.openBox('email');
  await Hive.openBox('phone');
  await Hive.openBox('image');
  await Hive.openBox('salary');
  await Hive.openBox('token');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { 
    late Box tokenbox = Hive.box("token");
    return ChangeNotifierProvider(
        create: (context) {
          return control();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            "login": (context) => Login(),
            "employee": (context) => Employee(),
            "campainordersdetails": (context) => CampainOrdersDetails(),
            "realsorderdetails": (context) => RealsOrdersDetails(),
            "profileclient": (context) => ClientProfile(),
            "search":(context)=>Search(),
            "notification": (context)=>Notificat(),
            "addcampiagn":(context)=>AddCampiagn(),
            "addreels":(context)=>AddReels()
          },
          //home:Notificat(),
          home: tokenbox.get("token") == null ? Login() : Employee(),
        ));
  }
}
