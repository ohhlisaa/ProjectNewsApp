import 'package:flutter/material.dart';
import 'package:newsapp/screen/loginpage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsapp/model/account_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAccountModelAdapter());
  await Hive.openBox<UserAccountModel>("user");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //untuk menghilangkan Banner demo pada aplikasi kita
      debugShowCheckedModeBanner: false,
      //untuk menghilangkan warna background default
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>  LoginScreen(),
      },
    );
  }
}