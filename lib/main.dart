import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/mainscreen.dart';
import './screens/loginScreen.dart';
import './screens/registrationScreen.dart';
import './DataHandler/appData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child('users');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => AppData(),
      child: MaterialApp(
        title: 'Rider App',
        theme: ThemeData(
          fontFamily: 'Brand Regular',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? LoginScreen()
            : MainScreen(),
        routes: {
          RegistrationScreen.idScreen: (ctx) => RegistrationScreen(),
          LoginScreen.idScreen: (ctx) => LoginScreen(),
          MainScreen.idScreen: (ctx) => MainScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
