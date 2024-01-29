import 'dart:async';


import 'package:flutter/material.dart';
import 'package:form_registration/presentation/f2_main_screen/scr2_main_screens/k2_main_screen.dart';
import 'package:form_registration/registration/provider/sin_in.dart';

import 'package:form_registration/registration/utils/config.dart';
import 'package:form_registration/registration/utils/next_screen.dart';
import 'package:form_registration/registration/utils/screens/home_screen.dart';
import 'package:form_registration/registration/utils/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    // create a timer of 2 seconds
    Timer(const Duration(seconds: 2), () {
      sp.isSignedIn == false
          ? nextScreen(context, const LoginScreen())
          : nextScreen(context,  HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      
      
      SafeArea(
        child: Center(
            child: Placeholder()
        ),
      ),
      
    );
  }
}