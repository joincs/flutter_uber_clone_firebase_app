import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/screens/loginScreen.dart';
import './divider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 255.0,
      child: Drawer(
        child: ListView(
          children: [
            Container(
              height: 165.0,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/user_icon.png',
                      height: 65.0,
                      width: 65.0,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Proile Name",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Brand-Bold',
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text("Visit Profile"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CustomDivider(),
            SizedBox(height: 12.0),
            ListTile(
              leading: Icon(Icons.history),
              title: Text(
                "History",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "Visit Profile",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "About",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.idScreen, (route) => false);
              },
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
