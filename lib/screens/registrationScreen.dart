import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './mainscreen.dart';
import '../main.dart';
import './loginScreen.dart';
import '../widgets/progressDailog.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = 'register';

  TextEditingController _nametextEditingController = TextEditingController();
  TextEditingController _phonetextEditingController = TextEditingController();
  TextEditingController _emailtextEditingController = TextEditingController();
  TextEditingController _passwordtextEditingController =
      TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ProgressDialog(
        message: "Registering, Please wait...",
      ),
    );
    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
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
      Map userDataMap = {
        "name": _nametextEditingController.text.trim(),
        "phone": _phonetextEditingController.text.trim(),
        "email": _emailtextEditingController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      Fluttertoast.showToast(
          msg: "Congratulation, your acount has been created");
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainScreen.idScreen, (route) => false);
    } else {
      Navigator.of(context).pop(context);
      //error occured - display error message
      Fluttertoast.showToast(msg: "New user account has not been created");
    }
  }

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
                height: 20.0,
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
                'Register as a Rider',
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
                      controller: _nametextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
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
                    // ######### Phone No #########
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: _phonetextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone",
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
                    // ##### Email #########
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
                            "Create Account",
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
                        if (_nametextEditingController.text.length < 3) {
                          Fluttertoast.showToast(
                              msg: "Name must be at least 3 characters");
                        } else if (!_emailtextEditingController.text
                            .contains('@')) {
                          Fluttertoast.showToast(
                              msg: "Email address is not valid");
                        } else if (_phonetextEditingController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Phone Number is mandatory");
                        } else if (_passwordtextEditingController.text.length <
                            6) {
                          Fluttertoast.showToast(
                              msg: "Password must be at least 6 characters");
                        } else {
                          registerNewUser(context);
                        }
                      },
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.idScreen, (route) => false);
                },
                child: Text("Already have an Account? Login Here."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
