import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterly_bloc_auth/application/features/auth/views/login_view.dart';
import 'package:flutterly_bloc_auth/application/features/home/home_view.dart';
import 'package:flutterly_bloc_auth/firebase_options.dart';

import 'application/features/auth/views/user_register_view.dart';
import 'application/features/splash/splash_view.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
          bodySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
        ),
        scaffoldBackgroundColor: Color(0xfff263147),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',

      routes: {

        '/': (context) => SplashPageWrapper(),
        '/login': (context) => LoginViewWrapper(),
        '/home': (context) => HomePageWrapper(),
        '/register': (context) => RegisterPageWrapper()
      },
    );
  }
}

