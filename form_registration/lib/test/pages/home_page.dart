import 'package:flutter/material.dart';
import 'package:form_registration/test/controllers/auth_service.dart';
import 'package:form_registration/test/pages/login_page.dart';
// import 'package:phone_auth_firebase_tutorial/controllers/auth_service.dart';
// import 'package:phone_auth_firebase_tutorial/main.dart';
// import 'package:phone_auth_firebase_tutorial/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Great you are now logged in."),
          SizedBox(
            height: 20,
          ),
          OutlinedButton(
              onPressed: () {
                AuthService1.logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text("Logout"))
        ],
      )),
    );
  }
}