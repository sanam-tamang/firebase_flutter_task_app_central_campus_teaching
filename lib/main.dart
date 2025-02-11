import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_task_app/firebase_options.dart';
import 'package:new_task_app/pages/home_page.dart';
import 'package:new_task_app/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task app',
        home: FirebaseAuth.instance.currentUser != null
            ? HomePage()
            : LoginPage());
  }
}


///flutter clean
///
///flutter pub get