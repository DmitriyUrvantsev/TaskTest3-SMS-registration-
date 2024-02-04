import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/data/models/user/user_app.dart';
import 'package:form_registration/presentation/folder0_auth_screen/screens/k1_confirmation_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userName;
  String? pinCode; //!======
  static String verifyId = ""; //!===============

  UserApp? _userFromFirebaseUser(User? user) {
    return user != null ? UserApp(uid: user.uid) : null;
  }

  // аутентификация, изменение пользовательского потока(залогинился или нет (user!=null))
  Stream<UserApp?>? get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<String>? registerWithPhone(String phoneNumber, BuildContext context) {
    try {
      _auth.verifyPhoneNumber(
        //--------------------------
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        //--------------------------
        // verificationCompleted: (phoneAuthCredential) async {
        //   return;
        // },
        verificationCompleted: (AuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },

        //--------------------------
        // verificationFailed: (error) async {
        //   return;
        // },
        verificationFailed: (FirebaseAuthException e) {
          print('verificationFailed ERROR - $e');
        },

        //--------------------------
        codeSent: (String verificationId, int? forceResendingToken) async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return K1ConfirmationScreenWidget(
                    verificationId: verificationId);
              });
        },

        // codeAutoRetrievalTimeout: (String verificationId) {
        //   completer.complete("timeout");
        // },
        codeAutoRetrievalTimeout: (verificationId) async {
          //return;
        },
      );

      // return completer.future;
    } on Exception catch (error) {
      print('error.verifyPhoneNumber: ${error.toString()}');
    }
    return null;
  }

  ///---------------------выйти----------------------------------------
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print('error.toString() ${error.toString()}');
      return null;
    }
  }
}
