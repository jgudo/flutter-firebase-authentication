import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobily/model/auth.dart';
import 'package:mobily/model/user.dart';
import 'package:mobily/screens/home.dart';
import 'package:mobily/screens/login.dart';
import 'package:mobily/screens/signup.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: PageController(),
      routes: <String, WidgetBuilder> {
        Login.route: (_) => Login(),
        Home.route: (_) => Home(),
        SignUp.route: (_) => SignUp()
      }
    );
  }
}

class PageController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);

    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : Login();
        }

        return Center(
          child: CircularProgressIndicator()
        );
      },
    );
  }
}
