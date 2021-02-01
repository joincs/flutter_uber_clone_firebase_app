import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './mainscreen.dart';
import '../main.dart';
import './registrationScreen.dart';
import '../widgets/progressDailog.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = 'login';

  TextEditingController _emailtextEditingController = TextEditingController();
  TextEditingController _passwordtextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 35.0,
              ),
              Image(
                image: AssetImage('assets/images/logo.png'),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 1.0,
              ),
              Text(
                'Login as a Rider',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Brand Bold",
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: _emailtextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    // ######## Password ########
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: _passwordtextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    // ###### Login Button ##########
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      onPressed: () {
                        if (!_emailtextEditingController.text.contains('@')) {
                          Fluttertoast.showToast(
                              msg: "Email address is not valid");
                        } else if (_passwordtextEditingController.text.length <
                            6) {
                          Fluttertoast.showToast(
                              msg: "Password must be at least 6 characters");
                        } else {
                          loginAndAuthenticateUser(context);
                        }
                      },
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RegistrationScreen.idScreen, (route) => false);
                },
                child: Text("Do not have an Account? Register Here."),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressDialog(
        message: "Authenticating, Please wait...",
      ),
    );
    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
      email: _emailtextEditingController.text,
      password: _passwordtextEditingController.text,
    )
            .catchError((errMsg) {
      Navigator.of(context).pop(context);
      Fluttertoast.showToast(msg: "Error: " + errMsg.toString());
    }))
        .user;
    if (firebaseUser != null) {
      // save user info to database
      usersRef.child(firebaseUser.uid).once().then(
        (DataSnapshot snap) {
          if (snap.value != null) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(MainScreen.idScreen, (route) => false);
            Fluttertoast.showToast(msg: "You are logged In now.");
          } else {
            Navigator.of(context).pop(context);
            _firebaseAuth.signOut();
            Fluttertoast.showToast(
                msg:
                    "No record exists for this user. Please create new account.");
          }
        },
      );
    } else {
      Navigator.of(context).pop(context);
      Fluttertoast.showToast(msg: "Error Occured, cannot be Signed In.");
    }
  }
}
